//
//  RootView.swift
//  SwiftUIiOS15NavExample
//
//  Created by Kavindu Dissanayake on 2025-07-16.
//
import SwiftUI

// MARK: - Root View
struct RootView: View {
    @EnvironmentObject var router: ViewRouter
    @State private var isAnimated = false

    var body: some View {
        NavigationView {
            containedView(root: router.currentRoot)
                .id(router.currentRoot)
                .transition(.slide)
                .animation(.linear(duration: 0.2), value: isAnimated)
                .onAppear {
                    isAnimated = true
                }
        }
        .navigationViewStyle(.stack)
    }

    @ViewBuilder
    func containedView(root: Roots) -> some View {
        switch root {
        case .initial:
            InitialScreen()
        case .signIn:
            SignInScreen()
        case .signUp:
            SignUpScreen()
        case .bottomTab:
            BottomTabView()
        }
    }
}

#Preview {
    RootView()
        .applyViewRoutes()
}
