//
//  StormDocumentation.swift
//  StormChaser
//
//  Created by Tung on 16/7/2025.
//

import Foundation
import CoreLocation
import UIKit

// Storm classification enum
enum StormType: String, CaseIterable, Codable {
    case thunderstorm = "Thunderstorm"
    case tornado = "Tornado"
    case hurricane = "Hurricane"
    case blizzard = "Blizzard"
    case hail = "Hail Storm"
    case lightning = "Lightning Storm"
    case heavyRain = "Heavy Rain"
    case other = "Other"
    
    var icon: String {
        switch self {
        case .thunderstorm: return "cloud.bolt.rain.fill"
        case .tornado: return "tornado"
        case .hurricane: return "hurricane"
        case .blizzard: return "snow"
        case .hail: return "cloud.hail.fill"
        case .lightning: return "bolt.fill"
        case .heavyRain: return "cloud.rain.fill"
        case .other: return "cloud.fill"
        }
    }
}

// Weather conditions at time of documentation
struct WeatherConditions: Codable {
    let temperature: Double?
    let humidity: Double?
    let windSpeed: Double?
    let pressure: Double?
    let visibility: Double?
    let weatherCode: Int?
    let description: String?
}

// Storm documentation entry
struct StormDocumentation: Identifiable, Codable {
    let id = UUID()
    let photoData: Data
    let location: CLLocationCoordinate2D
    let dateTime: Date
    let notes: String
    let stormType: StormType
    let weatherConditions: WeatherConditions
    
    // Custom coding keys for CLLocationCoordinate2D
    enum CodingKeys: String, CodingKey {
        case id, photoData, location, dateTime, notes, stormType, weatherConditions
    }
    
    init(photoData: Data, location: CLLocationCoordinate2D, dateTime: Date, notes: String, stormType: StormType, weatherConditions: WeatherConditions) {
        self.photoData = photoData
        self.location = location
        self.dateTime = dateTime
        self.notes = notes
        self.stormType = stormType
        self.weatherConditions = weatherConditions
    }
    
    // Custom encoding for CLLocationCoordinate2D
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(photoData, forKey: .photoData)
        try container.encode(dateTime, forKey: .dateTime)
        try container.encode(notes, forKey: .notes)
        try container.encode(stormType, forKey: .stormType)
        try container.encode(weatherConditions, forKey: .weatherConditions)
        
        // Encode location as separate latitude and longitude
        try container.encode(location.latitude, forKey: .location)
        try container.encode(location.longitude, forKey: .location)
    }
    
    // Custom decoding for CLLocationCoordinate2D
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        photoData = try container.decode(Data.self, forKey: .photoData)
        dateTime = try container.decode(Date.self, forKey: .dateTime)
        notes = try container.decode(String.self, forKey: .notes)
        stormType = try container.decode(StormType.self, forKey: .stormType)
        weatherConditions = try container.decode(WeatherConditions.self, forKey: .weatherConditions)
        
        // Decode location from separate latitude and longitude
        let latitude = try container.decode(Double.self, forKey: .location)
        let longitude = try container.decode(Double.self, forKey: .location)
        location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
} 