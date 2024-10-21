//
//  ContentView.swift
//  RCDbee
//
//  Created by Blindsidesparkles.rectangle.stack on 20.10.24.
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
    
    
    var body: some View {
        TabView {
            RandomCoasterView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Random Coaster")
                }
            CoasterDetailView(coaster: .constant(taron))
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Taron (id:12723)")
                }
            CoasterDetailView(coaster: .constant(alpengeist))
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Alpengeist (id:277)")
                }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
