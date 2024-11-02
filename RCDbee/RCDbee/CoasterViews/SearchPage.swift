//
//  SearchPage.swift
//  RCDbee
//
//  Created by Blindside on 24.10.24.
//

import SwiftUI

struct SearchPage: View {
    @State var searchText: String = ""
    @StateObject private var viewModel = SearchRCDBViewModel()
    
    @State private var receivedSearchConfirmation: Bool = false
    
    @Namespace private var animationNamespace
    
    var body: some View {
        NavigationStack{
            VStack{
                
                SearchView(text: $searchText, confirmedSearch: $receivedSearchConfirmation)
                    .onChange(of: receivedSearchConfirmation, {
                        viewModel.fetchCoasterByTerm(searchTerm: searchText)
                    })
                    .padding(.vertical)
                
                Button("Clear Cache") {
                                ImageCache.shared.clearCache()
                            }
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                
                if let coasterResults = viewModel.coasters{
                    ScrollView {
                        Spacer()
                            .frame(height: 20)
                        ForEach (coasterResults.coasters, id: \.id) { coaster in
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
                        Spacer()
                            .frame(height: 75)
                    }
                    .padding(.vertical, -50)
                    .offset(y: 25)
                }
                Spacer()
            }
        }
        .onAppear(){
            viewModel.fetchCoasterByTerm(searchTerm: "")
        }
        .navigationTitle("Search")
    }
}

#Preview {
    SearchPage()
}
