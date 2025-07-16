//
//  HelpView.swift
//  SwiftUIiOS15NavExample
//
//  Created by Kavindu Dissanayake on 2025-07-16.
//
import SwiftUI

struct HelpView: View {
    var body: some View {
        List {
            Section(header: Text("Support")) {
                NavigationLink("FAQ", destination: SimpleTextView(title: "FAQ", content: "Frequently asked questions and answers."))
                NavigationLink("Contact Us", destination: SimpleTextView(title: "Contact Us", content: "Get in touch with our support team."))
                NavigationLink("Report a Bug", destination: SimpleTextView(title: "Report a Bug", content: "Report issues you've encountered."))
            }
            
            Section(header: Text("Resources")) {
                NavigationLink("User Guide", destination: SimpleTextView(title: "User Guide", content: "Complete guide on how to use the app."))
                NavigationLink("Video Tutorials", destination: SimpleTextView(title: "Video Tutorials", content: "Watch video tutorials to learn more."))
                NavigationLink("Community Forum", destination: SimpleTextView(title: "Community Forum", content: "Join our community discussions."))
            }
        }
        .navigationTitle("Help & Support")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        HelpView()
    }
}
