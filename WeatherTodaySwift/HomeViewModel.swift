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
    @Published var hourlyWeather: Dictionary<Int, Array<HourlyWeatherData>>? = nil
    @Published var dailyWeather: Array<DailyWeatherData>? = nil
    @Published var isLoading = false
    @Published var isError = false
    
    
    func getCurrentWeather() async throws {
        isLoading = true
        currentWeather = try await repository.getCurrentWeatherData(lat: 48.866667, long:2.333333)
        isLoading = false
    }
    
    
    func getDailyWeather() async throws {
        isLoading = true
        dailyWeather = try await repository.getDailyWeatherData(lat: 48.866667, long:2.333333)
        isLoading = false
    }
    
    
    func getHourlyWeather() async throws {
        isLoading = true
        hourlyWeather = try await repository.getHourlyWeatherData(lat: 48.866667, long:2.333333)
        isLoading = false
    }
    
    
}






