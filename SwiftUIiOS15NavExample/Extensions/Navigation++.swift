//
//  Navigation++.swift
//  SwiftUIiOS15NavExample
//
//  Created by Kavindu Dissanayake on 2025-07-16.
//
import SwiftUI


extension View {
    func applyViewRoutes() -> some View {
        modifier(RouteModifier())
    }
    
    /// Navigate to a new view.
    /// - Parameters:
    ///   - view: View to navigate to.
    ///   - binding: Active binding
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        ZStack {
            self
            NavigationLink(
                destination: view,
                isActive: binding
            ) {
                EmptyView()
            }
        }
    }
}
