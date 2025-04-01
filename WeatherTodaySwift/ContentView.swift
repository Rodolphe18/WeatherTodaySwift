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
    
    func HourMinuteTimeFormatter(value:String) -> String {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        return " \(calendar.component(.hour, from: dateFormatter.date(from:value) ?? Date()))h\(calendar.component(.minute, from: dateFormatter.date(from:value) ?? Date()))"
    }
    
    func DayFormatter(value:String) -> String {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return " \(calendar.component(.day, from: dateFormatter.date(from:value) ?? Date()))  \(calendar.component(.month, from: dateFormatter.date(from:value) ?? Date())) "
    }
    

    var body: some View {
        ZStack() {
            LinearGradient(gradient: Gradient(colors:[.blue, .cyan]), startPoint: .topLeading, endPoint: .bottomTrailing)
            VStack {
                Text(WeatherType.shared.getWeatherType(code: homeViewModel.currentWeather?.weatherCode ?? 0)[0]).font(.system(size: 32, weight: .medium, design: .default)).foregroundColor(.white)
                Image(systemName: WeatherType.shared.getWeatherType(code: homeViewModel.currentWeather?.weatherCode ?? 0)[1])
                    .symbolRenderingMode(.multicolor)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 70, height: 70)
                Text(String(homeViewModel.currentWeather?.temperatureCelsius ?? 0.00) + "°C").font(.system(size: 32, weight: .medium, design: .default)).foregroundColor(.white)
                Text("Dans les prochaines heures").frame(alignment: .leading).font(Font.title).foregroundColor(.white)
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(homeViewModel.hourlyWeather, id: \.self) { hourly in
                            VStack {
                                Text(String(HourTimeFormatter(value: hourly.time)) + "h").foregroundColor(.white)
                                Text(String(hourly.temperatureCelsius)).foregroundColor(.white)
                                Image(systemName: WeatherType.shared.getWeatherType(code: hourly.weatherCode)[1])
                                                                .symbolRenderingMode(.multicolor)
                                                                .resizable()
                                                                .aspectRatio(contentMode: .fit)
                                                                .frame(width: 30, height: 30)
                            }.frame(width: 60, height: 60, alignment: .center)
                            
                        }
                    }.frame(height: 100)
                }
                Text("Données météorogiques").frame(alignment: .leading).font(Font.title).foregroundColor(.white)
                VStack {
                    HStack {
                        VStack {
                            Text("Ressenti").foregroundColor(.white)
                            Text(String(homeViewModel.currentWeather?.apparentTemperature ?? 0.00)).foregroundColor(.white)
                            Text("Vitesse du vent").foregroundColor(.white)
                            Text(String(Int(homeViewModel.currentWeather?.windSpeed ?? 0.00)) + " km/h").foregroundColor(.white)
                            Text("Lever du soleil").foregroundColor(.white)
                            Text(HourMinuteTimeFormatter(value:homeViewModel.dailyWeather.first?.sunrise ?? "")).foregroundColor(.white)
                        }
                        Spacer().frame(width: 50)
                        VStack {
                            Text("Direction du vent").foregroundColor(.white)
                            Text(String(homeViewModel.currentWeather?.windDirection ?? 0)).foregroundColor(.white)
                            Text("Précipitation").foregroundColor(.white)
                            Text(String(homeViewModel.currentWeather?.precipitation ?? 0.00)).foregroundColor(.white)
                            Text("Coucher du soleil").foregroundColor(.white)
                            Text(HourMinuteTimeFormatter(value: homeViewModel.dailyWeather.first?.sunset ?? "")).foregroundColor(.white)
                        }
                    }
                }.frame(height: 160)
                Text("Dans les jours à venir")
                    .frame(alignment: .leading)
                    //.font(Font.title).foregroundColor(.white)
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(homeViewModel.dailyWeather, id: \.self) { daily in
                            VStack {
                                Text(String(DayFormatter(value: daily.time))).foregroundColor(.white)
                                Text(String(daily.temperatureMax)).foregroundColor(.white)
                                Image(systemName: WeatherType.shared.getWeatherType(code: daily.weatherCode)[1])
                                                                .symbolRenderingMode(.multicolor)
                                                                .resizable()
                                                                .aspectRatio(contentMode: .fit)
                                                                .frame(width: 30, height: 30)
                            }.frame(width: 60, height: 60, alignment: .center)
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


