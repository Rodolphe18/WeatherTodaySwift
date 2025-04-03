//
//  SearchScreen.swift
//  WeatherTodaySwift
//
//  Created by Rodolphe on 02/04/2025.
//
import Foundation
import SwiftUI
import SwiftData
import MapKit

struct SearchScreen: View {
    
    @State var query:String = ""
    @StateObject var vm = SearchViewModel()
    @State var cities = Array<PersistedCity>()
    
    var body: some View {
        
        
        NavigationStack {
            
            List {
                ForEach(vm.autoCompletionResult, id: \.self) { result in
                    Text(result.longName).onTapGesture {
                        query = ""
                        cities.append(PersistedCity(name: result.shortName, latitude: result.latitude, longitude: result.longitude))
                    }
                }
            }
            
            .navigationTitle("Gérer les villes")
            .navigationBarTitleDisplayMode(.large)
            .searchable(text: $query)
            .onChange(of: query) {
                Task {
                    await vm.getAutoCompleteSearch(query: query)
                }}
            .overlay {
                if(!cities.isEmpty && query.isEmpty) {
                    List {
                        ForEach(cities, id: \.self) { city in
                            Text(city.name)
                        }
                    }
                }
            }
    }
}
    
    
}



@Observable
class LocationSearchService:NSObject {
    
    
    var query:String = "" {
        didSet {
            handleSearchFragment(query)
        }
    }
    
    var results: [LocationResult] = []
    var status: SearchStatus = .idle
    var completer:MKLocalSearchCompleter
    
    init(filter: MKPointOfInterestFilter = .excludingAll, region: MKCoordinateRegion = MKCoordinateRegion(.world), types: MKLocalSearchCompleter.ResultType = [.query, .address]) {
        
        completer = MKLocalSearchCompleter()
        
        super.init()
        completer.delegate = self
        completer.pointOfInterestFilter = filter
        completer.region = region
        completer.resultTypes = types
    }
    
    private func handleSearchFragment(_ fragment: String) {
        self.status = .searching
        if !fragment.isEmpty {
            self.completer.queryFragment = fragment
        }
        self.status = .idle
        self.results = []
        
        
    }
}
    
    
extension LocationSearchService: MKLocalSearchCompleterDelegate {
    
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
       // self.results = completer.results.map(
         //   { result in
              //  LocationResult(title: result.title, subtitle:result.subtitle)
         //   }
       // )
        self.status = .result
    }
 
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: any Error) {
        self.status = .error(error.localizedDescription)
    }
    
    
}
    

struct LocationResult:Identifiable, Hashable {
    var id = UUID()
    var title:String
    var subtitle:String
    var latitude:Double
    var longitude:Double
}


enum SearchStatus:Equatable {
    case idle
    case searching
    case error(String)
    case result
}


