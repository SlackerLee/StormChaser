//
//  ContentView.swift
//  SwiftUI-Weather
//
//  Created by Tung on 5/11/2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    let weatherData = [
        WeatherData(dayOfWeek: "TUE", imageName: "sun.max.fill", temperature: 30),
        WeatherData(dayOfWeek: "WED", imageName: "cloud.sun.fill", temperature: 30),
        WeatherData(dayOfWeek: "THU", imageName: "sun.dust.fill", temperature: 30),
        WeatherData(dayOfWeek: "FRI", imageName: "cloud.fill", temperature: 30),
        WeatherData(dayOfWeek: "SAT", imageName: "cloud.sun.fill", temperature: 30)
    ]
    
    @State private var isNight: Bool = false
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        ZStack{
            BackgroundView(isNight: isNight)
            VStack(spacing: 10) {
                
                CityTextView(cityName: locationManager.cityName ?? "Canada, CA")
                MainWeatherViewStatusView(imageName: isNight ?  "moon.stars.fill": "cloud.fill", temperature: 70)
                HStack(spacing: 20) {
                    ForEach(weatherData, id: \.self) { data in
                        WeatherDayView(dayOfWeek: data.dayOfWeek, imageName: data.imageName, temperature: data.temperature)
                    }
                }
                Spacer()
                Button {
                    isNight.toggle()
                } label: {
                    WeatherButton(title: "Change Day time", textColor: .white,backgroundColor: .gray)
                }
                Spacer()
            }
        }
        .onAppear {
            locationManager.checkLocationAuthorization()
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}


