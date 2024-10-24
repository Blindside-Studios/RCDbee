//
//  CoasterViewModel.swift
//  RCDbee
//
//  Created by Blindside on 20.10.24.
//

import Foundation

class CoasterViewModel: ObservableObject {
    @Published var coaster: RCDBCoasterDetail?

    func fetchCoasterByID(coasterID: Int) {
        guard let url = URL(string: "https://rcdb-api.vercel.app/api/coasters/\(coasterID)") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let coaster = try decoder.decode(RCDBCoasterDetail.self, from: data)
                    DispatchQueue.main.async {
                        self.coaster = coaster
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
}

