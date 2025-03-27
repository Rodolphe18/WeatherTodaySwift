//
//  ContentView.swift
//  WeatherTodaySwift
//
//  Created by Rodolphe on 27/03/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            Color(.blue).edgesIgnoringSafeArea(.all)
            VStack {
                        Image(systemName: "globe")
                            .imageScale(.large)
                            .foregroundStyle(.tint)
                        Text("Hello, world!")
                    }
                    .padding()
        }
        
    }
}

#Preview {
    ContentView()
}
