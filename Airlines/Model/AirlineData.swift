//
//  AirlineModel.swift
//  Airlines
//
//  Created by spurthi.eshwarappa on 04/03/23.
//

import Foundation

typealias AirlineList = [AirlineData]

struct AirlineData: Codable {
    let airportCode: String
    let airportName: String
    let country: country
    let location: location
    let city: city
}

struct country: Codable {
    let countryCode: String?
    let countryName: String?
}

struct location: Codable {
    let longitudeDirection: String?
}

struct city: Codable {
    let cityName: String?
    let timeZoneName: String?
}
