//
//  SearchPage.swift
//  RCDbee
//
//  Created by Nicolas Helbig on 24.10.24.
//

import SwiftUI

struct SearchPage: View {
    @State var searchText: String = ""
    @StateObject private var viewModel = SearchRCDBViewModel()
    @State private var confirmationDialogue: String = "Didn't load anything yet"
    @State private var selectedCoaster: RCDBCoasterDetail?
    @State private var presentSheet: Bool = false
    
    var body: some View {
        VStack{
            
            SearchView(text: $searchText)
                .onChange(of: searchText, {
                    viewModel.fetchCoasterByTerm(searchTerm: searchText)
                    confirmationDialogue = "Searched for \(searchText)"
                })
            Text("Results: \(viewModel.coasters?.totalMatch ?? 0)")
            Text(confirmationDialogue)
            
            if let coasterResults = viewModel.coasters{
                List(coasterResults.coasters) { coaster in
                    Text(coaster.name)
                        .onTapGesture {
                            selectedCoaster = coaster
                            presentSheet = true
                        }
                }
                .sheet(isPresented: $presentSheet) {
                  CoasterDetailView(coaster: $selectedCoaster)
                }
            }
        }
        .onAppear(){
            viewModel.fetchCoasterByTerm(searchTerm: "")
        }
    }
}

#Preview {
    SearchPage()
}
