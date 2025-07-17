//
//  StormDocumentationRowView.swift
//  StormChaser
//
//  Created by Tung on 17/7/2025.
//

import Foundation
import CoreLocation
import SwiftUI

struct StormDocumentationRowView: View {
    let documentation: StormDocumentation
    
    var body: some View {
        HStack(spacing: 12) {
            // Thumbnail
            if let uiImage = UIImage(data: documentation.photoData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            } else {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 60, height: 60)
                    .overlay(
                        Image(systemName: "photo")
                            .foregroundColor(.gray)
                    )
            }
            
            // Content
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Image(systemName: documentation.stormType.icon)
                        .foregroundColor(.blue)
                    Text(documentation.stormType.rawValue)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Spacer()
                    Text(documentation.dateTime, style: .date)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                if !documentation.notes.isEmpty {
                    Text(documentation.notes)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
                
                HStack {
                    Image(systemName: "location")
                        .font(.caption)
                        .foregroundColor(.green)
                    Text("\(documentation.location.latitude, specifier: "%.4f"), \(documentation.location.longitude, specifier: "%.4f")")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    if let temp = documentation.weatherConditions.temperature {
                        HStack(spacing: 2) {
                            Image(systemName: "thermometer")
                                .font(.caption)
                            Text("\(temp, specifier: "%.1f")°C")
                                .font(.caption)
                        }
                        .foregroundColor(.orange)
                    }
                }
            }
        }
        .padding(.vertical, 4)
    }
}
