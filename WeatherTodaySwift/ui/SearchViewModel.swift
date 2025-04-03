//
//  SearchViewModel.swift
//  WeatherTodaySwift
//
//  Created by Rodolphe on 02/04/2025.
//
import Foundation

@MainActor
class SearchViewModel:ObservableObject {
    
    let weatherRepository = DefaultWeatherRepository()
    
    var autoCompletionResult:Array<AutoCompleteData> = []
    
    
    
    func getAutoCompleteSearch(query: String) async {
        autoCompletionResult.removeAll()
        
        do {
            autoCompletionResult = try await weatherRepository.getAutoCompleteResult(query: query)
        } catch {
            
        }
        print(autoCompletionResult)
        
    }
    
}
    

