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
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack {
            Text(dayOfWeek).font(.system(size: 16, weight: .medium,design: .default)).foregroundColor(.white)
            Image(systemName: imageName)
//                .renderingMode(.original)
                .symbolRenderingMode(.multicolor)
                .resizable()
                .foregroundStyle(.pink, .orange, .green)
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            
            Text("\(temperature)°").font(.system(size: 28, weight: .medium)).foregroundColor(.white)
        }
    }
}
#Preview {
    WeatherDayView(dayOfWeek: "TUE", imageName: "sun.max.fill", temperature: 100).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
