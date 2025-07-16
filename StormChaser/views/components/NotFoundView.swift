//
//  NotFoundView.swift
//  StormChaser
//
//  Created by Tung on 16/7/2025.
//

import SwiftUI

struct NotFoundView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 50))
                .foregroundColor(.red)
            Text("Weather Data Not Found")
                .font(.title2)
                .foregroundColor(.gray)
        }
        .padding()
    }
}
#Preview {
    NotFoundView()
}
