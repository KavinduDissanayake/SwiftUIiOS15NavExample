//
//  CategoryCard.swift
//  SwiftUIiOS15NavExample
//
//  Created by Kavindu Dissanayake on 2025-07-16.
//

import SwiftUI

struct CategoryCard: View {
    let title: String
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "square.grid.2x2")
                .font(.system(size: 30))
                .foregroundColor(.white)
            
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 100)
        .background(LinearGradient(
            gradient: Gradient(colors: [.blue, .purple]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        ))
        .cornerRadius(12)
    }
}

#Preview {
        CategoryCard(title: "Sample Category")
            .padding()
            .background(Color.black)
}
