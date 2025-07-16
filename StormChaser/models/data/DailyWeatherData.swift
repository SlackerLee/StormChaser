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
    let apparent_temperature_max: [Double]
    let windspeed_10m_max: [Double]
    let windgusts_10m_max: [Double]
    let precipitation_sum: [Double]
    let weathercode: [Int]
}
