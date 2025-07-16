//
//  EditProfileView.swift
//  SwiftUIiOS15NavExample
//
//  Created by Kavindu Dissanayake on 2025-07-16.
//
import SwiftUI

struct EditProfileView: View {
    @State private var firstName = "John"
    @State private var lastName = "Doe"
    @State private var email = "demo@example.com"
    @State private var phone = "+1 (555) 123-4567"
    
    var body: some View {
        Form {
            Section(header: Text("Personal Information")) {
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                TextField("Phone", text: $phone)
                    .keyboardType(.phonePad)
            }
            
            Section(header: Text("Profile Picture")) {
                HStack {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.blue)
                    
                    VStack(alignment: .leading) {
                        Text("Profile Picture")
                            .font(.headline)
                        
                        Button("Change Picture") {
                            // Change picture logic
                        }
                        .foregroundColor(.blue)
                    }
                    
                    Spacer()
                }
                .padding(.vertical, 8)
            }
        }
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    // Save profile logic
                }
            }
        }
    }

}

#Preview {
    NavigationStack {
        EditProfileView()
    }
}
