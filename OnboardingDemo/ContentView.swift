//
//  ContentView.swift
//  OnboardingDemo
//
//  Created by Jeanette Müller on 28.02.24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var onboardingCoordinator = OnboardingCoordinator()
    
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Spacer()
            Button(action: {
                
                setupOnboarding()
                onboardingCoordinator.start()
                
            }, label: {
                Text("Start Onboarding Again")
            })
            Spacer()
        }
        .padding()
        .presentOnboarding(
            as: .fullscreenCover,
            isPresented: onboardingCoordinator.isPresented,
            view: onboardingCoordinator.modal
        )
        .onAppear {
            setupOnboarding()
            onboardingCoordinator.start()
        }
    }
}

enum PresentationStyle {
    case fullscreenCover, sheet
}

struct OnboardingPresentation<Inner: View>: ViewModifier {
    let presentationStyle: PresentationStyle
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
        as style: PresentationStyle,
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

extension ContentView {
    func setupOnboarding() {
        onboardingCoordinator.setup([
            OnboardingModel_1(),
            OnboardingModel_2(),
            OnboardingModel_3(),
            OnboardingModel_4()
        ])
    }
}

#Preview {
    ContentView()
}
