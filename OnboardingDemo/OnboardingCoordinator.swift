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

final class OnboardingCoordinator: ObservableObject {
    @Published var viewModels = [any OnboardingModelProtocol]()
    @Published var modal: OnboardingContainerView?
    @Published var isPresented = false
    
    func setup(_ viewModels: [any OnboardingModelProtocol]) {
        self.viewModels = viewModels
    }
    
    func start() {
        self.modal = OnboardingContainerView(coordinator: self)
        
        isPresented = itemsToShow > 0
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
        isPresented = false
        
        self.viewModels.removeAll()
    }
}

extension OnboardingCoordinator {
    var nextButtonTitle: String {
        if itemsToShow > 1 {
            "Next Page \(itemsToBePresented - (itemsToShow - 1))/\(itemsToBePresented)"
        } else {
            "Exit"
        }
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
    
    var modelToPresent: (any OnboardingModelProtocol)? {
        if var model = self.viewModels.first(where: { $0.needToBePresented && !$0.done }) {
            model.coordinator = self
            return model
        }
        return nil
    }
    
    
}
