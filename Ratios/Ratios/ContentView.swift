//
//  ContentView.swift
//  Ratios
//
//  Created by John Peden on 2/26/20.
//  Copyright © 2020 John Peden. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            CoffeeInput()
            
            Divider()
                .background(Color("Primary"))
                .frame(width: CGFloat(267))
            
            WaterInput()

            Divider()
            .background(Color("Primary"))
            .frame(width: CGFloat(267))

            TimerView()

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
