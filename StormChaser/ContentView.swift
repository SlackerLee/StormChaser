//
//  ContentView.swift
//  SwiftUI-Weather
//
//  Created by Tung on 5/11/2024.
//

import SwiftUI
import CoreData
import MapKit

struct ContentView: View {
    @State private var isNight: Bool = false
    @StateObject private var locationManager = LocationManager()
    @State private var forecastData: [WeatherData] = []
    @EnvironmentObject var appThemeManager: AppThemeManager
    
    // Timer for 10-second auto refresh
    let timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()

    var body: some View {
        NavigationStack{
            ZStack {
                BackgroundView(isNight: appThemeManager.isNight)
                VStack(spacing: 10) {
                   
                    // Main weather status (first day's max temp)
                    MainWeatherViewStatusView(
                        imageName: forecastData.first?.iconName ?? "cloud.fill",
                        weatherData: forecastData.first
                    )
                    // City name with fallback
                    NavigationLink(
                        destination: MapView(
                            coordinate: locationManager.lastKnownLocation,
                            cityName: locationManager.cityName ?? "Unknown"
                        )
                    ) {
                        CityTextView(cityName: locationManager.cityName?.isEmpty == false ? locationManager.cityName! : "Canada, CA", timezone: forecastData.first?.timezone ?? "")

                    }
                    .buttonStyle(PlainButtonStyle()) // Optional: removes default NavigationLink styling
                   

                    // 7-Day forecast
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(forecastData, id: \.self) { data in
                                WeatherDayView(
                                    dayOfWeek: data.dayOfWeek,
                                    date: data.dateString,
                                    imageName: data.iconName,
                                    temperature: data.temperatureMax
                                )
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // Navigation Buttons
                    HStack(spacing: 12) {
                        Button {
                            appThemeManager.isNight.toggle()
                        } label: {
                            DarkModeButton(title: "Dark mode", textColor: .white, backgroundColor: .gray)
                        }.background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.black.opacity(0.1))
                        )
                        VStack(spacing: 12) {
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
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color.black.opacity(0.1))
                                )
                                .foregroundColor(.white)
                                .clipShape(Capsule())
                            }
                            
                            NavigationLink(destination: StormDocumentationListView()) {
                                HStack {
                                    Image(systemName: "photo.on.rectangle.angled")
                                    Text("Storm Documentation")
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color.black.opacity(0.1))
                                )
                                .foregroundColor(.white)
                                .clipShape(Capsule())
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .onAppear {
                locationManager.checkLocationAuthorization()
            }
            .onChange(of: locationManager.lastKnownLocation) { oldValue, newValue in
                fetchForecast()
            }.onReceive(timer) { _ in
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
