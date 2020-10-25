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
        self.viewModel = .init(interval: interval)
        self._selectedMonth = selectedMonth
        self.mode = mode
        self.content = content
    }
    
    var viewModel: FlexibleCalenderViewModel
    var mode: CalenderMode
    let content: (Date) -> DateView
    @Binding var selectedMonth: Date
    
    var body: some View {
        
        VStack {
            if mode == .month {
                
                TabView(selection: $selectedMonth) {
                    
                    ForEach(viewModel.months, id: \.self) { month in
                        
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
                            
                            ForEach(viewModel.days(for: month), id: \.self) { date in
                                if viewModel.calendar.isDate(date, equalTo: month, toGranularity: .month) {
                                    content(date).id(date)
                                } else {
                                    content(date).hidden()
                                }
                            }
                        }
                        .background(Color.green)
                        //Fixme
                        .frame(width: 400, alignment: .center)
                        .tag(month)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
            } else {
                
                VStack {
                    
                    TabView(selection: $selectedMonth) {
                        
                        ForEach(viewModel.weeks, id: \.self) { week in
                            
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
                                
                                ForEach(viewModel.days(forWeek: week), id: \.self) { date in
                                    if viewModel.calendar.isDate(date, equalTo: week, toGranularity: .month) {
                                        content(date).id(date)
                                    } else {
                                        content(date)
                                            .opacity(0.5)
                                    }
                                }
                            }
                            .background(Color.yellow)
                            //Fixme
                            .frame(width: 400, height: 200, alignment: .center)
                            .tag(week)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                }
            }
        }
    }
    
    //MARK: constant and supportive methods
    
    
}

struct CalendarView_Previews: PreviewProvider {
    
    @State static var selectedMonthDate = Date()
    
    static var previews: some View {
        VStack {
            Text(selectedMonthDate.description)
            HStack {
                ForEach(Calendar.current.veryShortWeekdaySymbols, id: \.self) { item in
                    Spacer()
                    Text(item)
                        .bold()
                    Spacer()
                    
                }
            }
            
            FlexibleCalenderView(interval: .init(start: Date.getDate(from: "2020 01 11")!, end: Date.getDate(from: "2020 12 11")!), selectedMonth: $selectedMonthDate, mode: .month) { date in
                
                Text(date.day)
                    .padding(8)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
        }
        
    }
}



