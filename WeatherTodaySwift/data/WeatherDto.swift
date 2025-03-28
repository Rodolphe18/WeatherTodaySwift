//
//  WeatherDto.swift
//  WeatherTodaySwift
//
//  Created by Rodolphe on 27/03/2025.
//
import Foundation



struct WeatherHourlyDto:Codable {
    var utc_offset_seconds: Int
    var hourly: HourlyForecastDataDto
}

struct WeatherCurrentDto:Codable {
    var utc_offset_seconds: Int
    var current: WeatherCurrentDataDto
}

struct WeatherDailyDto:Codable {
    var utc_offset_seconds: Int
    var daily: DailyCurrentDataDto
}

struct HourlyForecastDataDto:Codable {
    var time: Array<String>
    var temperature2m: Array<Double>
    var windSpeed10m: Array<Double>
    var weatherCode: Array<Int>
}

struct WeatherCurrentDataDto:Codable {
    var temperature_2m : Double
    var weather_code : Int
    var wind_speed_10m : Double
    var wind_direction_10m : Int
    var is_day:Int
    var apparent_temperature:Double
    var precipitation:Double
}

struct DailyCurrentDataDto:Codable {
    var temperature2mMax: Array<Double>
    var temperature2mMin: Array<Double>
    var time: Array<String>
    var offSetSeconds: Int?
    var weatherCode: Array<Int>
    var sunset:Array<String>
    var sunrise:Array<String>
    var windDirection10mDominant: Array<Int>
}
