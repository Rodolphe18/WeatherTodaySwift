//
//  WeatherType.swift
//  WeatherTodaySwift
//
//  Created by Rodolphe on 28/03/2025.
//
class WeatherType {
    static let shared = WeatherType()

    func getWeatherType(code:Int) -> Array<String> {
       return switch (code) {
        case 0 : ["Ensoleillé","sun.max.fill"]
        case 1 : ["Quelques nuages","cloud.sun.fill"]
        case 2 : ["Partiellement ensoleillé","cloud.sun.fill"]
        case 3 : ["Couvert","cloud.fill"]
        case 45 : ["Brumeux","cloud.fill"]
        case 48 : ["Très nuageux","cloud.fill"]
        case 51 : ["Pluie fine","cloud.rain.fill"]
        case 53 : ["Pluie","cloud.rain.fill"]
        case 55 : ["Pluie intense", "cloud.rain.fill"]
        case 56 : ["Pluie et grêle","cloud.rain.fill"]
        case 57 : ["Pluie et grêle","cloud.rain.fill"]
        case 61 : ["Pluie","cloud.rain.fill"]
        case 63 : ["Pluie","cloud.rain.fill"]
        case 65 : ["Pluie","cloud.heavyrain.fill"]
        case 66 : ["Pluie glacée","cloud.snow.fill"]
        case 67 : ["Faible chute de grêle","cloud.snow.fill"]
        case 71 : ["Chute de grêle","cloud.snow.fill"]
        case 73 : ["Grêle","cloud.snow.fill"]
        case 75 : ["Faible chute de neige","cloud.snow.fill"]
        case 77 : ["Chute de neige","cloud.heavyrain.fill"]
        case 80 : ["Pluie intense","cloud.heavyrain.fill"]
        case 81 : ["Pluie intense","cloud.heavyrain.fill"]
        case 82 : ["Faible chute de neige","cloud.hail.fill"]
        case 85 : ["Faible chute de neige","cloud.hail.fill"]
        case 86 : ["Orageux","cloud.sun.bolt.fill"]
        case 95 : ["Orageux","cloud.sun.bolt.fill"]
        case 96 : ["Orageux avec éclairs","cloud.sun.bolt.fill"]
        case 99 : ["Orageux avec éclairs","cloud.sun.bolt.fill"]
        default : ["Ensoleillé","sun.max.fill"]
        }
    }
    
}
