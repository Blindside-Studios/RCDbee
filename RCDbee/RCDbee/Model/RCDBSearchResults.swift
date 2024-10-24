//
//  RCDBSearchResults.swift
//  RCDbee
//
//  Created by Blindside on 24.10.24.
//

import Foundation

struct RCDBSearchResults: Codable {
    var coasters: [RCDBCoasterDetail]
    var totalMatch: Int?
}
