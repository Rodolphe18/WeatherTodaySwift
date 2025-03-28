//
//  ContentView.swift
//  WeatherTodaySwift
//
//  Created by Rodolphe on 27/03/2025.
//

import SwiftUI
import UIKit

struct ContentView: View {
    
    @StateObject private var homeViewModel = HomeViewModel()
    
    var body: some View {
        VStack {
            Text(String(homeViewModel.currentWeather?.current.apparent_temperature ?? 0.00))
            Text(String(homeViewModel.currentWeather?.current.temperature_2m ?? 0.00))
            Text(String(homeViewModel.currentWeather?.current.wind_speed_10m ?? 0.00))
            Text(String(homeViewModel.currentWeather?.current.precipitation ?? 0))
        }.task {
            do {
                try await homeViewModel.getCurrentWeather()
            
            } catch{
                
            }
        }
        
    }
}


