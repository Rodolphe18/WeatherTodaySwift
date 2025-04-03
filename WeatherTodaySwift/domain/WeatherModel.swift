//
//  WeatherModel.swift
//  WeatherTodaySwift
//
//  Created by Rodolphe on 28/03/2025.
//
import SwiftData
import Foundation

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

struct AutoCompleteData:Hashable {
    var placeId:String
    var latitude:Double
    var longitude:Double
    var shortName:String
    var longName:String
}


@Model
class PersistedCity : Identifiable {
    var id:UUID = UUID()
    var name:String
    var latitude:Double
    var longitude:Double
    
    
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
    
    
    
}
