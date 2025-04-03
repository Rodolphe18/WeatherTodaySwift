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
    
    @Environment(\.modelContext) var context
    @State var query:String = ""
    @StateObject var vm = SearchViewModel()
    @Query var cities: [PersistedCity] = []
   
    
    var body: some View {
        @State var selectedCity:PersistedCity? = cities[0]
        NavigationStack {
            List {
                ForEach(vm.autoCompletionResult, id: \.self) { result in
                    Text(result.longName).onTapGesture {
                        query = ""
                        context.insert(PersistedCity(name: result.shortName, latitude: result.latitude, longitude: result.longitude))
                    }
                }
            }
            .navigationTitle("Gérer les villes")
            .navigationDestination(for: Int.self) { index in
                Pager(index: index)
            }
            .navigationBarTitleDisplayMode(.large)
            .searchable(text: $query)
            .onChange(of: query) {
                Task {
                    await vm.getAutoCompleteSearch(query: query)
                }}
            .overlay {
                if(query.isEmpty) {
                    List {
                ForEach(Array(zip(cities.indices, cities)), id: \.0) { index, city in
                            NavigationLink(value: index) {
                                HStack{
                                    Text(city.name)
                                    Text(String(index))
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
