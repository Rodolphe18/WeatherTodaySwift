//
//  HomeViewModel.swift
//  WeatherTodaySwift
//
//  Created by Rodolphe on 28/03/2025.
//
import Foundation

@MainActor
final class HomeViewModel : ObservableObject {
    
    var repository = DefaultWeatherRepository()
    
    @Published var currentWeather: CurrentWeatherData? = nil
    @Published var dailyWeather: Array<DailyWeatherData> = []
    @Published var hourlyWeather: Array<HourlyWeatherData> = []
    @Published var isLoading = false
    @Published var isError = false
    
    
    func getCurrentWeather(latitude:Double, longitude:Double) async throws {
        isLoading = true
        currentWeather = try await repository.getCurrentWeatherData(lat: latitude, long:longitude)
        isLoading = false
    }
    
    
    func getDailyWeather(latitude:Double, longitude:Double) async throws {
        isLoading = true
        dailyWeather = try await repository.getDailyWeatherData(lat: latitude, long:longitude)
        isLoading = false
    }
    
    
    func getHourlyWeather(latitude:Double, longitude:Double) async throws {
        isLoading = true
        let hourlyWeatherResponse:Array<HourlyWeatherData> = try await repository.getHourlyWeatherData(lat: latitude, long:longitude)
        // current date and time
        let date = Date()
        let calendar = Calendar.current
         
        let components = Calendar.current.dateComponents([.hour,.minute], from: date)
        let hour = components.hour
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        let offSet = ((hourlyWeatherResponse.first?.offSetSeconds ?? 0) / 3600)
       
        for index in 0...48 {
            if (index >= 24 || calendar.component(.hour, from: dateFormatter.date(from:hourlyWeatherResponse[index].time) ?? Date()) > (hour ?? 0 + offSet)) {
                hourlyWeather.append(hourlyWeatherResponse[index])
            }}
        
        
        isLoading = false
    }
    
    
}






