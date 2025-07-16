//
//  AboutView.swift
//  SwiftUIiOS15NavExample
//
//  Created by Kavindu Dissanayake on 2025-07-16.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "app.badge")
                .font(.system(size: 80))
                .foregroundColor(.blue)
            
            Text("Demo App")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Version 1.0.0")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text("A comprehensive demo app showcasing SwiftUI navigation patterns, including root-level routing, tab navigation, and traditional NavigationView navigation.")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
            
            VStack(spacing: 10) {
                Text("Features:")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("• Authentication flow with sign in/sign up")
                    Text("• Tab-based navigation")
                    Text("• Detail view navigation")
                    Text("• Search functionality")
                    Text("• Favorites management")
                    Text("• Profile settings")
                }
                .font(.body)
                .foregroundColor(.secondary)
            }
            .padding()
            
            Spacer()
            
            VStack(spacing: 10) {
                Text("© 2024 Demo App")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text("Made with SwiftUI")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .navigationTitle("About")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        AboutView()
    }
}
