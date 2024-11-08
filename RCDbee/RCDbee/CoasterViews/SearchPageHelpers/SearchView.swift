//
//  SearchView.swift
//  RCDbee
//
//  Created by Blindside on 23.10.24.
//

import SwiftUI

struct SearchView: View {
    @Binding var text: String
    @Binding var confirmedSearch: Bool
    
    var body: some View {
        HStack {
            TextField("Search...", text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .keyboardType(.webSearch)
                .onSubmit {
                    confirmedSearch.toggle()
                }
                .autocorrectionDisabled()
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                        if !text.isEmpty {
                            Button(action: {
                                self.text = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
        }
    }
}

#Preview {
    SearchView(text: .constant(""), confirmedSearch: .constant(false))
}
