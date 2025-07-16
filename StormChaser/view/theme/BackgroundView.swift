//
//  BackgroundView.swift
//  SwiftUI-Weather
//
//  Created by Tung on 5/11/2024.
//
import SwiftUI
import CoreData

struct BackgroundView: View {
//    var topColor: Color
//    var bottomColor: Color
    var isNight: Bool
    
    var body: some View {
        
        LinearGradient(gradient: Gradient( colors: [isNight ? .black : .blue, isNight ? .gray : Color("lightBlue") ]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
        
//        ContainerRelativeShape()
//            .fill(isNight ? Color.black.gradient : Color.blue.gradient)
//            .ignoresSafeArea()
    }
}
#Preview {
    BackgroundView(isNight: false).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
