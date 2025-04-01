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
                Text(WeatherType.shared.getWeatherType(code: homeViewModel.currentWeather?.weatherCode ?? 0)[0])
                Image(systemName: WeatherType.shared.getWeatherType(code: homeViewModel.currentWeather?.weatherCode ?? 0)[1])
                    .symbolRenderingMode(.multicolor)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(homeViewModel.hourlyWeather, id: \.self) { hourly in
                            Text(String(hourly.temperatureCelsius))
                        }
                    }.frame(height: 100)
                }
            }
                
            
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


