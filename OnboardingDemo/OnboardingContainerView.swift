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

            HStack (spacing: 0) {
                Button(action: coordinator.previous) {
                    Text(coordinator.previousButtonTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.red)
                }
                .opacity(coordinator.previousButtonIsEnabled ? 1.0 : 0.0)
                
                Text(coordinator.pageInfo)
                
                Button(action: coordinator.next) {
                    Text(coordinator.nextButtonTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.red)
                }
                .opacity(coordinator.nextButtonIsEnabled ? 1.0 : 0.0)
                
            }
            .background(.cyan)
        }
        .background(.blue)
    }
}

#Preview {
    ContentView()
}
