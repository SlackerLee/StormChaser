//
//  StormDocumentationFormView.swift
//  StormChaser
//
//  Created by Tung on 16/7/2025.
//

import SwiftUI
import CoreLocation

struct StormDocumentationFormView: View {
    @StateObject private var locationManager = LocationManager()
    @ObservedObject var documentationManager: StormDocumentationManager
    @EnvironmentObject var appThemeManager: AppThemeManager
    
    @State private var selectedImage: UIImage?
    @State private var showingCamera = false
    @State private var notes = ""
    @State private var selectedStormType: StormType = .thunderstorm
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var isSaving = false
    
    // Weather conditions
    @State private var temperature: String = ""
    @State private var humidity: String = ""
    @State private var windSpeed: String = ""
    @State private var pressure: String = ""
    @State private var visibility: String = ""
    @State private var weatherDescription: String = ""
    
    var body: some View {
        ZStack {
            BackgroundView(isNight: appThemeManager.isNight)
            ScrollView {
                VStack(spacing: 20) {
                    // Photo Section
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Storm Photo")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        if let image = selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxHeight: 300)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .overlay(
                                    Button("Retake") {
                                        showingCamera = true
                                    }
                                    .padding(8)
                                    .background(Color.black.opacity(0.7))
                                    .foregroundColor(.white)
                                    .clipShape(Capsule())
                                    .padding(8),
                                    alignment: .topTrailing
                                )
                        } else {
                            Button(action: {
                                showingCamera = true
                            }) {
                                VStack(spacing: 12) {
                                    Image(systemName: "camera.fill")
                                        .font(.system(size: 40))
                                        .foregroundColor(.white)
                                    Text("Take Photo")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height: 200)
                                .background(Color.gray.opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.white, style: StrokeStyle(lineWidth: 2, dash: [5]))
                                )
                            }
                        }
                    }
                    
