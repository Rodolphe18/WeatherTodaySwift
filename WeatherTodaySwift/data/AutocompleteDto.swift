//
//  AutocompleteDto.swift
//  WeatherTodaySwift
//
//  Created by Rodolphe on 27/03/2025.
//
import Foundation

struct AutocompleteDto:Codable {
    var address: Address?
    var boundingbox: Array<String?>
    var `class`: String?
    var display_address: String?
    var display_name: String?
    var display_place: String?
    var lat: String?
    var licence: String?
    var lon: String?
    var osm_id: String?
    var osm_type: String?
    var place_id: String?
    var type: String?
}

struct Address:Codable {
    var country: String?
        var country_code: String?
        var county: String?
        var name: String?
        var postcode: String?
        var state: String?
}
