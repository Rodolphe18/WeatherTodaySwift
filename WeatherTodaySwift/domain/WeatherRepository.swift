//
//  WeatherRepository.swift
//  WeatherTodaySwift
//
//  Created by Rodolphe on 31/03/2025.
//

import Foundation

class DefaultWeatherRepository {
    
    func getAutoCompleteResult(query:String) async throws -> Array<AutoCompleteData> {
        do {
            var response = try await NetworkManager.shared.getAutocompleteResult(query: query)
            let body = response.map { DataMappers.shared.asExternalAutoCompleteModel(dto: $0) }
            return body
        } catch {
            throw WeatherApiError.invalidResponse
        }
    }
    
    
    func getCurrentWeatherData(lat: Double, long: Double) async throws -> CurrentWeatherData {
        do {
            let response = try await NetworkManager.shared.getCurrentWeatherData(latitude: lat, longitude: long)
            let body = DataMappers.shared.asExternalCurrentWeather(dto: response)
            return body
        } catch  {
            throw WeatherApiError.invalidResponse
        }
    }
    
    
    func getHourlyWeatherData(lat: Double,long: Double) async throws -> Dictionary<Int, Array<HourlyWeatherData>> {
        do {
            let response = try await NetworkManager.shared.getHourlyWeatherData(latitude: lat, longitude: long)
            let body = DataMappers.shared.asExternalHourlyWeather(dto: response)
            return body
        } catch  {
            throw WeatherApiError.invalidResponse
        }
    }
    
    
    
    func getDailyWeatherData(
        lat: Double,
        long: Double
    ) async throws -> Array<DailyWeatherData> {
        do {
            let response = try await NetworkManager.shared.getDailyWeatherData(latitude: lat, longitude: long)
            let body = DataMappers.shared.asExternalDailyWeather(dto: response)
            return body
        } catch  {
            throw WeatherApiError.invalidResponse
        }
    }
    
}

