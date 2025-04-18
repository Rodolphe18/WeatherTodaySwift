//
//  DataMappers.swift
//  WeatherTodaySwift
//
//  Created by Rodolphe on 28/03/2025.
//
import Foundation

struct IndexedWeatherData {
    var index:Int
    var data: HourlyWeatherData
}

class DataMappers {
    
    static let shared = DataMappers()
    
    func asExternalAutoCompleteModel(dto:AutocompleteDto) -> AutoCompleteData {
        return AutoCompleteData(placeId: dto.place_id ?? "", latitude: Double(dto.lat ?? "0.00") ?? 0.00, longitude: Double(dto.lon ?? "0.00") ?? 0.00, shortName: dto.display_place ?? "", longName: dto.display_name ?? "")
    }

    
    
    func asExternalHourlyWeather(dto:WeatherHourlyDto) -> Array<HourlyWeatherData> {
        
        var indexedWeatherDataList: Array<HourlyWeatherData> = []
        
        for index in (0...48) {
            let time = dto.hourly.time[index]
            let weatherCode = dto.hourly.weather_code[index]
            let temperature = dto.hourly.temperature_2m[index]
            let windSpeed = dto.hourly.wind_speed_10m[index]
            let offSetSeconds = dto.utc_offset_seconds
            
            indexedWeatherDataList.append(HourlyWeatherData(time: time,offSetSeconds: offSetSeconds,temperatureCelsius: temperature,weatherCode: weatherCode,windSpeed: windSpeed)
            )
        }
        
        return indexedWeatherDataList
    }
    
    
    func asExternalCurrentWeather(dto:WeatherCurrentDto) -> CurrentWeatherData {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        return CurrentWeatherData(time: String(hour), offSetSeconds: dto.utc_offset_seconds, temperatureCelsius: dto.current.temperature_2m, weatherCode: dto.current.weather_code, windSpeed: dto.current.wind_speed_10m, windDirection: dto.current.wind_direction_10m, isDay: dto.current.is_day == 1, apparentTemperature: dto.current.apparent_temperature, precipitation: dto.current.precipitation * 100)
    }
    
    func asExternalDailyWeather(dto:WeatherDailyDto) -> Array<DailyWeatherData> {
        
        var indexedWeatherDataList: Array<DailyWeatherData> = []
        
        for index in (0...dto.daily.time.count-1) {
            
            let time = dto.daily.time[index]
            let temperatureMax = dto.daily.temperature_2m_max[index]
            let temperatureMin = dto.daily.temperature_2m_min[index]
            let weatherCode = dto.daily.weather_code[index]
            let windDirection = dto.daily.wind_direction_10m_dominant[index]
            let sunset = dto.daily.sunset[index]
            let sunrise = dto.daily.sunrise[index]
            
            indexedWeatherDataList.append(DailyWeatherData(
                time: time,
                offSetSeconds: dto.utc_offset_seconds,
                temperatureMax: temperatureMax,
                temperatureMin: temperatureMin,
                weatherCode: weatherCode,
                windDirection: windDirection,
                sunset: sunset,
                sunrise: sunrise
            ))
            
        }
        
        return indexedWeatherDataList
        
    }
}
