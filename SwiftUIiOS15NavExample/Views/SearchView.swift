//
//  SearchView.swift
//  SwiftUIiOS15NavExample
//
//  Created by Kavindu Dissanayake on 2025-07-16.
//

import SwiftUI

// MARK: - Search View
struct SearchView: View {
    @State private var searchText = ""
    @State private var searchResults: [String] = []
    @State private var selectedResult: String? = nil
    @State private var showResultDetail = false
    
    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Search...", text: $searchText)
                            .onSubmit {
                                performSearch()
                            }
                        
                        if !searchText.isEmpty {
                            Button(action: {
                                searchText = ""
                                searchResults = []
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    
                    Button("Search", action: performSearch)
                        .foregroundColor(.blue)
                }
                .padding(.horizontal)
                
                // Search Results
                if searchResults.isEmpty && !searchText.isEmpty {
                    VStack(spacing: 20) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                        
                        Text("No results found")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 50)
                } else if !searchResults.isEmpty {
                    List(searchResults, id: \.self) { result in
                        Button(action: {
                            selectedResult = result
                            showResultDetail = true
                        }) {
                            HStack {
                                Image(systemName: "doc.text")
                                    .foregroundColor(.blue)
                                
                                VStack(alignment: .leading) {
                                    Text(result)
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                    
                                    Text("Search result description")
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
                } else {
                    VStack(spacing: 20) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                        
                        Text("Search for items")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        Text("Enter a keyword to find what you're looking for")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 50)
                }
                
                Spacer()
            }
            .navigationTitle("Search")
            .navigate(to: SearchResultView(result: selectedResult ?? ""), when: $showResultDetail)
        }
    }
    
    private func performSearch() {
        // Simulate search results
        if !searchText.isEmpty {
            searchResults = (1...10).map { "Result \($0) for '\(searchText)'" }
        } else {
            searchResults = []
        }
    }
}

#Preview {
    SearchView()
}
