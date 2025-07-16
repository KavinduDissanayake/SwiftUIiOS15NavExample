//
//  FavoritesView.swift
//  SwiftUIiOS15NavExample
//
//  Created by Kavindu Dissanayake on 2025-07-16.
//

import SwiftUI

// MARK: - Favorites View
struct FavoritesView: View {
    @State private var favorites = [
        "Favorite Item 1",
        "Favorite Item 2",
        "Favorite Item 3",
        "Favorite Item 4",
        "Favorite Item 5"
    ]
    @State private var selectedFavorite: String? = nil
    @State private var showFavoriteDetail = false
    
    var body: some View {
        NavigationView {
            VStack {
                if favorites.isEmpty {
                    VStack(spacing: 20) {
                        Image(systemName: "heart.slash")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                        
                        Text("No favorites yet")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        Text("Items you favorite will appear here")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 50)
                } else {
                    List {
                        ForEach(favorites, id: \.self) { favorite in
                            Button(action: {
                                selectedFavorite = favorite
                                showFavoriteDetail = true
                            }) {
                                HStack {
                                    Image(systemName: "heart.fill")
                                        .foregroundColor(.red)
                                    
                                    VStack(alignment: .leading) {
                                        Text(favorite)
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                        
                                        Text("Added to favorites")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                .padding(.vertical, 4)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        .onDelete(perform: deleteFavorite)
                    }
                }
                
                Spacer()
            }
            .navigationTitle("Favorites")
            .toolbar {
                EditButton()
            }
            .navigate(to: FavoriteDetailView(item: selectedFavorite ?? ""), when: $showFavoriteDetail)
        }
    }
    
    private func deleteFavorite(at offsets: IndexSet) {
        favorites.remove(atOffsets: offsets)
    }
}

// MARK: - Preview
#Preview {
    FavoritesView()
}
