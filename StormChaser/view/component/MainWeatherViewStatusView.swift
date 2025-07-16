//
//  MainWeatherViewStatusView.swift
//  SwiftUI-Weather
//
//  Created by Tung on 5/11/2024.
//

import SwiftUI
import CoreData

struct MainWeatherViewStatusView: View {
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack {
            VStack(spacing: 8) {
                Image(systemName: imageName)
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 180, height: 180)
                
                Text("\(temperature)°").font(.system(size: 70))
                    .foregroundColor(.white)
            }.padding(.bottom, 40)
        }
    }
}
#Preview {
    MainWeatherViewStatusView(imageName: "sun.max.fill", temperature: 10)
}
