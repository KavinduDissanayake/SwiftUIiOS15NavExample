//
//  ProfileView.swift
//  SwiftUIiOS15NavExample
//
//  Created by Kavindu Dissanayake on 2025-07-16.
//


import SwiftUI


// MARK: - Profile View
struct ProfileView: View {
    @EnvironmentObject var router: ViewRouter
    @State private var showEditProfile = false
    @State private var showNotifications = false
    @State private var showPrivacy = false
    @State private var showHelp = false
    @State private var showAbout = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Profile Header
                VStack(spacing: 15) {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.blue)
                    
                    Text("John Doe")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text("demo@example.com")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 20)
                
                // Profile Options
                VStack(spacing: 0) {
                    Button(action: { showEditProfile = true }) {
                        ProfileRow(icon: "person.crop.circle", title: "Edit Profile")
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: { showNotifications = true }) {
                        ProfileRow(icon: "bell", title: "Notifications")
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: { showPrivacy = true }) {
                        ProfileRow(icon: "lock", title: "Privacy")
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: { showHelp = true }) {
                        ProfileRow(icon: "questionmark.circle", title: "Help & Support")
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: { showAbout = true }) {
                        ProfileRow(icon: "info.circle", title: "About")
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .background(Color(.systemBackground))
                .cornerRadius(10)
                .padding(.horizontal)
                
                // Sign Out Button
                Button(action: {
                    router.signOut()
                }) {
                    Text("Sign Out")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .padding(.top, 20)
                
                Spacer()
            }
            .navigationTitle("Profile")
            .background(Color(.systemGray6))
            .navigate(to: EditProfileView(), when: $showEditProfile)
            .navigate(to: NotificationsView(), when: $showNotifications)
            .navigate(to: PrivacyView(), when: $showPrivacy)
            .navigate(to: HelpView(), when: $showHelp)
            .navigate(to: AboutView(), when: $showAbout)
        }
    }
}
