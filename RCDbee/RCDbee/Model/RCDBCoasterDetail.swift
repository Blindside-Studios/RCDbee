//
//  RCDBCoasterDetail.swift
//  RCDbee
//
//  Created by Blindside on 20.10.24.
//

import Foundation

struct RCDBCoasterDetail: Codable {
    let id: Int
    let name: String
    let park: Park
    let make: String?
    let model: String?
    let type: String?
    let design: String?
    let city, state, country, region: String?
    let link: String?
    let status: Status?
    let stats: CoasterStats?
    let mainPicture: CoasterImage?
    let pictures: [CoasterImage]?
    let coords: Coords?
    
    var statItems: [StatItem] {
        var _parkItem = StatItem(statIcon: "star", statName: "Park", statValue: park.name)
        if let country = country {
            _parkItem = StatItem(statIcon: "star", statName: "Park", statValue: "\(park.name), \(country)")
        }
        
            return [
                _parkItem,
                StatItem(statIcon: "star", statName: "Manufacturer", statValue: make),
                StatItem(statIcon: "star", statName: "Model", statValue: model),
                StatItem(statIcon: "star", statName: "Type", statValue: "\(type ?? "Unknown Type"), \(design ?? "Unknown Design")"),
                StatItem(statIcon: "star", statName: "Speed", statValue: stats?.speed),
                StatItem(statIcon: "star", statName: "Inversions", statValue: stats?.inversions),
                StatItem(statIcon: "star", statName: "Length", statValue: stats?.length),
                StatItem(statIcon: "star", statName: "Height", statValue: stats?.height),
                // Add more items as needed
            ]
        }
}

struct Park: Codable {
    let name: String
    let id: Int
}

struct Status: Codable {
    let state: String?
    let date: DateStatus?
}

struct DateStatus: Codable {
    let opened, closed: String?
}

struct CoasterStats: Codable {
    let length, height, drop, speed: String?
    let inversions, duration, gForce, verticalAngle, arrangement, elements, capacity, generalContractor, architect: String?
    let theme: String?
    let restraints, formerStatus, cost, builder: String?
    let designer: String?
}

struct CoasterImage: Codable {
    let id: Int?
    let name: String?
    let url: String?
    let copyName: String?
    let copyDate: String?
}

struct Coords: Codable {
    let lat: String?
    let lng: String?
}

struct StatItem: Codable {
    let statIcon: String
    let statName: String
    let statValue: String?
}
