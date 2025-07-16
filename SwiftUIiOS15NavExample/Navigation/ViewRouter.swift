//
//  ViewRouter.swift
//  SwiftUIiOS15NavExample
//
//  Created by Kavindu Dissanayake on 2025-07-16.
//

import SwiftUI


// MARK: - View Router
class ViewRouter: ObservableObject {
    @Published var currentRoot: Roots = .initial
    @AppStorage("IsAuthenticated") var IsAuthenticated = false {
        didSet {
            checkUserLoginOrNot()
        }
    }
    
    static let shared = ViewRouter()
    
    fileprivate init() {
        // Show initial screen first, then check authentication
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.checkUserLoginOrNot()
        }
    }
    
    func checkUserLoginOrNot() {
        if IsAuthenticated {
            currentRoot = .bottomTab
        } else {
            currentRoot = .signIn
        }
    }
    
    func signOut() {
        IsAuthenticated = false
        currentRoot = .signIn
    }
}

// MARK: - Route Modifier
struct RouteModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .environmentObject(ViewRouter.shared)
    }
}
