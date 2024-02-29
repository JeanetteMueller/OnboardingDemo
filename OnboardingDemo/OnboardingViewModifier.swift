//
//  OnboardingViewModifier.swift
//  OnboardingDemo
//
//  Created by Jeanette Müller on 29.02.24.
//

import SwiftUI



struct OnboardingPresentation<Inner: View>: ViewModifier {
    
    let presentationStyle: OnboardingCoordinator.PresentationStyle
    let isPresenting: Bool
    let viewBuilder: () -> Inner
    
    func body(content: Content) -> some View {
        if presentationStyle == .fullscreenCover {
            content
                .fullScreenCover(isPresented: .constant(isPresenting), content: {
                    viewBuilder()
                })
        } else {
            content
                .sheet(isPresented: .constant(isPresenting), content: {
                    viewBuilder()
                })
        }
    }
}

extension View {
    func presentOnboarding<Content: View>(
        as style: OnboardingCoordinator.PresentationStyle,
        isPresented: Bool,
        view: Content
    ) -> some View {
        modifier(
            OnboardingPresentation(
                presentationStyle: style,
                isPresenting: isPresented,
                viewBuilder: {
                    view
                }
            )
        )
    }
}
