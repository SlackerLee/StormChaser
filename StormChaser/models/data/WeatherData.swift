//
//  WeatherData.swift
//  SwiftUI-Weather
//
//  Created by Tung on 5/11/2024.
//

struct WeatherData: Hashable {
    let dayOfWeek: String
    let temperatureMax: Int
    let temperatureMin: Int
    let weatherCode: Int
    
    var statusText: String {
        WeatherStatusMapper.status(for: weatherCode)
    }

    var iconName: String {
        WeatherStatusMapper.symbol(for: weatherCode)
    }
}
