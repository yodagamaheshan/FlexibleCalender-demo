//
//  ContentView.swift
//  FlexibleCalender
//
//  Created by Heshan Yodagama on 10/22/20.
//

import SwiftUI

struct ContentView: View {
    @State var selectedMonthDate = Date()
    @State var mode = CalenderMode.month
    var body: some View {
        VStack {
            Text(selectedMonthDate.description)
            FlexibleCalenderView(interval: .init(start: Date.getDate(from: "2019 08 11")!, end: Date.getDate(from: "2021 08 11")!), selectedMonth: $selectedMonthDate, mode: mode) { date in
                
                Text(date.day)
                    .padding(8)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
