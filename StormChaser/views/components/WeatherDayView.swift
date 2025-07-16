//
//  WeatherDayView.swift
//  SwiftUI-Weather
//
//  Created by Tung on 5/11/2024.
//
import SwiftUI
import CoreData

struct WeatherDayView: View {
    var dayOfWeek: String
    var date: String
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack {
            Text(dayOfWeek).font(.system(size: 20, weight: .medium,design: .default)).foregroundColor(.white)
            Text(formatDate(date)).font(.system(size: 15, weight: .medium,design: .default)).foregroundColor(.white)
            Image(systemName: imageName)
//                .renderingMode(.original)
                .symbolRenderingMode(.multicolor)
                .resizable()
                .foregroundStyle(.pink, .orange, .green)
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            
            Text("\(temperature)°C").font(.system(size: 28, weight: .medium)).foregroundColor(.white)
        }
    }
    
    func formatDate(_ dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "M/d" // "Thu 7/17"

        if let date = inputFormatter.date(from: dateString) {
            return outputFormatter.string(from: date).uppercased() // "THU 7/17"
        } else {
            return dateString // fallback if parsing fails
        }
    }
}
#Preview {
    WeatherDayView(dayOfWeek: "TUE", date: "2/4", imageName: "sun.max.fill", temperature: 100).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
