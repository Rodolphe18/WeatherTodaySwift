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
                            HourlyItemView(time: hourly.time, temperature: hourly.temperatureCelsius, weatherCode: hourly.weatherCode)
                        }
                    }.frame(height: 100)
                }
                Spacer(minLength: 8)
                Text("Données météorologiques").frame(alignment: .leading).font(Font.title).foregroundColor(.white)
                CurrentWeatherMetaData(apparentTemperature: homeViewModel.currentWeather?.apparentTemperature ?? 0.00, windSpeed: homeViewModel.currentWeather?.windSpeed ?? 0, sunrise: homeViewModel.dailyWeather.first?.sunrise ?? "", windDirection: homeViewModel.currentWeather?.windDirection ?? 0, precipitation: homeViewModel.currentWeather?.precipitation ?? 0.00, sunset: homeViewModel.dailyWeather.first?.sunset ?? "")
                Text("Dans les jours à venir").frame(alignment: .leading).font(Font.title).foregroundColor(.white)
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(homeViewModel.dailyWeather, id: \.self) { daily in
                            VStack {
                                Text(String(DateTimeFormatter.shared.dayFormatter(value: daily.time))).foregroundColor(.white)
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


struct HourlyItemView : View {
    
    var time: String
    var temperature: Double
    var weatherCode: Int
    
    var body:some View {
        VStack {
            Text(String(DateTimeFormatter.shared.hourTimeFormatter(value: time)) + "h").foregroundColor(.white)
            Text(String(temperature)).foregroundColor(.white)
            Image(systemName: WeatherType.shared.getWeatherType(code: weatherCode)[1])
                .symbolRenderingMode(.multicolor)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
        }.frame(width: 60, height: 100, alignment: .center).background(.pink).clipShape(.buttonBorder)
    }
}
                            
struct CurrentWeatherMetaData:View {
    
    var apparentTemperature:Double
    var windSpeed:Double
    var sunrise:String
    var windDirection:Int
    var precipitation:Double
    var sunset:String
    
   
    var body:some View {
        HStack() {
            VStack {
                Text("Ressenti").foregroundColor(.white)
                Text(String(apparentTemperature)).foregroundColor(.white)
                Text("Vitesse du vent").foregroundColor(.white)
                Text(String(Int(windSpeed)) + " km/h").foregroundColor(.white)
                Text("Lever du soleil").foregroundColor(.white)
                Text(DateTimeFormatter.shared.hourMinuteTimeFormatter(value:sunrise)).foregroundColor(.white)
            }
            Spacer().frame(width: 50)
            VStack {
                Text("Direction du vent").foregroundColor(.white)
                Text(String(windDirection)).foregroundColor(.white)
                Text("Précipitation").foregroundColor(.white)
                Text(String(precipitation)).foregroundColor(.white)
                Text("Coucher du soleil").foregroundColor(.white)
                Text(DateTimeFormatter.shared.hourMinuteTimeFormatter(value: sunset)).foregroundColor(.white)
            }
        }.frame(height: 160)
    }
}

