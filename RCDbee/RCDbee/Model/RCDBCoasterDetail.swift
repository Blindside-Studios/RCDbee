//
//  RCDBCoasterDetail.swift
//  RCDbee
//
//  Created by Blindside on 20.10.24.
//

import Foundation

struct RCDBCoasterDetail: Codable, Identifiable {
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
        return [
            // TODO: These units are all hardcoded, I am not sure if I am allowed to convert them anyways and the values are force-unwrapped, meaning I can't check if they exist or not.
            StatItem(statIcon: "star", statName: "Manufacturer", statValue: make),
            StatItem(statIcon: "star", statName: "Model", statValue: model),
            StatItem(statIcon: "star", statName: "Type", statValue: "\(type ?? "Unknown Type"), \(design ?? "Unknown Design")"),
            StatItem(statIcon: "star", statName: "Speed", statValue: (stats?.speed) ?? "unknown" + " km/h"),
            StatItem(statIcon: "star", statName: "Inversions", statValue: (stats?.inversions) ?? "unkown"),
            StatItem(statIcon: "star", statName: "Length", statValue: (stats?.length) ?? "uknown" + " m"),
            StatItem(statIcon: "star", statName: "Height", statValue: (stats?.height) ?? "unkown" + " m"),
            StatItem(statIcon: "star", statName: "Capacity", statValue: (stats?.capacity) ?? "unknown" + " rph")
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
    let id: Int
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
