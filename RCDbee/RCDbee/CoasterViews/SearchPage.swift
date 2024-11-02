//
//  SearchPage.swift
//  RCDbee
//
//  Created by Blindside on 24.10.24.
//

import SwiftUI

struct SearchPage: View {
    @State private var searchText: String = ""
    @StateObject private var viewModel = SearchRCDBViewModel()
    @Namespace private var animationNamespace
    
    var body: some View {
        NavigationStack {
            VStack {
                if let coasterResults = viewModel.coasters {
                    ScrollView {
                        Spacer().frame(height: 50)
                        ForEach(coasterResults.coasters, id: \.id) { coaster in
                            NavigationLink {
                                CoasterDetailView(coaster: .constant(coaster))
                                    .navigationTransition(.zoom(sourceID: coaster.id, in: animationNamespace))
                            } label: {
                                SearchResultRow(coaster: .constant(coaster))
                                    .matchedTransitionSource(id: coaster.id, in: animationNamespace)
                                    .frame(height: 150)
                                    .padding(.horizontal)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        Spacer().frame(height: 75)
                    }
                    .padding(.vertical, -50)
                    .offset(y: 25)
                }
                Spacer()
            }
            .searchable(text: $searchText, prompt: "Search coasters, parks, etc.")
            .onSubmit(of: .search) {
                viewModel.fetchCoasterByTerm(searchTerm: searchText)
            }
            .navigationTitle("Search")
        }
    }
}

#Preview {
    SearchPage()
}
