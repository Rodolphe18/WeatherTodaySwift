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
        ZStack {
            LinearGradient(gradient: Gradient(colors:[.blue, .white]), startPoint: .topLeading, endPoint: .bottomTrailing)
            VStack {
                Text(String(homeViewModel.hourlyWeather?.hourly.wind_speed_10m[0] ?? 0))
                Text(String(homeViewModel.hourlyWeather?.hourly.temperature_2m[0] ?? 0.00))
                Text(homeViewModel.hourlyWeather?.hourly.time[0] ?? "")
                Text(WeatherType.shared.getWeatherType(code: homeViewModel.currentWeather?.current.weather_code ?? 0)[0])
                
                Image(systemName: WeatherType.shared.getWeatherType(code: homeViewModel.currentWeather?.current.weather_code ?? 0)[1])
                    .symbolRenderingMode(.multicolor)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 180, height: 180)
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
}


