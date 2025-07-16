//
//  SimpleTextView.swift
//  SwiftUIiOS15NavExample
//
//  Created by Kavindu Dissanayake on 2025-07-16.
//
import SwiftUI

struct SimpleTextView: View {
    let title: String
    let content: String
    
    var body: some View {
        VStack(spacing: 20) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text(content)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
        }
        .padding()
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        SimpleTextView(title: "Welcome", content: "This is a simple text view used to display basic content in the app.")
    }
}
