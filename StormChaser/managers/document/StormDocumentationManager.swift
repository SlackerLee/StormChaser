//
//  StormDocumentationManager.swift
//  StormChaser
//
//  Created by Tung on 16/7/2025.
//

import Foundation
import CoreLocation
import UIKit

class StormDocumentationManager: ObservableObject {
    @Published var stormDocumentations: [StormDocumentation] = []
    
    private let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    private let stormDocumentationsFileName = "stormDocumentations.json"
    
    init() {
        loadStormDocumentations()
    }
    
    func saveStormDocumentation(
        photo: UIImage,
        location: CLLocationCoordinate2D,
        notes: String,
        stormType: StormType,
        weatherConditions: WeatherConditions
    ) {
        guard let photoData = photo.jpegData(compressionQuality: 0.8) else {
            print("Failed to convert image to data")
            return
        }
        
        let documentation = StormDocumentation(
            photoData: photoData,
            location: location,
            dateTime: Date(),
            notes: notes,
            stormType: stormType,
            weatherConditions: weatherConditions
        )
        
        stormDocumentations.append(documentation)
        saveToFile()
    }
    
    func deleteStormDocumentation(_ documentation: StormDocumentation) {
        stormDocumentations.removeAll { $0.id == documentation.id }
        saveToFile()
    }

    func getStormDocumentations(near location: CLLocationCoordinate2D, radius: Double = 10.0) -> [StormDocumentation] {
        return stormDocumentations.filter { documentation in
            let distance = calculateDistance(from: location, to: documentation.location)
            return distance <= radius
        }
    }
    
    // MARK: - Get Storm Documentation by Date Range
    func getStormDocumentations(from startDate: Date, to endDate: Date) -> [StormDocumentation] {
        return stormDocumentations.filter { documentation in
            documentation.dateTime >= startDate && documentation.dateTime <= endDate
        }
    }
    
    // MARK: - Get Storm Documentation by Type
    func getStormDocumentations(of type: StormType) -> [StormDocumentation] {
        return stormDocumentations.filter { $0.stormType == type }
    }
    
    // MARK: - Private Methods
    private func saveToFile() {
        let fileURL = documentsPath.appendingPathComponent(stormDocumentationsFileName)
        
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let data = try encoder.encode(stormDocumentations)
            try data.write(to: fileURL)
        } catch {
            print("Failed to save storm documentations: \(error)")
        }
    }
    
    private func loadStormDocumentations() {
        let fileURL = documentsPath.appendingPathComponent(stormDocumentationsFileName)
        
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            return
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            stormDocumentations = try decoder.decode([StormDocumentation].self, from: data)
        } catch {
            print("Failed to load storm documentations: \(error)")
        }
    }
    
    private func calculateDistance(from coord1: CLLocationCoordinate2D, to coord2: CLLocationCoordinate2D) -> Double {
        let location1 = CLLocation(latitude: coord1.latitude, longitude: coord1.longitude)
        let location2 = CLLocation(latitude: coord2.latitude, longitude: coord2.longitude)
        return location1.distance(from: location2) / 1000 // Convert to kilometers
    }
} 
