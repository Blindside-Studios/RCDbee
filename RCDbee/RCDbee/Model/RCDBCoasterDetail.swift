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
    let city, state, country, region: String?
    let link: String?
    let status: Status?
    let stats: Stats?
    let mainPicture: CoasterImage?
    let pictures: [CoasterImage]?
    let coords: Coords?
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
    let opened: String?
}

struct Stats: Codable {
    let length, height, speed: String?
    let inversions, verticalAngle, duration, arrangement: String?
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
