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
    @StateObject private var documentationManager = StormDocumentationManager()
    
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
//        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Photo Section
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Storm Photo")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
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
                                        .foregroundColor(.blue)
                                    Text("Take Photo")
                                        .font(.headline)
                                        .foregroundColor(.blue)
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height: 200)
                                .background(Color.gray.opacity(0.1))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.blue, style: StrokeStyle(lineWidth: 2, dash: [5]))
                                )
                            }
                        }
                    }
                    
                    // Storm Type Selection
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Storm Type")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 10) {
                            ForEach(StormType.allCases, id: \.self) { stormType in
                                Button(action: {
                                    selectedStormType = stormType
                                }) {
                                    HStack {
                                        Image(systemName: stormType.icon)
                                            .foregroundColor(selectedStormType == stormType ? .white : .blue)
                                        Text(stormType.rawValue)
                                            .font(.caption)
                                            .foregroundColor(selectedStormType == stormType ? .white : .primary)
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
                            .foregroundColor(.primary)
                        
                        VStack(spacing: 12) {
                            HStack {
                                Text("Temperature (°C)")
                                Spacer()
                                TextField("25.0", text: $temperature)
                                    .keyboardType(.decimalPad)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .frame(width: 100)
                            }
                            
                            HStack {
                                Text("Humidity (%)")
                                Spacer()
                                TextField("60", text: $humidity)
                                    .keyboardType(.decimalPad)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .frame(width: 100)
                            }
                            
                            HStack {
                                Text("Wind Speed (km/h)")
                                Spacer()
                                TextField("15.0", text: $windSpeed)
                                    .keyboardType(.decimalPad)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .frame(width: 100)
                            }
                            
                            HStack {
                                Text("Pressure (hPa)")
                                Spacer()
                                TextField("1013", text: $pressure)
                                    .keyboardType(.decimalPad)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .frame(width: 100)
                            }
                            
                            HStack {
                                Text("Visibility (km)")
                                Spacer()
                                TextField("10.0", text: $visibility)
                                    .keyboardType(.decimalPad)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .frame(width: 100)
                            }
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Weather Description")
                                TextField("Partly cloudy with strong winds", text: $weatherDescription)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                        }
                    }
                    
                    // Notes Section
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Notes & Description")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        TextEditor(text: $notes)
                            .frame(minHeight: 100)
                            .padding(8)
                            .background(Color.gray.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                    }
                    
                    // Location Info
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Location")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        if let location = locationManager.lastKnownLocation {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Latitude: \(location.latitude, specifier: "%.6f")")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text("Longitude: \(location.longitude, specifier: "%.6f")")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                if let cityName = locationManager.cityName {
                                    Text("City: \(cityName)")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding()
                            .background(Color.green.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        } else {
                            HStack {
                                Image(systemName: "location.slash")
                                    .foregroundColor(.red)
                                Text("Location not available")
                                    .foregroundColor(.red)
                            }
                            .padding()
                            .background(Color.red.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }
                    
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
                        .background(selectedImage != nil ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .disabled(selectedImage == nil || isSaving)
                }
                .padding()
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
//        }
    }
    
    private func saveDocumentation() {
        guard let image = selectedImage else {
            alertMessage = "Please take a photo first"
            showingAlert = true
            return
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
