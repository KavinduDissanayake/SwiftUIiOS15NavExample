//
//  PrivacyView.swift
//  SwiftUIiOS15NavExample
//
//  Created by Kavindu Dissanayake on 2025-07-16.
//
import SwiftUI


struct PrivacyView: View {
    var body: some View {
        Form {
            Section(header: Text("Privacy Settings")) {
                NavigationLink("Data & Privacy", destination: SimpleTextView(title: "Data & Privacy", content: "Manage your data and privacy settings here."))
                NavigationLink("Location Services", destination: SimpleTextView(title: "Location Services", content: "Control location access for the app."))
                NavigationLink("Camera & Microphone", destination: SimpleTextView(title: "Camera & Microphone", content: "Manage camera and microphone permissions."))
            }
            
            Section(header: Text("Account")) {
                NavigationLink("Delete Account", destination: SimpleTextView(title: "Delete Account", content: "Warning: This action cannot be undone."))
                    .foregroundColor(.red)
            }
        }
        .navigationTitle("Privacy")
        .navigationBarTitleDisplayMode(.inline)
    }
}