                    // Storm Type Selection
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Storm Type")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 10) {
                            ForEach(StormType.allCases, id: \.self) { stormType in
                                Button(action: {
                                    selectedStormType = stormType
                                }) {
                                    HStack {
                                        Image(systemName: stormType.icon)
                                            .foregroundColor(.white)
                                        Text(stormType.rawValue)
                                            .font(.caption)
                                            .foregroundColor(.white)
                                    }
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 12)
                                    .background(selectedStormType == stormType ? Color.blue : Color.gray.opacity(0.1))
                                    .clipShape(Capsule())
                                }
                            }
                        }
                    }
                    
                    // Weather Conditions
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Weather Conditions")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        VStack(spacing: 12) {
                            HStack {
                                Text("Temperature (°C)")
                                .foregroundColor(.white)
                                Spacer()
                                TextField("25.0", text: $temperature)
                                    .keyboardType(.decimalPad)
                                    .padding(8)
                                    .background(Color.white.opacity(0.8))
                                    .cornerRadius(8)
                                    .frame(width: 100)
                                    .foregroundColor(.black)
                            }
                            
                            HStack {
                                Text("Humidity (%)")
                                .foregroundColor(.white)
                                Spacer()
                                TextField("60", text: $humidity)
                                    .keyboardType(.decimalPad)
                                    .padding(8)
                                    .background(Color.white.opacity(0.8))
                                    .cornerRadius(8)
                                    .frame(width: 100)
                                    .foregroundColor(.black)
                            }
                            
                            HStack {
                                Text("Wind Speed (km/h)")
                                .foregroundColor(.white)
                                Spacer()
                                TextField("15.0", text: $windSpeed)
                                    .keyboardType(.decimalPad)
                                    .padding(8)
                                    .background(Color.white.opacity(0.8))
                                    .cornerRadius(8)
                                    .frame(width: 100)
                                    .foregroundColor(.black)
                            }
                            
                            HStack {
                                Text("Pressure (hPa)")
                                .foregroundColor(.white)
                                Spacer()
                                TextField("1013", text: $pressure)
                                    .keyboardType(.decimalPad)
                                    .padding(8)
                                    .background(Color.white.opacity(0.8))
                                    .cornerRadius(8)
                                    .frame(width: 100)
                                    .foregroundColor(.black)
                            }
                            
                            HStack {
                                Text("Visibility (km)")
                                .foregroundColor(.white)
                                Spacer()
                                TextField("10.0", text: $visibility)
                                    .keyboardType(.decimalPad)
                                    .padding(8)
                                    .background(Color.white.opacity(0.8))
                                    .cornerRadius(8)
                                    .frame(width: 100)
                                    .foregroundColor(.black)
                            }
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Weather Description")
                                    .foregroundColor(.white)
                                TextField("Partly cloudy with strong winds", text: $weatherDescription)
                                    .padding(8)
                                    .background(Color.white.opacity(0.8))
                                    .cornerRadius(8)
                                    .foregroundColor(.black)
                            }

                            VStack(alignment: .leading, spacing: 5) {
                                Text("Notes & Description")
                                    .foregroundColor(.white)
                                TextField("", text: $notes)
                                    .padding(8)
                                    .background(Color.white.opacity(0.8))
                                    .cornerRadius(8)
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    
                    // Location Info
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Location")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        if let location = locationManager.lastKnownLocation {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Latitude: \(location.latitude, specifier: "%.6f")")
                                    .font(.caption)
                                    .foregroundColor(.white)
                                Text("Longitude: \(location.longitude, specifier: "%.6f")")
                                    .font(.caption)
                                    .foregroundColor(.white)
                                if let cityName = locationManager.cityName {
                                    Text("City: \(cityName)")
                                        .font(.caption)
                                        .foregroundColor(.white)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(Color.green.opacity(0.7))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            
                        } else {
                            HStack {
                                Image(systemName: "location.slash")
                                    .foregroundColor(.red)
                                Text("Location not available")
                                    .foregroundColor(.red)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            
                        }
                    }.frame(maxWidth: .infinity)
                    
                    // Save Button
                    Button(action: saveDocumentation) {
                        HStack {
                            if isSaving {
                                ProgressView()
                                    .scaleEffect(0.8)
                                    .foregroundColor(.white)
                            } else {
                                Image(systemName: "square.and.arrow.down")
                                Text("Save Documentation")
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
//                        .background(selectedImage != nil ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
//                    .disabled(selectedImage == nil || isSaving)
                }
                .padding()
            }
        }
        .navigationTitle("Storm Documentation")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingCamera) {
            StormCameraView(selectedImage: $selectedImage)
        }
        .alert("Documentation", isPresented: $showingAlert) {
            Button("OK") { }
        } message: {
            Text(alertMessage)
        }
        .onAppear {
            locationManager.checkLocationAuthorization()
        }
        
    }
    
    private func saveDocumentation() {
        guard let image = selectedImage else {
            alertMessage = "Please take a photo first"
            showingAlert = true
            return
        }
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 100, height: 100))
        let dummyImage = renderer.image { context in
            UIColor.lightGray.setFill()
            context.fill(CGRect(x: 0, y: 0, width: 100, height: 100))
        }
        
        guard let location = locationManager.lastKnownLocation else {
            alertMessage = "Location not available. Please enable location services."
            showingAlert = true
            return
        }
        
        isSaving = true
        
        let weatherConditions = WeatherConditions(
            temperature: Double(temperature),
            humidity: Double(humidity),
            windSpeed: Double(windSpeed),
            pressure: Double(pressure),
            visibility: Double(visibility),
            weatherCode: nil,
            description: weatherDescription.isEmpty ? nil : weatherDescription
        )
        
        
        documentationManager.saveStormDocumentation(
            photo: image,
            location: location,
            notes: notes,
            stormType: selectedStormType,
            weatherConditions: weatherConditions
        )
        
        isSaving = false
        alertMessage = "Storm documentation saved successfully!"
        showingAlert = true
        
        // Reset form
        selectedImage = nil
        notes = ""
        temperature = ""
        humidity = ""
        windSpeed = ""
        pressure = ""
        visibility = ""
        weatherDescription = ""
    }
} 
