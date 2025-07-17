//
//  MapView.swift
//  StormChaser
//
//  Created by Tung on 17/7/2025.
//
import SwiftUI
import Foundation
import CoreLocation
import UIKit
import MapKit

struct MapView: View {
    let coordinate: CLLocationCoordinate2D?
    let cityName: String

    @State private var region: MKCoordinateRegion

    var annotation: [CityAnnotation] {
        if let coordinate = coordinate {
            return [CityAnnotation(coordinate: coordinate, name: cityName)]
        } else {
            return []
        }
    }

    init(coordinate: CLLocationCoordinate2D?, cityName: String) {
        self.coordinate = coordinate
        self.cityName = cityName
        if let coordinate = coordinate {
            _region = State(initialValue: MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            ))
        } else {
            _region = State(initialValue: MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
                span: MKCoordinateSpan(latitudeDelta: 180, longitudeDelta: 360)
            ))
        }
    }

    var body: some View {
        ZStack {
            if let _ = coordinate {
                Map(coordinateRegion: $region, annotationItems: annotation) { item in
                    MapMarker(coordinate: item.coordinate, tint: .red)
                }
                .edgesIgnoringSafeArea(.all)
            } else {
                Text("Location not available")
                    .foregroundColor(.white)
            }
        }
        .navigationTitle(cityName)
        .navigationBarTitleDisplayMode(.inline)
    }
}
