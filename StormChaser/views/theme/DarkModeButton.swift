//
//  DarkModeButton.swift
//  SwiftUI-Weather
//
//  Created by Tung on 5/11/2024.
//

import SwiftUI

struct DarkModeButton: View {
    var title : String
    var textColor : Color
    var backgroundColor : Color
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: "moon.stars").font(.system(size: 30)).foregroundColor(.white)
            VStack(alignment: .leading)  {
//                Text("\(title)")
//                    .font(.system(size: 20, weight: .medium, design: .default))
//                    .foregroundColor(.white)
//                    .lineLimit(1)
//                    .minimumScaleFactor(0.5)
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
    DarkModeButton(title: "dark mode", textColor: .white, backgroundColor: .gray)
}
