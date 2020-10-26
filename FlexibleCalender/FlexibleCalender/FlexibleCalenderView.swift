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
        self.viewModel = .init(interval: interval, mode: mode)
        self._selectedMonth = selectedMonth
        self.content = content
    }
    
    var viewModel: FlexibleCalenderViewModel
    let content: (Date) -> DateView
    @Binding var selectedMonth: Date
    //TODO: get the maximum from 2 of htis
    @State private var cellContainerSize: CGSize = .init(width: 30, height: 200)
    @State private var contentCellSize: CGSize = .init(width: 30, height: 1)
    
    var body: some View {
        
        VStack {
            if viewModel.mode == .month {
                
                TabView(selection: $selectedMonth) {
                    
                    ForEach(viewModel.months, id: \.self) { month in
                        
                        VStack {
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: numberOfDayasInAWeek), spacing: 0) {
                                
                                ForEach(viewModel.days(for: month), id: \.self) { date in
                                    if viewModel.calendar.isDate(date, equalTo: month, toGranularity: .month) {
                                        content(date).id(date)
                                            .background(
                                                GeometryReader(content: { (proxy: GeometryProxy) in
                                                    Color.clear
                                                        .preference(key: MyPreferenceKey.self, value: MyPreferenceData(size: proxy.size))
                                                }))
                                        
                                    } else {
                                        content(date).hidden()
                                    }
                                }
                            }
                            .onPreferenceChange(MyPreferenceKey.self, perform: { value in
                                contentCellSize = value.size
                            })
                            .background(Color.green)
                            .tag(month)
                            //Tab view frame alignment to .Top didnt work dtz y
                            Spacer()
                        }
                    }
                }
                .frame(height: contentCellSize.height * 6, alignment: .center)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
            } else {
                
                VStack {
                    
                    TabView(selection: $selectedMonth) {
                        
                        ForEach(viewModel.weeks, id: \.self) { week in
                            
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: numberOfDayasInAWeek)) {
                                
                                ForEach(viewModel.days(forWeek: week), id: \.self) { date in
                                    if viewModel.calendar.isDate(date, equalTo: week, toGranularity: .month) {
                                        content(date).id(date)
                                            .background(
                                                GeometryReader(content: { (proxy: GeometryProxy) in
                                                    Color.clear
                                                        .preference(key: MyPreferenceKey.self, value: MyPreferenceData(size: proxy.size))
                                                }))
                                    } else {
                                        content(date)
                                            .opacity(0.5)
                                    }
                                }
                            }
                            .onPreferenceChange(MyPreferenceKey.self, perform: { value in
                                contentCellSize = value.size
                            })

                            .background(Color.yellow)
                            .tag(week)
                        }
                    }
                    //Fixme
                    
                    .frame(height: contentCellSize.height * 1, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                }
            }
        }
    }
    
    //MARK: constant and supportive methods
    let numberOfDayasInAWeek = 7
    
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
            
            FlexibleCalenderView(interval: .init(start: Date.getDate(from: "2020 01 11")!, end: Date.getDate(from: "2020 12 11")!), selectedMonth: $selectedMonthDate, mode: .week) { date in
                
                Text(date.day)
                    .padding(8)
                    .background(Color.blue)
                    .cornerRadius(8)
                    .padding([.bottom], /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            }
        }
        
    }
}


//Key
fileprivate struct MyPreferenceKey: PreferenceKey {
    static var defaultValue: MyPreferenceData = MyPreferenceData(size: CGSize.zero)
    
    
    static func reduce(value: inout MyPreferenceData, nextValue: () -> MyPreferenceData) {
        value = nextValue()
    }
    
    typealias Value = MyPreferenceData
}

//Value
fileprivate struct MyPreferenceData: Equatable {
    let size: CGSize
    //you can give any name to this variable as usual.
}
