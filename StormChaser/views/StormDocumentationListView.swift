//
//  StormDocumentationListView.swift
//  StormChaser
//
//  Created by Tung on 16/7/2025.
//

import SwiftUI

struct StormDocumentationListView: View {
    @StateObject private var documentationManager = StormDocumentationManager()
    @State private var searchText = ""
    @State private var selectedStormType: StormType?
    @State private var showingFilter = false
    @EnvironmentObject var appThemeManager: AppThemeManager
    
    var filteredDocumentations: [StormDocumentation] {
        var filtered = documentationManager.stormDocumentations
        
        if !searchText.isEmpty {
            filtered = filtered.filter { documentation in
                documentation.notes.localizedCaseInsensitiveContains(searchText) ||
                documentation.stormType.rawValue.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        if let selectedType = selectedStormType {
            filtered = filtered.filter { $0.stormType == selectedType }
        }
        
        return filtered.sorted { $0.dateTime > $1.dateTime }
    }
    
    var body: some View {
        ZStack {
            BackgroundView(isNight: appThemeManager.isNight)
            VStack {
                // Search and Filter Bar
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search notes or storm type...", text: $searchText)
                            .foregroundColor(.gray)
                    }
                    .padding(8)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    Button(action: {
                        showingFilter.toggle()
                    }) {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .foregroundColor(.gray)
                    }
                }
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                .background(Color.white)
                
                if filteredDocumentations.isEmpty {
                    VStack(spacing: 20) {
                        Image(systemName: "photo.on.rectangle.angled")
                            .font(.system(size: 60))
                            .foregroundColor(.white)
                        Text("No storm documentation found")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text("Start documenting storms by taking photos and adding metadata")
                            .font(.caption)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List(filteredDocumentations) { documentation in
                        NavigationLink(destination: StormDocumentationDetailView(documentation: documentation, documentationManager: documentationManager)) {
                            StormDocumentationRowView(documentation: documentation)
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
        }
        .navigationTitle("Storm Documentation")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: StormDocumentationFormView(documentationManager: documentationManager)) {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingFilter) {
            StormTypeFilterView(selectedType: $selectedStormType)
        }
    }
}

struct StormDocumentationRowView: View {
    let documentation: StormDocumentation
    
    var body: some View {
        HStack(spacing: 12) {
            // Thumbnail
            if let uiImage = UIImage(data: documentation.photoData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            } else {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 60, height: 60)
                    .overlay(
                        Image(systemName: "photo")
                            .foregroundColor(.gray)
                    )
            }
            
            // Content
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Image(systemName: documentation.stormType.icon)
                        .foregroundColor(.blue)
                    Text(documentation.stormType.rawValue)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Spacer()
                    Text(documentation.dateTime, style: .date)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                if !documentation.notes.isEmpty {
                    Text(documentation.notes)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
                
                HStack {
                    Image(systemName: "location")
                        .font(.caption)
                        .foregroundColor(.green)
                    Text("\(documentation.location.latitude, specifier: "%.4f"), \(documentation.location.longitude, specifier: "%.4f")")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    if let temp = documentation.weatherConditions.temperature {
                        HStack(spacing: 2) {
                            Image(systemName: "thermometer")
                                .font(.caption)
                            Text("\(temp, specifier: "%.1f")°C")
                                .font(.caption)
                        }
                        .foregroundColor(.orange)
                    }
                }
            }
        }
        .padding(.vertical, 4)
    }
}

struct StormTypeFilterView: View {
    @Binding var selectedType: StormType?
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            List {
                Button("All Storm Types") {
                    selectedType = nil
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(selectedType == nil ? .blue : .primary)
                
                ForEach(StormType.allCases, id: \.self) { stormType in
                    Button(action: {
                        selectedType = stormType
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Image(systemName: stormType.icon)
                                .foregroundColor(.blue)
                            Text(stormType.rawValue)
                            Spacer()
                            if selectedType == stormType {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                    .foregroundColor(selectedType == stormType ? .blue : .primary)
                }
            }
            .navigationTitle("Filter by Storm Type")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
} 
