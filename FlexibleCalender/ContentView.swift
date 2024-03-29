//
//  ContentView.swift
//  FlexibleCalender
//
//  Created by Heshan Yodagama on 10/22/20.
//

import SwiftUI
import DateGrid

struct ContentView: View {
    @State var selectedMonthDate = Date()
    @State var mode = CalendarMode.month(estimateHeight: 400)
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

            DateGrid(
                interval: .init(
                    start: Date.getDate(from: "2020 01 11")!,
                    end: Date.getDate(from: "2020 12 11")!
                ),
                selectedMonth: $selectedMonthDate,
                mode: mode
            ) { dateGridDate in

                DateCell1(date: dateGridDate.date)
            }
            .padding()

            HStack {
                Button("Month") {
                    withAnimation {
                        mode = .month(estimateHeight: 400)
                    }

                }
                Button("Week") {
                    withAnimation {
                        mode = .week(estimateHeight: 100)
                    }

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
