//
//  HomeViewModel.swift
//  WeatherTodaySwift
//
//  Created by Rodolphe on 28/03/2025.
//
import Foundation

@MainActor
final class HomeViewModel : ObservableObject {
    
    @Published var currentWeather: WeatherCurrentDto?=nil
    @Published var hourlyWeather: WeatherHourlyDto?=nil
    @Published var dailyWeather: WeatherDailyDto?=nil
    @Published var isLoading = false
    @Published var isError = false
    
    
    func getCurrentWeather() async throws {
        
            isLoading = true
            
            do {
                currentWeather = try await NetworkManager.shared.getCurrentWeatherData(latitude: 48.866667, longitude:2.333333)
            } catch {
                isError = true
                throw WeatherApiError.invalidRequest
            }
            
            
            isLoading = false
        }
    
    
    func getDailyWeather() async throws {
        
            isLoading = true
            
            do {
                dailyWeather = try await NetworkManager.shared.getDailyWeatherData(latitude: 48.866667, longitude:2.333333)
            } catch {
                isError = true
                throw WeatherApiError.invalidRequest
            }
            
            
            isLoading = false
        }
    
    func getHourlyWeather() async throws {
        
            isLoading = true
            
            do {
                hourlyWeather = try await NetworkManager.shared.getHourlyWeatherData(latitude: 48.866667, longitude:2.333333)
            } catch {
                isError = true
                throw WeatherApiError.invalidRequest
            }
            
            
            isLoading = false
        }
    
    
}






