//
//  WeatherModel.swift
//  WeatherTodaySwift
//
//  Created by Rodolphe on 28/03/2025.
//

struct CurrentWeatherData {
    var time: String
    var offSetSeconds: Int
    var temperatureCelsius: Double
    var weatherCode: Int
    var windSpeed:Double
    var windDirection:Int
    var isDay:Bool
    var apparentTemperature:Double
    var precipitation:Double
}

struct HourlyWeatherData {
    var time: String
    var offSetSeconds: Int
    var temperatureCelsius: Double
    var weatherCode: Int
    var windSpeed:Double
}

struct DailyWeatherData {
    var time: String
    var offSetSeconds: Int
    var temperatureMax: Double
    var temperatureMin: Double
    var weatherCode: Int
    var windDirection:Int
    var sunset:String
    var sunrise:String
}

