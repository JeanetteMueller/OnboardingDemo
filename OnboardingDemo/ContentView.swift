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
