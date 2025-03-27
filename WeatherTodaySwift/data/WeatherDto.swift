//
//  WeatherDto.swift
//  WeatherTodaySwift
//
//  Created by Rodolphe on 27/03/2025.
//
import Foundation



struct WeatherHourlyDto:Codable {
    var utcOffSetSeconds: Int
    var hourly: HourlyForecastDataDto
}

struct WeatherCurrentDto:Codable {
    var utcOffSetSeconds: Int
    var current: WeatherCurrentDataDto
}

struct WeatherDailyDto:Codable {
    var utcOffSetSeconds: Int
    var daily: DailyCurrentDataDto
}

struct HourlyForecastDataDto:Codable {
    var time: Array<String>
    var temperature2m: Array<Double>
    var windSpeed10m: Array<Double>
    var weatherCode: Array<Int>
}

struct WeatherCurrentDataDto:Codable {
    var temperature2m : Double
    var weatherCode : Int
    var windSpeed10m : Double
    var windDirection10m : Int
    var isDay:Int
    var apparentTemperature:Double
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
