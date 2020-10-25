//
//  SwiftUIViewTest.swift
//  FlexibleCalender
//
//  Created by Heshan Yodagama on 10/22/20.
//

import SwiftUI

struct SwiftUIViewTest: View {
    
    var body: some View {
        VStack {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 7), content: /*@START_MENU_TOKEN@*/{
                ForEach(0 ..< 20) { item in
                    Text("Placeholder")
                }
            }/*@END_MENU_TOKEN@*/)
            Rectangle()
        }
    }
}

struct SwiftUIViewTest_Previews: PreviewProvider {
    
    static var previews: some View{
        SwiftUIViewTest()
    }
}
