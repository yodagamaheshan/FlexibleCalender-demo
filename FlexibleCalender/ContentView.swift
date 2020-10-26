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
            Text(selectedMonthDate.description)
            FlexibleCalenderView(interval: .init(start: Date.getDate(from: "2020 01 11")!, end: Date.getDate(from: "2020 12 11")!), selectedMonth: $selectedMonthDate, mode: mode) { date in
                
                DateCell1(date: date)
            }
            HStack {
                Button("Month") {
                    mode = .month(estimateHeight: 400)
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
