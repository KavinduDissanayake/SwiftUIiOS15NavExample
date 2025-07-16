//
//  SignUpScreen.swift
//  SwiftUIiOS15NavExample
//
//  Created by Kavindu Dissanayake on 2025-07-16.
//
import SwiftUI

// MARK: - Sign Up Screen
struct SignUpScreen: View {
    @EnvironmentObject var router: ViewRouter
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            // Logo
            Image(systemName: "person.badge.plus")
                .font(.system(size: 80))
                .foregroundColor(.green)
            
            Text("Sign Up")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            // First Name Field
            VStack(alignment: .leading, spacing: 8) {
                Text("First Name")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                TextField("Enter your first name", text: $firstName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            // Last Name Field
            VStack(alignment: .leading, spacing: 8) {
                Text("Last Name")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                TextField("Enter your last name", text: $lastName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            // Email Field
            VStack(alignment: .leading, spacing: 8) {
                Text("Email")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                TextField("Enter your email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
            }
            
            // Password Field
            VStack(alignment: .leading, spacing: 8) {
                Text("Password")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                SecureField("Enter your password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            // Confirm Password Field
            VStack(alignment: .leading, spacing: 8) {
                Text("Confirm Password")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                SecureField("Confirm your password", text: $confirmPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            // Sign Up Button
            Button(action: signUp) {
                Text("Sign Up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .disabled(!isFormValid)
            
            // Sign In Link
            HStack {
                Text("Already have an account?")
                    .foregroundColor(.secondary)
                
                Button("Sign In") {
                    router.currentRoot = .signIn
                }
                .foregroundColor(.blue)
            }
            .padding(.top, 20)
            
            Spacer()
        }
        .padding()
        .navigationBarHidden(true)
        .alert("Sign Up", isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(alertMessage)
        }
    }
    
    private var isFormValid: Bool {
        !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty &&
        !password.isEmpty && !confirmPassword.isEmpty && password == confirmPassword
    }
    
    private func signUp() {
        // Demo sign up logic
        if password != confirmPassword {
            alertMessage = "Passwords do not match"
            showingAlert = true
            return
        }
        
        // Simulate successful sign up
        alertMessage = "Account created successfully! Please sign in."
        showingAlert = true
        
        // Navigate to sign in after a delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            router.currentRoot = .signIn
        }
    }
}


#Preview {
    SignUpScreen()
        .applyViewRoutes()
}
