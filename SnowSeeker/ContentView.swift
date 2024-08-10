//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Ayrton Parkinson on 2024/08/10.
//

import SwiftUI

struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @State private var searchText = ""
    @State private var sortBy = "default"
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
           resorts
        } else {
            resorts.filter { $0.name.localizedStandardContains(searchText) }
        }
    }
    
    var resortList: [Resort] {
        switch sortBy {
        case "alphabetical":
            return filteredResorts.sorted { $0.name < $1.name }
        case "country":
            return filteredResorts.sorted { $0.country < $1.country }
        default:
            return filteredResorts
        }
    }
    
    @State private var favorites = Favorites()
     
    var body: some View {
        NavigationSplitView {
            List(resortList) { resort in
                NavigationLink(value: resort) {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(
                                .rect(cornerRadius: 5)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )

                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundStyle(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .navigationDestination(for: Resort.self) { resort in
                    ResortView(resort: resort)
            }
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortBy) {
                        Text("Sort by default")
                            .tag("default")
                        
                        Text("Sort by name")
                            .tag("alphabetical")
                        
                        Text("Sort by Country")
                            .tag("country")
                    }
                }
            }
        } detail: {
            WelcomeView()
        }
        .environment(favorites)
    }
}

#Preview {
    ContentView()
}
