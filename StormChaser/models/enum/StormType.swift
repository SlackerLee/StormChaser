//
//  StormType.swift
//  StormChaser
//
//  Created by Tung on 16/7/2025.
//

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
