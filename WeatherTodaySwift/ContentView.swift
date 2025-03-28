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
            Text(String(homeViewModel.hourlyWeather?.hourly.wind_speed_10m[0] ?? 0))
            Text(String(homeViewModel.hourlyWeather?.hourly.temperature_2m[0] ?? 0.00))
            Text(homeViewModel.hourlyWeather?.hourly.time[0] ?? "")
            Text(String(homeViewModel.currentWeather?.current.precipitation ?? 0))
        }.task {
            do {
               try await homeViewModel.getCurrentWeather()
            } catch{
                
            }
        }.task {
            do {
                try await homeViewModel.getDailyWeather()
            } catch{
                
            }
        }.task {
            do {
                try await homeViewModel.getHourlyWeather()
            } catch{
                
            }
        }
        
    }
}


