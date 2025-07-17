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
    @EnvironmentObject var appThemeManager: AppThemeManager

    let latitude: Double
    let longitude: Double

    var body: some View {
        ZStack {
            BackgroundView(isNight: appThemeManager.isNight)
            VStack {
                if isLoading {
                    ProgressView("Loading weather data...")
                        .padding()
                        .foregroundColor(.white)
                } else if hasError || stormData.isEmpty {
                    NotFoundView()
                } else {
                    List(stormData.prefix(24), id: \.self) { detail in
                        VStack(alignment: .leading) {
                            HStack {
                                Image(systemName: "clock.fill")
                                    .foregroundColor(.white)
                                Text("\(formatTime(detail.time))")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                            HStack {
                                Image(systemName: "drop.fill")
                                    .foregroundColor(.white)
                                Text("Precipitation: \(detail.precipitation, specifier: "%.1f") mm")
                                    .foregroundColor(.white)
                            }
                            HStack {
                                Image(systemName: "wind")
                                    .foregroundColor(.white)
                                Text("Wind: \(detail.windSpeed, specifier: "%.0f") km/h")
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.vertical, 0)
                        .listRowBackground(Color.clear)
                    }
                    .scrollContentBackground(.hidden)
                    .listStyle(.grouped)
                    .listRowSeparatorTint(.white)
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
