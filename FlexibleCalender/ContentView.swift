//
//  ContentView.swift
//  FlexibleCalender
//
//  Created by Heshan Yodagama on 10/22/20.
//

import SwiftUI

struct ContentView: View {
    @State var selectedMonthDate = Date()
    @State var mode = CalenderMode.week(estimateHeight: 400)
    var body: some View {
        VStack {
            Text(DateFormatter.monthAndYear.string(from: selectedMonthDate))
                .font(.title)
                .fontWeight(.bold)
            HStack {
                ForEach(Calendar.current.veryShortWeekdaySymbols, id: \.self) { item in
                    Spacer()
                    Text(item)
                        .bold()
                    Spacer()
                    
                }
            }
            
            DateStack(interval: .init(start: Date.getDate(from: "2020 01 11")!, end: Date.getDate(from: "2020 12 11")!), selectedMonth: $selectedMonthDate, mode: mode) { date in
                
                DateCell1(date: date)
            }
            .padding()
            
            HStack {
                Button("Month") {
                    mode = .month(estimateHeight: 400)
                    selectedMonthDate = Date()
                }
                Button("Week") {
                    mode = .week(estimateHeight: 50)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
