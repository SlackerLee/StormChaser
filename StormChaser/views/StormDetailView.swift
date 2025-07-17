//
//  StormDetailView.swift
//  StormChaser
//
//  Created by Tung on 16/7/2025.
//

import SwiftUI

struct StormDetailView: View {
    @State private var stormData: [StormDetailData] = []
    @State private var isLoading: Bool = true
    @State private var hasError: Bool = false

    let latitude: Double
    let longitude: Double

    var body: some View {
        VStack {
            if isLoading {
                ProgressView("Loading weather data...")
                    .padding()
            } else if hasError || stormData.isEmpty {
                NotFoundView()
            } else {
                List(stormData.prefix(24), id: \.self) { detail in
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "clock.fill")
                            Text("\(formatTime(detail.time))")
                            .font(.headline)
                        }
                        HStack {
                            Image(systemName: "drop.fill")
                            Text("Precipitation: \(detail.precipitation, specifier: "%.1f") mm")
                        }
                        HStack {
                            Image(systemName: "wind")
                            Text("Wind: \(detail.windSpeed, specifier: "%.0f") km/h")
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .onAppear {
            fetchStormDetails()
        }
        .navigationTitle("Storm Tracker")
        .navigationBarTitleDisplayMode(.inline)
    }

    func fetchStormDetails() {
        ForecastManager.shared.fetchStormDetails(latitude: latitude, longitude: longitude) { data in
            if let data = data {
                self.stormData = data
                self.hasError = false
            } else {
                self.hasError = true
            }
            self.isLoading = false
        }
    }

    func formatTime(_ timeString: String) -> String {
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: timeString) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateFormat = "MMM d, HH:mm"
            return displayFormatter.string(from: date)
        }
        return timeString
    }
}

#Preview {
    StormDetailView(latitude: 10.762622, longitude: 106.660172)
}
