//
//  DateTimeFormatter.swift
//  WeatherTodaySwift
//
//  Created by Rodolphe on 02/04/2025.
//
import Foundation

class DateTimeFormatter {
    
    static let shared = DateTimeFormatter()
        
    func hourTimeFormatter(value:String) -> Int {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        return calendar.component(.hour, from: dateFormatter.date(from:value) ?? Date())
    }
    
    func hourMinuteTimeFormatter(value:String) -> String {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        return " \(calendar.component(.hour, from: dateFormatter.date(from:value) ?? Date()))h\(calendar.component(.minute, from: dateFormatter.date(from:value) ?? Date()))"
    }
    
    func dayFormatter(value:String) -> String {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return " \(calendar.component(.day, from: dateFormatter.date(from:value) ?? Date()))  \(calendar.component(.month, from: dateFormatter.date(from:value) ?? Date())) "
    }
    
}
