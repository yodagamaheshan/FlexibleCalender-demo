//
//  ContentView.swift
//  FlexibleCalender
//
//  Created by Heshan Yodagama on 10/22/20.
//

import SwiftUI

struct ContentView: View {
    @State var selectedMonthDate = Date()
    @State var mode = CalenderMode.week
    var body: some View {
        VStack {
            Text(selectedMonthDate.description)
            FlexibleCalenderView(interval: .init(start: Date.getDate(from: "2019 08 11")!, end: Date.getDate(from: "2021 08 11")!), selectedMonth: $selectedMonthDate, mode: mode) { date in
                
                DateCell(date: date)
            }
            Button("Change mode") {
                mode = (mode == .month ? CalenderMode.week:.month)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct DateCell: View {
    @State private var isShown = false
    let date: Date
    
    var body: some View {
        VStack {
            if isShown {
                Text(date.day)
                    .padding(8)
                    .background(Color.blue)
                    .cornerRadius(20)
                    .transition(AnyTransition.scale.animation(Animation.spring().delay(Double(date.day)!/30)))
                
            } else {
                Text("")
                    .onAppear(perform: {
                        withAnimation {
                            isShown = true
                        }
                    })
            }
        }
    }
}
