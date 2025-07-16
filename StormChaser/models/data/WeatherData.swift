//
//  WeatherData.swift
//  SwiftUI-Weather
//
//  Created by Tung on 5/11/2024.
//

struct WeatherData: Hashable {
    let timezone: String
    let dayOfWeek: String
    let temperatureMax: Int
    let temperatureMin: Int
    let weatherCode: Int
    let apparentTemperature: Int
    let windSpeed: Double
    let windGust: Double
    let precipitation: Double
    let dateString: String
    
    var statusText: String {
        WeatherStatusMapper.status(for: weatherCode)
    }

    var iconName: String {
        WeatherStatusMapper.symbol(for: weatherCode)
    }
}
