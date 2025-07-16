//
//  InitialScreen.swift
//  SwiftUIiOS15NavExample
//
//  Created by Kavindu Dissanayake on 2025-07-16.
//

import SwiftUI

// MARK: - Initial Screen
struct InitialScreen: View {
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.blue, .purple]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Image(systemName: "app.badge")
                    .font(.system(size: 80))
                    .foregroundColor(.white)
                
                Text("Demo App")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text("Welcome to our amazing app!")
                    .font(.title2)
                    .foregroundColor(.white.opacity(0.8))
                
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.5)
                    .padding(.top, 40)
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    InitialScreen()
}
