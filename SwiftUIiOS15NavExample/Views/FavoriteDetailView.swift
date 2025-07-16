//
//  FavoriteDetailView.swift
//  SwiftUIiOS15NavExample
//
//  Created by Kavindu Dissanayake on 2025-07-16.
//
import SwiftUI

struct FavoriteDetailView: View {
    let item: String
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "heart.fill")
                .font(.system(size: 60))
                .foregroundColor(.red)
            
            Text(item)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text("This is one of your favorite items. You can view details and manage your favorites here.")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
            
            Button("Remove from Favorites") {
                // Remove from favorites logic
            }
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .background(Color.red)
            .cornerRadius(10)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Favorite Item")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        FavoriteDetailView(item: "Sample Favorite")
    }
}
