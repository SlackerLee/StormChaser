//
//  CityAnnotation.swift
//  StormChaser
//
//  Created by Tung on 17/7/2025.
//

import Foundation
import CoreLocation
import UIKit

struct CityAnnotation: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let name: String
}
