//
//  StormDocumentationDetailView.swift
//  StormChaser
//
//  Created by Tung on 16/7/2025.
//

import SwiftUI
import MapKit

struct StormDocumentationDetailView: View {
    let documentation: StormDocumentation
    @StateObject private var documentationManager = StormDocumentationManager()
    @State private var showingDeleteAlert = false
    @State private var region: MKCoordinateRegion
    @EnvironmentObject var appThemeManager: AppThemeManager
    
    init(documentation: StormDocumentation) {
        self.documentation = documentation
        self._region = State(initialValue: MKCoordinateRegion(
            center: documentation.location,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        ))
    }
    
    var body: some View {
        ZStack {
            BackgroundView(isNight: appThemeManager.isNight)
            ScrollView {
                VStack(spacing: 20) {
                    // Photo Section
                    if let uiImage = UIImage(data: documentation.photoData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .shadow(radius: 5)
                    }
                    
                    // Storm Type and Date
                    VStack(spacing: 8) {
                        HStack {
                            Image(systemName: documentation.stormType.icon)
                                .font(.title2)
                                .foregroundColor(.blue)
                            Text(documentation.stormType.rawValue)
                                .font(.title2)
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        
                        HStack {
                            Image(systemName: "calendar")
                                .foregroundColor(.gray)
                            Text(documentation.dateTime, style: .date)
                                .foregroundColor(.gray)
                            Spacer()
                            Image(systemName: "clock")
                                .foregroundColor(.gray)
                            Text(documentation.dateTime, style: .time)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    // Weather Conditions
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Weather Conditions")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 12) {
                            WeatherInfoCard(
                                icon: "thermometer",
                                title: "Temperature",
                                value: documentation.weatherConditions.temperature,
                                unit: "°C",
                                color: .orange
                            )
                            
                            WeatherInfoCard(
                                icon: "humidity",
                                title: "Humidity",
                                value: documentation.weatherConditions.humidity,
                                unit: "%",
                                color: .blue
                            )
                            
                            WeatherInfoCard(
                                icon: "wind",
                                title: "Wind Speed",
                                value: documentation.weatherConditions.windSpeed,
                                unit: "km/h",
                                color: .green
                            )
                            
                            WeatherInfoCard(
                                icon: "gauge",
                                title: "Pressure",
                                value: documentation.weatherConditions.pressure,
                                unit: "hPa",
                                color: .purple
                            )
                            
                            WeatherInfoCard(
                                icon: "eye",
                                title: "Visibility",
                                value: documentation.weatherConditions.visibility,
                                unit: "km",
                                color: .cyan
                            )
                        }
                        
                        if let description = documentation.weatherConditions.description, !description.isEmpty {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Description")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                Text(description)
                                    .font(.body)
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                            .background(Color.blue.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }
                    
                    // Notes Section
                    if !documentation.notes.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Notes & Description")
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            Text(documentation.notes)
                                .font(.body)
                                .foregroundColor(.secondary)
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }
                    
                    // Location Map
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Location")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        Map(coordinateRegion: $region, annotationItems: [documentation]) { doc in
                            MapMarker(coordinate: doc.location, tint: .red)
                        }
                        .frame(height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        HStack {
                            Image(systemName: "location")
                                .foregroundColor(.red)
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Latitude: \(documentation.location.latitude, specifier: "%.6f")")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text("Longitude: \(documentation.location.longitude, specifier: "%.6f")")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                    
                    // Delete Button
                    Button(action: {
                        showingDeleteAlert = true
                    }) {
                        HStack {
                            Image(systemName: "trash")
                            Text("Delete Documentation")
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Storm Details")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete Documentation", isPresented: $showingDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                documentationManager.deleteStormDocumentation(documentation)
            }
        } message: {
            Text("Are you sure you want to delete this storm documentation? This action cannot be undone.")
        }
    }
}

struct WeatherInfoCard: View {
    let icon: String
    let title: String
    let value: Double?
    let unit: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            
            if let value = value {
                Text("\(value, specifier: "%.1f") \(unit)")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
            } else {
                Text("N/A")
                    .font(.headline)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
