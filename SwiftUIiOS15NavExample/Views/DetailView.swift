//
//  DetailView.swift
//  SwiftUIiOS15NavExample
//
//  Created by Kavindu Dissanayake on 2025-07-16.
//
import SwiftUI

struct DetailView: View {
    let itemId: Int
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "photo")
                .font(.system(size: 100))
                .foregroundColor(.blue)
            
            Text("Item \(itemId)")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("This is a detailed view for item \(itemId). You can add more content here.")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
            
            Button("Add to Favorites") {
                // Add to favorites logic
            }
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .background(Color.red)
            .cornerRadius(10)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Item \(itemId)")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        DetailView(itemId: 1)
    }
}

