//
//  SignInScreen.swift
//  SwiftUIiOS15NavExample
//
//  Created by Kavindu Dissanayake on 2025-07-16.
//

import SwiftUI


// MARK: - Sign In Screen
struct SignInScreen: View {
    @EnvironmentObject var router: ViewRouter
    @State private var email = ""
    @State private var password = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            // Logo
            Image(systemName: "person.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(.blue)
            
            Text("Sign In")
                .font(.largeTitle)
                .fontWeight(.bold)
            
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
            
            // Sign In Button
            Button(action: signIn) {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .disabled(email.isEmpty || password.isEmpty)
            
            // Demo Credentials
            VStack(spacing: 5) {
                Text("Demo Credentials:")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text("Email: demo@example.com")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text("Password: demo123")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.top, 10)
            
            // Sign Up Link
            HStack {
                Text("Don't have an account?")
                    .foregroundColor(.secondary)
                
                Button("Sign Up") {
                    router.currentRoot = .signUp
                }
                .foregroundColor(.blue)
            }
            .padding(.top, 20)
            
            Spacer()
        }
        .padding()
        .navigationBarHidden(true)
        .alert("Sign In", isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(alertMessage)
        }
    }
    
    private func signIn() {
        // Demo authentication logic
        if email == "demo@example.com" && password == "demo123" {
            router.IsAuthenticated = true
        } else {
            alertMessage = "Invalid credentials. Please use demo@example.com and demo123"
            showingAlert = true
        }
    }

}

#Preview {
    SignInScreen()
        .applyViewRoutes()
}
