//
//  OnboardingModels.swift
//  OnboardingDemo
//
//  Created by Jeanette Müller on 28.02.24.
//

import SwiftUI

// MARK: Dummy Onboarding Model Nr. 1

class OnboardingModel_1: OnboardingModelProtocol {
    let id: UUID = UUID()

    var coordinator: OnboardingCoordinator?

    var view: AnyView {
        AnyView(OnboardingView_1(model: self))
    }

    var needToBePresented: Bool {
        true
    }

    func nextButtonTapped() {
        coordinator?.next()
    }

    func forceExitButtonTapped() {
        coordinator?.forceExit()
    }
}

struct OnboardingView_1: View {
    let model: OnboardingModel_1

    var body: some View {
        VStack {
            Text("This the Onboarding View Nr. 1\n\n\n")
            Text("Here you have your text or other stuff to be shown when the application started the first time or when something new should be mentioned")
            
            Button(action: {
                self.model.nextButtonTapped()
            }, label: {
                Text("Go to Next")
            })
            Text("\n\n")
            Button(action: {
                self.model.forceExitButtonTapped()
            }, label: {
                Text("Forced Exit")
            })
            
            Text("\n\n\nSpace\n")
            Text("\n\n\nSpace\n")
            Text("\n\n\nSpace\n")
            Text("\n\n\nSpace\n")
            Text("\n\n\nSpace\n")
            Text("\n\n\nSpace\n")
            Text("\n\n\nSpace\n")
            Text("\n\n\nSpace\n")
            Text("\n\n\nSpace\n")
        }
        .padding(.horizontal)
        .background(Color.yellow)
    }
}

// MARK: Dummy Onboarding Model Nr. 2

struct OnboardingModel_2: OnboardingModelProtocol {
    let id: UUID = UUID()

    var coordinator: OnboardingCoordinator?
    var view: AnyView {
        return AnyView(OnboardingView_2())
    }
    var needToBePresented: Bool {
        return true
    }
}

struct OnboardingView_2: View {
    var body: some View {
        VStack {
            Text("This the Onboarding View Nr. 2")
        }
        .padding()
        .background(Color.purple)
    }
}

// MARK: Dummy Onboarding Model Nr. 3

struct OnboardingModel_3: OnboardingModelProtocol {
    let id: UUID = UUID()

    var coordinator: OnboardingCoordinator?
    var view: AnyView {
        return AnyView(OnboardingView_3())
    }
    var needToBePresented: Bool {
        return false
    }
}

struct OnboardingView_3: View {
    var body: some View {
        VStack {
            Text("This the Onboarding View Nr. 3")
        }
        .padding()
        .background(Color.brown)
    }
}

// MARK: Dummy Onboarding Model Nr. 4

struct OnboardingModel_4: OnboardingModelProtocol {
    let id: UUID = UUID()
    
    var coordinator: OnboardingCoordinator?
    var view: AnyView {
        return AnyView(OnboardingView_4())
    }
    var needToBePresented: Bool {
        return true
    }
}

struct OnboardingView_4: View {
    var body: some View {
        VStack {
            Text("This the Onboarding View Nr. 4")
        }
        .padding()
        .background(Color.cyan)
    }
}
