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

struct HourlyWeatherData:Hashable {
    var time: String
    var offSetSeconds: Int
    var temperatureCelsius: Double
    var weatherCode: Int
    var windSpeed:Double
}

struct DailyWeatherData:Hashable {
    var time: String
    var offSetSeconds: Int
    var temperatureMax: Double
    var temperatureMin: Double
    var weatherCode: Int
    var windDirection:Int
    var sunset:String
    var sunrise:String
}

struct AutoCompleteData {
    var placeId:String
    var latitude:Double
    var longitude:Double
    var shortName:String
    var longName:String
}
