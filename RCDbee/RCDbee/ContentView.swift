//
//  ContentView.swift
//  RCDbee
//
//  Created by Blindsidesparkles.rectangle.stack on 20.10.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            RandomCoasterView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Random Coaster")
                }
            }
        .padding()
    }
}

#Preview {
    ContentView()
}
