//
//  WeatherStatusMapper.swift
//  StormChaser
//
//  Created by Tung on 16/7/2025.
//

struct WeatherStatusMapper {
    static func status(for code: Int) -> String {
        switch code {
        case 0: return "Clear"
        case 1, 2: return "Partly Cloudy"
        case 3: return "Overcast"
        case 45, 48: return "Foggy"
        case 51...67: return "Drizzle"
        case 71...77: return "Snow"
        case 80...82: return "Rain Showers"
        case 95...99: return "Thunderstorm"
        default: return "Unknown"
        }
    }

    static func symbol(for code: Int) -> String {
        switch code {
        case 0: return "sun.max.fill"
        case 1, 2: return "cloud.sun.fill"
        case 3: return "cloud.fill"
        case 45, 48: return "cloud.fog.fill"
        case 51...67: return "cloud.drizzle.fill"
        case 71...77: return "snowflake"
        case 80...82: return "cloud.rain.fill"
        case 95...99: return "cloud.bolt.rain.fill"
        default: return "questionmark.app.dashed"
        }
    }
}
