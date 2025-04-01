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
    
    func HourTimeFormatter(value:String) -> Int {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        return calendar.component(.hour, from: dateFormatter.date(from:value) ?? Date())
    }
    
    func DayFormatter(value:String) -> String {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return " \(calendar.component(.day, from: dateFormatter.date(from:value) ?? Date())) / \(calendar.component(.month, from: dateFormatter.date(from:value) ?? Date())) "
    }
    

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
                
                Text("Dans les prochaines heures")
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(homeViewModel.hourlyWeather, id: \.self) { hourly in
                            VStack {
                                
                                Text(String(HourTimeFormatter(value: hourly.time)) + "h")
                                Text(String(hourly.temperatureCelsius))
                                Image(systemName: WeatherType.shared.getWeatherType(code: hourly.weatherCode)[1])
                                                                .symbolRenderingMode(.multicolor)
                                                                .resizable()
                                                                .aspectRatio(contentMode: .fit)
                                                                .frame(width: 30, height: 30)
                            }.frame(width: 60, height: 60, alignment: .center)
                            
                        }
                    }.frame(height: 100)
                }
                Text("Dans les jours à venir")
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(homeViewModel.dailyWeather, id: \.self) { daily in
                            VStack {
                                Text(String(DayFormatter(value: daily.time)))
                                Text(String(daily.temperatureMax))
                                Image(systemName: WeatherType.shared.getWeatherType(code: daily.weatherCode)[1])
                                                                .symbolRenderingMode(.multicolor)
                                                                .resizable()
                                                                .aspectRatio(contentMode: .fit)
                                                                .frame(width: 30, height: 30)
                            }.frame(width: 60, height: 60, alignment: .center)
                        }
                    }.frame(height: 100)
                }
                
            }.frame(alignment: .top)
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


