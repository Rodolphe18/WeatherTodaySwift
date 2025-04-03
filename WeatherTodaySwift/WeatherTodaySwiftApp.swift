//
//  WeatherTodaySwiftApp.swift
//  WeatherTodaySwift
//
//  Created by Rodolphe on 27/03/2025.
//

import SwiftUI
import SwiftData

@main
struct WeatherTodaySwiftApp: App {
    var body: some Scene {
        WindowGroup {
            SearchScreen()
        }
        .modelContainer(for: [PersistedCity.self])
    }
}
