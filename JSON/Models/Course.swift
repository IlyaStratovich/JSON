//
//  Model.swift
//  JSON
//
//  Created by Илья Стратович on 23.03.23.
//
import Foundation


struct Course: Codable {
    let id: Int?
    let name: String?
    let link: String?
    let imageUrl: URL?
    let numberOfLessons: Int?
    let numberOfTests: Int?
}

struct SwiftbookInfo: Decodable {
    let courses: [Course]?
    let websiteDescription: String?
    let websiteName: String?
}

struct FirstCourse: Decodable {
    let results: SecondCourse
    let status: String
}

struct SecondCourse: Decodable {
    let sunrise: String
    let sunset: String
    let first_light: String
    let last_light: String
    let dawn: String
    let dusk: String
    let solar_noon: String
    let golden_hour: String
    let day_length: String
    let timezone: String
}



