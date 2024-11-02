//
//  ContentView.swift
//  RCDbee
//
//  Created by Blindside on 20.10.24.
//

import SwiftUI

struct ContentView: View {
    @State var taron: RCDBCoasterDetail? = {
            guard let url = Bundle.main.url(forResource: "Taron", withExtension: "json"),
                  let data = try? Data(contentsOf: url),
                  let coaster = try? JSONDecoder().decode(RCDBCoasterDetail.self, from: data) else {
                return nil
            }
            return coaster
        }()
    @State var alpengeist: RCDBCoasterDetail? = {
            guard let url = Bundle.main.url(forResource: "Alpengeist", withExtension: "json"),
                  let data = try? Data(contentsOf: url),
                  let coaster = try? JSONDecoder().decode(RCDBCoasterDetail.self, from: data) else {
                return nil
            }
            return coaster
        }()
    @State var velocicoaster: RCDBCoasterDetail? = {
            guard let url = Bundle.main.url(forResource: "VelociCoaster", withExtension: "json"),
                  let data = try? Data(contentsOf: url),
                  let coaster = try? JSONDecoder().decode(RCDBCoasterDetail.self, from: data) else {
                return nil
            }
            return coaster
        }()
    
    @State private var selectedTab = 0
    private let searchTabIndex = 4
    
    
    var body: some View {
        TabView(selection: $selectedTab) {
            RandomCoasterView()
                .tabItem {
                    Image(systemName: "sparkles.rectangle.stack")
                    Text("Random Coaster")
                }
                .tag(0)
            CoasterDetailView(coaster: .constant(taron))
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Taron (id:12723)")
                }
                .tag(1)
            CoasterDetailView(coaster: .constant(alpengeist))
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Alpengeist (id:277)")
                }
                .tag(2)
            CoasterDetailView(coaster: .constant(velocicoaster))
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("VelociCoaster (id:6992)")
                }
                .tag(3)
            SearchPage()
                .tag(searchTabIndex)
                .tabItem{
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
        }
    }
}

#Preview {
    ContentView()
}
