//
//  OnboardingCoordinator.swift
//  OnboardingDemo
//
//  Created by Jeanette Müller on 28.02.24.
//

import SwiftUI

// MARK: - OnboardingModel

protocol OnboardingModelProtocol: Identifiable {
    var id: UUID { get }

    var coordinator: OnboardingCoordinator? { get set }
    var view: AnyView { get }
    var needToBePresented: Bool { get }
    var done: Bool { get set }
}

// MARK: - OnboardingCoordinator

@Observable
final class OnboardingCoordinator {
    var viewModels = [any OnboardingModelProtocol]()
    var modal: OnboardingContainerView {
        OnboardingContainerView(coordinator: self)
    }

    var presenting: Binding<Bool> {
        Binding<Bool> {
            return self.shouldBePresented
        } set: { newValue in
            print("binding set to \(newValue)")
        }
    }

    var nextButtonTitle: String {
        if itemsToShow > 1 {
            "Next Page \(itemsToBePresented - (itemsToShow - 1))/\(itemsToBePresented)"
        } else {
            "Exit"
        }
    }

    private var shouldBePresented: Bool = false
    
    func setup(_ viewModels: [any OnboardingModelProtocol]) {
        self.viewModels = viewModels
    }
    
    func start() {
        shouldBePresented = itemsToShow > 0
    }
}

private extension OnboardingCoordinator {
    var itemsToShow: Int {
        self.viewModels
            .filter { $0.needToBePresented && !$0.done }
            .count
    }

    var itemsToBePresented: Int {
        self.viewModels
            .filter { $0.needToBePresented }
            .count
    }
}

extension OnboardingCoordinator {
    var modelToPresent: (any OnboardingModelProtocol)? {
        if var model = self.viewModels.first(where: { $0.needToBePresented && !$0.done }) {
            model.coordinator = self
            return model
        }
        return nil
    }
    
    @ViewBuilder
    func onboardingStepView() -> some View {
        modelToPresent?.view
    }
    
    func next() {
        guard let modelToPresent, let index = viewModels.firstIndex(where: { $0.id == modelToPresent.id }) else {
            forceExit()
            return
        }

        viewModels[index].done = true

        if itemsToShow == 0 {
            forceExit()
        }
    }
    
    func forceExit() {
        shouldBePresented = false
    }
}
