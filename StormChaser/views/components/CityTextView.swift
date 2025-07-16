//
//  CityTextView.swift
//  SwiftUI-Weather
//
//  Created by Tung on 5/11/2024.
//

import SwiftUI
import CoreData

struct CityTextView: View {
    var cityName: String
    var timezone: String
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Image(systemName: "mappin.and.ellipse").font(.system(size: 40)).foregroundColor(.white)
                Text("\(cityName), \(timezone)")
                    .font(.system(size: 24, weight: .medium, design: .default))
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                    .fill(Color.black.opacity(0.1))
        ).padding()
    }
}

#Preview {
    CityTextView(cityName: "CA",timezone: "toronto")
}
