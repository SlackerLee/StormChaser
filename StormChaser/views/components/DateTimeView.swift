//
//  DateTimeView.swift
//  StormChaser
//
//  Created by Tung on 16/7/2025.
//


import SwiftUI
import CoreData

struct DateTimeView: View {
    var forecastData: WeatherData?
    
    var body: some View {
        if let forecastData = forecastData {
            Text("\(formatDate(forecastData.dateString))")
                .font(.largeTitle)
                .foregroundColor(.white.opacity(0.8))
        }
        
    }
    
    func formatDate(_ dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "EEE M/d" // "Thu 7/17"

        if let date = inputFormatter.date(from: dateString) {
            return outputFormatter.string(from: date).uppercased() // "THU 7/17"
        } else {
            return dateString // fallback if parsing fails
        }
    }
}

#Preview {
    DateTimeView(forecastData: WeatherData(timezone: "text",dayOfWeek: "12/2", temperatureMax: 12, temperatureMin: 23, weatherCode: 2, apparentTemperature: 23, windSpeed: 123, windGust: 23, precipitation: 23, dateString: "ett"))
}
