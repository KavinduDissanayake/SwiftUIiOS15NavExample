//
//  CategoryView.swift
//  SwiftUIiOS15NavExample
//
//  Created by Kavindu Dissanayake on 2025-07-16.
//
import SwiftUI

struct CategoryView: View {
    let category: String
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "square.grid.2x2")
                .font(.system(size: 60))
                .foregroundColor(.blue)
            
            Text(category)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Explore items in the \(category) category.")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
            
            List(1...20, id: \.self) { index in
                NavigationLink(destination: DetailView(itemId: index)) {
                    Text("\(category) Item \(index)")
                }
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle(category)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    CategoryView(category: "Technology")
}
