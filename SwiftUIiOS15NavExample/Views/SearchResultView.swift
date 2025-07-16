//
//  SearchResultView.swift
//  SwiftUIiOS15NavExample
//
//  Created by Kavindu Dissanayake on 2025-07-16.
//


import SwiftUI

struct SearchResultView: View {
    let result: String
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "doc.text")
                .font(.system(size: 60))
                .foregroundColor(.blue)
            
            Text(result)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text("This is the detailed view for this search result. You can display relevant information here.")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
        }
        .padding()
        .navigationTitle("Search Result")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// SwiftUI preview for SearchResultView
#Preview {
    NavigationStack {
        SearchResultView(result: "Sample Result")
    }
}
