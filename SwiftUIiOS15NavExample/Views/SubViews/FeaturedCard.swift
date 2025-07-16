//
//  FeaturedCard.swift
//  SwiftUIiOS15NavExample
//
//  Created by Kavindu Dissanayake on 2025-07-16.
//

import SwiftUI


// MARK: - Supporting Views

struct FeaturedCard: View {
    let title: String
    let imageName: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(systemName: imageName)
                .font(.system(size: 40))
                .foregroundColor(.blue)
                .frame(width: 150, height: 80)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(8)
            
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
        }
        .frame(width: 150)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
        .padding()
    }
}

#Preview {

        FeaturedCard(title: "Featured Item", imageName: "star.fill")
            .padding()
            .background(Color.gray.opacity(0.1))

}
