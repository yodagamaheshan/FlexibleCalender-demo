//
//  FlexibleCalenderView.swift
//  FlexibleCalender
//
//  Created by Heshan Yodagama on 10/22/20.
//

import SwiftUI

struct FlexibleCalenderView<DateView>: View where DateView: View {
    
    /// Description
    /// - Parameters:
    ///   - interval:
    ///   - selectedMonth: date relevent to showing month, then you can extract the componnets
    ///   - content:
    init(interval: DateInterval, selectedMonth: Binding<Date>, mode: CalenderMode, @ViewBuilder content: @escaping (Date) -> DateView) {
        self.interval = interval
        self._selectedMonth = selectedMonth
        self.mode = mode
        self.content = content
    }
    
    @Environment(\.calendar) var calendar
    let interval: DateInterval
    var mode: CalenderMode
    let content: (Date) -> DateView
    @Binding var selectedMonth: Date
    
    var body: some View {
        
        TabView(selection: $selectedMonth) {
            
            ForEach(months, id: \.self) { month in
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
                    ForEach(days(for: month), id: \.self) { date in
                        if calendar.isDate(date, equalTo: month, toGranularity: .month) {
                            content(date).id(date)
                        } else {
                            content(date).hidden()
                        }
                    }
                }
                //Fixme
                .frame(width: 400, alignment: .center)
                .tag(month)
            }
            
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        
    }
    
    private var months: [Date] {
        calendar.generateDates( inside: interval,matching: DateComponents(day: 1, hour: 0, minute: 0, second:0)
        )
    }
    
    
    
    private func days(for month: Date) -> [Date] {
        guard
            let monthInterval = calendar.dateInterval(of: .month, for: month),
            let monthFirstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start),
            let monthLastWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.end)
        else { return [] }
        return calendar.generateDates( inside: DateInterval(start: monthFirstWeek.start, end: monthLastWeek.end), matching: DateComponents(hour: 0, minute: 0, second: 0)
        )
    }
}
struct CalendarView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        FlexibleCalenderView(interval: .init(start: Date.getDate(from: "2019 08 11")!, end: Date.getDate(from: "2021 08 11")!), selectedMonth: .constant(Date()), mode: .month) { date in
            
            Text(date.day)
                .padding(8)
                .background(Color.blue)
                .cornerRadius(8)
        }
    }
}



fileprivate extension DateFormatter {
    static var month: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter
    }
    static var monthAndYear: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }
}
fileprivate extension Calendar {
    func generateDates(inside interval: DateInterval, matching components: DateComponents) -> [Date] {
        var dates: [Date] = []
        dates.append(interval.start)
        enumerateDates(startingAfter: interval.start, matching: components, matchingPolicy: .nextTime) { date, _, stop in
            if let date = date {
                if date < interval.end {
                    dates.append(date)
                } else {
                    stop = true
                }
            }
        }
        return dates
    }
}

