//
//  AutocompleteDto.swift
//  WeatherTodaySwift
//
//  Created by Rodolphe on 27/03/2025.
//

struct AutocompleteDto:Codable {
    var address: Address? = nil
    var boundingbox: Array<String?>
        var `class`: String? = ""
        var displayAddress: String? = ""
        var displayName: String? = ""
        var displayPlace: String? = ""
        var lat: String? = ""
        var licence: String? = ""
        var lon: String? = ""
        var osmId: String? = ""
        var osmType: String? = ""
        var placeId: String? = ""
        var type: String? = ""
}

struct Address:Codable {
    var country: String? = ""
        var countryCode: String? = ""
        var county: String? = ""
        var name: String? = ""
        var postcode: String? = ""
        var state: String? = ""
}
