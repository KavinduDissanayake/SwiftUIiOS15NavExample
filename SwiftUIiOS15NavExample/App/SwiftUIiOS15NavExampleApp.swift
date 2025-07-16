//
//  ContentView.swift
//  DemoApp
//
//  Created by Developer on 2024-09-08.
//

import SwiftUI

// MARK: - App Entry Point
@main
struct DemoApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
                .applyViewRoutes()
        }
    }
}


// MARK: - Preview
#Preview {
    RootView()
        .applyViewRoutes()
}
