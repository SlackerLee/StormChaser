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
        HStack(alignment: .center) {
            Image(systemName: "mappin.and.ellipse").font(.system(size: 40)).foregroundColor(.white)
            VStack(alignment: .leading)  {
                Text("\(cityName)")
                    .font(.system(size: 24, weight: .medium, design: .default))
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                Text("Time Zone: \(timezone)")
                    .font(.system(size: 24, weight: .medium, design: .default))
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            }
        }.padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                    .fill(Color.black.opacity(0.1))
        )
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
    }
}

#Preview {
    CityTextView(cityName: "CA",timezone: "toronto")
}
