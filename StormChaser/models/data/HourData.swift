//
//  HourData.swift
//  StormChaser
//
//  Created by Tung on 16/7/2025.
//

struct HourlyData: Decodable {
    let time: [String]
    let windspeed_10m: [Double]
    let precipitation: [Double]
}
