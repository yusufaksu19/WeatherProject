//
//  WeatherModel.swift
//  WeatherProject
//
//  Created by Yusuf Aksu on 27.11.2022.
//

import Foundation

// MARK: - Weather
struct WeatherModel: Codable {
    let request: Request
    let location: Location
    let current: Current
}

// MARK: - Current
struct Current: Codable {
    let observationTime: String
    let temperature, weatherCode: Int
    let weatherIcons: [String]
    let weatherDescriptions: [String]
    let windSpeed, windDegree: Int
    let windDir: String
    let pressure, precip, humidity, cloudcover: Int
    let feelslike, uvIndex, visibility: Int
    let isDay: String

    enum CodingKeys: String, CodingKey {
        case observationTime = "observation_time"
        case temperature
        case weatherCode = "weather_code"
        case weatherIcons = "weather_icons"
        case weatherDescriptions = "weather_descriptions"
        case windSpeed = "wind_speed"
        case windDegree = "wind_degree"
        case windDir = "wind_dir"
        case pressure, precip, humidity, cloudcover, feelslike
        case uvIndex = "uv_index"
        case visibility
        case isDay = "is_day"
    }
}

// MARK: - Location
struct Location: Codable {
    let name, country, region, lat: String
    let lon: String

    enum CodingKeys: String, CodingKey {
        case name, country, region, lat, lon
    }
}

// MARK: - Request
struct Request: Codable {
    let type, query, language, unit: String
}
