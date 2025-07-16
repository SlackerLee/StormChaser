//
//  DailyWeatherData.swift
//  StormChaser
//
//  Created by Tung on 16/7/2025.
//

struct DailyWeatherData: Decodable {
    let time: [String]
    let temperature_2m_max: [Double]
    let temperature_2m_min: [Double]
    let weather_code: [Int]
}
