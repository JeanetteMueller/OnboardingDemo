//
//  OnboardingContainerView.swift
//  OnboardingDemo
//
//  Created by Jeanette Müller on 28.02.24.
//

import SwiftUI

struct OnboardingContainerView: View {
    @StateObject var coordinator: OnboardingCoordinator

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                coordinator
                    .onboardingStepView()
                    .frame(maxWidth: .infinity)
            }
            .background(.orange)

            Button(action: coordinator.next) {
                Text(coordinator.nextButtonTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.red)
            }
        }
        .background(.blue)
    }
}

#Preview {
    ContentView()
}
