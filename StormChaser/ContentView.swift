//
//  ContentView.swift
//  SwiftUI-Weather
//
//  Created by Tung on 5/11/2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var isNight: Bool = false
    @StateObject private var locationManager = LocationManager()
    @State private var forecastData: [WeatherData] = []

    var body: some View {
        NavigationStack{
            ZStack {
                BackgroundView(isNight: isNight)

                VStack(spacing: 10) {
                    // City name with fallback
                    CityTextView(cityName: locationManager.cityName?.isEmpty == false ? locationManager.cityName! : "Canada, CA")

                    // Main weather status (first day's max temp)
                    MainWeatherViewStatusView(
                        imageName: forecastData.first?.iconName ?? "cloud.fill",
                        temperature: forecastData.first?.temperatureMax ?? 0
                    )

                    // 7-Day forecast
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(forecastData, id: \.self) { data in
                                WeatherDayView(
                                    dayOfWeek: data.dayOfWeek,
                                    imageName: data.iconName,
                                    temperature: data.temperatureMax
                                )
                            }
                        }
                        .padding(.horizontal)
                    }
                    Spacer()

                    Button {
                        isNight.toggle()
                    } label: {
                        WeatherButton(title: "Change Day time", textColor: .white, backgroundColor: .gray)
                    }

                    Spacer()
                    NavigationLink(destination: {
                        if let lat = locationManager.lastKnownLocation?.latitude,
                           let lon = locationManager.lastKnownLocation?.longitude {
                            StormDetailView(latitude: lat, longitude: lon)
                        } else {
                            NotFoundView()
                        }
                    }) {
                        
                        HStack {
                            Image(systemName: "tropicalstorm")
                            Text("View Storm Tracker")
                                .bold()
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .clipShape(Capsule())

                    }
                    .padding()
                }
            }
            .onAppear {
                locationManager.checkLocationAuthorization()
            }
            .onChange(of: locationManager.lastKnownLocation) { oldValue, newValue in
                fetchForecast()
            }
        }
        
    }

    func fetchForecast() {
        guard let coordinate = locationManager.lastKnownLocation else { return }

        ForecastManager.shared.fetchWeatherForecast(
            latitude: coordinate.latitude,
            longitude: coordinate.longitude
        ) { data in
            if let data = data {
                self.forecastData = data
            }
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
