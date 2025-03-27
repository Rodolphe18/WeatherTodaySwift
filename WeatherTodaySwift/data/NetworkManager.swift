//
//  NetworkManager.swift
//  WeatherTodaySwift
//
//  Created by Rodolphe on 27/03/2025.
import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    let baseUrl = "https://api.open-meteo.com/v1"
    
    private init() {}
    
    func getCurrentWeatherData(latitude: Double, longitude: Double, completed:@escaping (WeatherCurrentDto?, String?) -> Void)
    {
        let endPoint = baseUrl + "/forecast?latitude=\(latitude)&longitude=\(longitude)&timezone=auto& current=temperature_2m,weather_code,wind_speed_10m,wind_direction_10m,is_day,apparent_temperature,precipitation"
        guard let url = URL(string: endPoint) else {
            completed(nil, "Invalid request. Please try again")
            return
        }
        let task = URLSession.shared.dataTask(with: <#T##URLRequest#>) {  (data, response, error) in
            if let _ = error { completed(nil, "error")
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, "")
                return
            }
            guard let data = data else {
                completed(nil, "")
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let currentWeather = try decoder.decode(WeatherCurrentDto.self, from: data)
                completed(currentWeather, nil)
            } catch {
                completed(nil, "")
            }
        }
        task.resume()
    }
    
    
    func getDailyWeatherData(latitude: Double, longitude: Double, completed:@escaping (WeatherDailyDto?, String?) -> Void)
    {
        let endPoint = baseUrl + "/forecast?latitude=\(latitude)&longitude=\(longitude)&timezone=auto& daily=weather_code,temperature_2m_max,temperature_2m_min,wind_direction_10m_dominant,sunrise,sunset"
        guard let url = URL(string: endPoint) else {
            completed(nil, "Invalid request. Please try again")
            return
        }
        let task = URLSession.shared.dataTask(with: <#T##URLRequest#>) {  (data, response, error) in
            if let _ = error { completed(nil, "error")
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, "")
                return
            }
            guard let data = data else {
                completed(nil, "")
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let currentWeather = try decoder.decode(WeatherDailyDto.self, from: data)
                completed(currentWeather, nil)
            } catch {
                completed(nil, "")
            }
        }
        task.resume()
    }
    
    
    func getHourlyWeatherData(latitude: Double, longitude: Double, completed:@escaping (WeatherHourlyDto?, String?) -> Void)
    {
        let endPoint = baseUrl + "/forecast?latitude=\(latitude)&longitude=\(longitude)&timezone=auto& daily=temperature_2m,weather_code,wind_speed_10m"
        guard let url = URL(string: endPoint) else {
            completed(nil, "Invalid request. Please try again")
            return
        }
        let task = URLSession.shared.dataTask(with: <#T##URLRequest#>) {  (data, response, error) in
            if let _ = error { completed(nil, "error")
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, "")
                return
            }
            guard let data = data else {
                completed(nil, "")
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let currentWeather = try decoder.decode(WeatherHourlyDto.self, from: data)
                completed(currentWeather, nil)
            } catch {
                completed(nil, "")
            }
        }
        task.resume()
    }
    
    
    
    
    
    
}
