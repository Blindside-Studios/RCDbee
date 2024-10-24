//
//  SearchRCDBViewModel.swift
//  RCDbee
//
//  Created by Blindside on 24.10.24.
//

import Foundation

class SearchRCDBViewModel: ObservableObject {
    @Published var coasters: RCDBSearchResults?

    func fetchCoasterByTerm(searchTerm: String) {
        
        let passableURL = searchTerm.replacingOccurrences(of: " ", with: "%20")
        guard let url = URL(string: "https://rcdb-api.vercel.app/api/coasters/search?q=\(passableURL)") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let results = try decoder.decode(RCDBSearchResults.self, from: data)
                    DispatchQueue.main.async {
                        self.coasters = results
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
}

