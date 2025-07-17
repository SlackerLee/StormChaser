//
//  MainWeatherViewStatusView.swift
//  SwiftUI-Weather
//
//  Created by Tung on 5/11/2024.
//

import SwiftUI
import CoreData

struct MainWeatherViewStatusView: View {
    var imageName: String
    var weatherData: WeatherData?
    
    var body: some View {
        VStack {
            VStack(spacing: 8) {
                DateTimeView(forecastData: weatherData)
                HStack (spacing: 10) {
                    VStack(alignment: .center) {
                        Image(systemName: imageName)
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 180, height: 180)

                    }
                    VStack(alignment: .leading, spacing: 5) {
                       
                        if let weatherData = weatherData {
                            Text("\(weatherData.temperatureMax)°C")
                               .font(.system(size: 75, weight: .bold))
                               .foregroundColor(.white)

                           Text("Feels like: \(weatherData.apparentTemperature)°C")
                                .font(.title2)
                               .foregroundColor(.white.opacity(0.6))

                           Text("Wind: \(Int(weatherData.windSpeed)) km/h")
                               .font(.title2)
                               .foregroundColor(.white.opacity(0.6))

                           Text("Rain: \(weatherData.precipitation, specifier: "%.1f") mm")
                               .font(.title2)
                               .foregroundColor(.white.opacity(0.6))
                        } else {
                            Text("Weather data not found")
                                .font(.title3)
                                .foregroundColor(.gray)
                        }
                        
                    }
                    
                }
            
            }
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
//            .background(
//                RoundedRectangle(cornerRadius: 16)
//                        .fill(Color.black.opacity(0.1))
//            )

        }
    }
}
#Preview {
    MainWeatherViewStatusView(imageName: "sun.max.fill", weatherData: WeatherData(timezone: "test", dayOfWeek: "12/2", temperatureMax: 12, temperatureMin: 23, weatherCode: 2, apparentTemperature: 23, windSpeed: 123, windGust: 23, precipitation: 23, dateString: "WED 7/16"))
}
