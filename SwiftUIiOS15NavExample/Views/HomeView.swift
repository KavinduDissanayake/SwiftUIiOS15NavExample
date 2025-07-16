//
//  HomeView.swift
//  SwiftUIiOS15NavExample
//
//  Created by Kavindu Dissanayake on 2025-07-16.
//

import SwiftUI

// MARK: - Home View
struct HomeView: View {
    @State private var showNotifications = false
    @State private var selectedItemId: Int? = nil
    @State private var showItemDetail = false
    @State private var selectedCategory: String? = nil
    @State private var showCategoryDetail = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Header
                HStack {
                    VStack(alignment: .leading) {
                        Text("Welcome back!")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text("Here's what's new today")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        showNotifications = true
                    }) {
                        Image(systemName: "bell")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                }
                .padding(.horizontal)
                
                // Featured Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("Featured")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(1...5, id: \.self) { index in
                                Button(action: {
                                    selectedItemId = index
                                    showItemDetail = true
                                }) {
                                    FeaturedCard(title: "Item \(index)", imageName: "photo")
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                
                // Categories Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("Categories")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 15) {
                        ForEach(["Sports", "Music", "Travel", "Food"], id: \.self) { category in
                            Button(action: {
                                selectedCategory = category
                                showCategoryDetail = true
                            }) {
                                CategoryCard(title: category)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .navigate(to: NotificationsView(), when: $showNotifications)
            .navigate(to: DetailView(itemId: selectedItemId ?? 0), when: $showItemDetail)
            .navigate(to: CategoryView(category: selectedCategory ?? ""), when: $showCategoryDetail)
        }
    }
}


#Preview {
    HomeView()
}
