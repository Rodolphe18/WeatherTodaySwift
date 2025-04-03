//
//  ContentView.swift
//  WeatherTodaySwift
//
//  Created by Rodolphe on 27/03/2025.
//

import Foundation
import SwiftUI
import SwiftData


struct Pager:View {
    
    @Query var cities: [PersistedCity] = []
    
    @State var index = 0
    
    var body: some View {
        TabView(selection:$index) {
            ForEach(cities.indices) { indice in
                HomeScreen(city: cities[indice]).tag(indice)
            }
        }
        .tabViewStyle(.page)
    }
    
}


struct HomeScreen: View {
    
    @StateObject private var homeViewModel = HomeViewModel()
    
    var city:PersistedCity
    
    var body: some View {
        ZStack() {
            LinearGradient(gradient: Gradient(colors:[.blue, .cyan]), startPoint: .topLeading, endPoint: .bottomTrailing)
            VStack() {
                Text(city.name).font(.system(size: 36, weight: .medium, design: .default)).foregroundColor(.white).padding(.top,-30)
                Text(WeatherType.shared.getWeatherType(code: homeViewModel.currentWeather?.weatherCode ?? 0)[0]).font(.system(size: 32, weight: .medium, design: .default)).foregroundColor(.white)
                Text(String(homeViewModel.currentWeather?.temperatureCelsius ?? 0.00) + "°C").font(.system(size: 46, weight: .medium, design: .default)).foregroundColor(.white).padding(.bottom, 8)
                Text("Dans les prochaines heures").frame(maxWidth: .infinity, alignment: .leading).font(Font.title).foregroundColor(.white).padding(.horizontal)
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(homeViewModel.hourlyWeather, id: \.self) { hourly in
                            HourlyItemView(time: hourly.time, temperature: hourly.temperatureCelsius, weatherCode: hourly.weatherCode)
                        }
                    }.frame(height: 90).padding(.horizontal)
                }
                Text("Données météorologiques").frame(maxWidth: .infinity, alignment: .leading).font(Font.title).foregroundColor(.white).padding(.horizontal)
                CurrentWeatherMetaData(apparentTemperature: homeViewModel.currentWeather?.apparentTemperature ?? 0.00, windSpeed: homeViewModel.currentWeather?.windSpeed ?? 0, sunrise: homeViewModel.dailyWeather.first?.sunrise ?? "", windDirection: homeViewModel.currentWeather?.windDirection ?? 0, precipitation: homeViewModel.currentWeather?.precipitation ?? 0.00, sunset: homeViewModel.dailyWeather.first?.sunset ?? "")
                Text("Dans les jours à venir").frame(maxWidth: .infinity, alignment: .leading).font(Font.title).foregroundColor(.white).padding(.horizontal)
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(homeViewModel.dailyWeather, id: \.self) { daily in
                            DailyWeatherItem(time: daily.time, temperature: daily.temperatureMax, weatherCode: daily.weatherCode)
                        }
                    }.frame(height: 100)
                }
            }
        }.task {
                do {
                    try await homeViewModel.getCurrentWeather(latitude: city.latitude, longitude: city.longitude)
                } catch{
                    
                }
        }.task {
                do {
                    try await homeViewModel.getDailyWeather(latitude: city.latitude, longitude: city.longitude)
                } catch{
                    
                }
        }.task {
                do {
                    try await homeViewModel.getHourlyWeather(latitude: city.latitude, longitude: city.longitude)
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
            Text(String(temperature) + "°").foregroundColor(.white)
            Image(systemName: WeatherType.shared.getWeatherType(code: weatherCode)[1])
                .symbolRenderingMode(.multicolor)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
        }.frame(width: 60, height: 90, alignment: .center).background(.lightBlue).clipShape(.rect(cornerRadius: 8))
    }
}

struct DailyWeatherItem : View {
    
    var time: String
    var temperature: Double
    var weatherCode: Int
    
    var body:some View {
        VStack {
            Text(String(DateTimeFormatter.shared.dayFormatter(value: time))).foregroundColor(.white)
            Text(String(temperature) + "°").foregroundColor(.white)
            Image(systemName: WeatherType.shared.getWeatherType(code: weatherCode)[1])
                .symbolRenderingMode(.multicolor)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
        }.frame(width: 60, height: 60, alignment: .center)
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
                Text(String(apparentTemperature) + "°").foregroundColor(.white)
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
                Text(String(precipitation) + "%").foregroundColor(.white)
                Text("Coucher du soleil").foregroundColor(.white)
                Text(DateTimeFormatter.shared.hourMinuteTimeFormatter(value: sunset)).foregroundColor(.white)
            }
        }.frame(height: 140)
    }
}

