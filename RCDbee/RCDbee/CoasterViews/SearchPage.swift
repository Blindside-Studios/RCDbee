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
    @State private var selectedCoaster: RCDBCoasterDetail?
    @State private var presentSheet: Bool = false
    
    @State private var receivedSearchConfirmation: Bool = false
    
    var body: some View {
        VStack{
            
            SearchView(text: $searchText, confirmedSearch: $receivedSearchConfirmation)
                .onChange(of: receivedSearchConfirmation, {
                    viewModel.fetchCoasterByTerm(searchTerm: searchText)
                })
                .padding(.vertical)
            
            if let coasterResults = viewModel.coasters{
                ScrollView {
                    Spacer()
                        .frame(height: 50)
                    ForEach (coasterResults.coasters, id: \.id) { coaster in
                        SearchResultRow(coaster: .constant(coaster))
                            .frame(height: 150)
                            .padding(.horizontal)
                            .onTapGesture {
                                selectedCoaster = coaster
                                presentSheet = true
                            }
                    }
                    .sheet(isPresented: $presentSheet) {
                        CoasterDetailView(coaster: $selectedCoaster)
                    }
                    Spacer()
                        .frame(height: 100)
                }
                .padding(.vertical, -50)
                .offset(y: 25)
            }
            Spacer()
        }
        .onAppear(){
            viewModel.fetchCoasterByTerm(searchTerm: "")
        }
    }
}

#Preview {
    SearchPage()
}
