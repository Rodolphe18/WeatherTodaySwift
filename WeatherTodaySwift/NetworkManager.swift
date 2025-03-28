//
//  NetworkManager.swift
//  WeatherTodaySwift
//
//  Created by Rodolphe on 27/03/2025.
import Foundation
import OSLog

public class NetworkManager {
    static let shared = NetworkManager()
    let baseUrl = "https://api.open-meteo.com/v1"
    let autocompleteBaseUrl = "https://api.locationiq.com/v1/"
    let autocompleteToken = "pk.2b70389e06988dd76200f790facbca1b"
    
    let logger = Logger()
    
    private init() {}
    
    func getCurrentWeatherData(latitude: Double, longitude: Double) async throws -> WeatherCurrentDto
    {
        let endPoint = baseUrl + "/forecast?latitude=\(latitude)&longitude=\(longitude)&timezone=auto&current=temperature_2m,weather_code,wind_speed_10m,wind_direction_10m,is_day,apparent_temperature,precipitation"
        
        guard let url = URL(string: endPoint) else { throw WeatherApiError.invalidRequest }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw WeatherApiError.invalidRequest
        }
                
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .useDefaultKeys
            return try decoder.decode(WeatherCurrentDto.self, from: data)
        } catch {
                throw WeatherApiError.invalidResponse
            }
        }

    
    
func getDailyWeatherData(latitude: Double, longitude: Double) async throws -> WeatherDailyDto
    {
        let endPoint = baseUrl + "/forecast?latitude=\(latitude)&longitude=\(longitude)&timezone=auto& daily=weather_code,temperature_2m_max,temperature_2m_min,wind_direction_10m_dominant,sunrise,sunset"
        
        guard let url = URL(string: endPoint) else { throw WeatherApiError.invalidRequest }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw WeatherApiError.invalidRequest
        }
                
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .useDefaultKeys
            return try decoder.decode(WeatherDailyDto.self, from: data)
        } catch {
                throw WeatherApiError.invalidResponse
            }
    }
    
    
func getHourlyWeatherData(latitude: Double, longitude: Double) async throws -> WeatherHourlyDto
    {
        let endPoint = baseUrl + "/forecast?latitude=\(latitude)&longitude=\(longitude)&timezone=auto& daily=temperature_2m,weather_code,wind_speed_10m"
        guard let url = URL(string: endPoint) else { throw WeatherApiError.invalidRequest }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw WeatherApiError.invalidRequest
        }
                
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .useDefaultKeys
            return try decoder.decode(WeatherHourlyDto.self, from: data)
        } catch {
                throw WeatherApiError.invalidResponse
            }
    }
    
    
    
    
    func getAutocompleteResult(query:String) async throws -> AutocompleteDto {
      
        let endPoint = autocompleteBaseUrl + "/autocomplete?tag=place:city,place:town?q=\(query)&limit=10&key=pk.2b70389e06988dd76200f790facbca1b"
        guard let url = URL(string: endPoint) else { throw WeatherApiError.invalidRequest }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw WeatherApiError.invalidRequest
        }
                
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .useDefaultKeys
            return try decoder.decode(AutocompleteDto.self, from: data)
        } catch {
                throw WeatherApiError.invalidResponse
            }
    }
    
    
}
