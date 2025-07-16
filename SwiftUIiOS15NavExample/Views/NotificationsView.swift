//
//  NotificationsView.swift
//  SwiftUIiOS15NavExample
//
//  Created by Kavindu Dissanayake on 2025-07-16.
//

import SwiftUI

struct NotificationsView: View {
    @State private var pushNotifications = true
    @State private var emailNotifications = false
    @State private var soundEnabled = true
    
    var body: some View {
        Form {
            Section(header: Text("Notification Settings")) {
                Toggle("Push Notifications", isOn: $pushNotifications)
                Toggle("Email Notifications", isOn: $emailNotifications)
                Toggle("Sound", isOn: $soundEnabled)
            }
            
            Section(header: Text("Notification Types")) {
                NavigationLink("News Updates", destination: SimpleTextView(title: "News Updates", content: "Configure your news update notification preferences here."))
                NavigationLink("Messages", destination: SimpleTextView(title: "Messages", content: "Configure your message notification preferences here."))
                NavigationLink("Reminders", destination: SimpleTextView(title: "Reminders", content: "Configure your reminder notification preferences here."))
            }
        }
        
    }
}


#Preview {
    NavigationStack {
        NotificationsView()
    }
}


