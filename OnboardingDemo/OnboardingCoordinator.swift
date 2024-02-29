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
}

// MARK: - OnboardingCoordinator

final class OnboardingCoordinator: ObservableObject {
    @Published var viewModels = [any OnboardingModelProtocol]()
    @Published var modal: OnboardingContainerView?
    @Published var isPresented = false
    @Published var currentModelIndex = 0
}

extension OnboardingCoordinator {
    
    @ViewBuilder
    func onboardingStepView() -> some View {
        modelToPresent.view
    }
    
    func setup(_ newViewModels: [any OnboardingModelProtocol]) {
        viewModels = newViewModels
    }
    
    func start() {
        currentModelIndex = 0
        modal = OnboardingContainerView(coordinator: self)
        
        isPresented = itemsToShow > 0
    }
    
    func previous() {
        if currentModelIndex > 0 {
            currentModelIndex = currentModelIndex - 1
        }
    }
    func next() {
        if currentModelIndex < itemsToShow - 1 {
            currentModelIndex += 1
        }else{
            forceExit()
        }
    }
    
    func forceExit() {
        isPresented = false
        
        //self.viewModels.removeAll()
    }
}

extension OnboardingCoordinator {
    
    var nextButtonTitle: String {
        if itemsToShow - 1 > currentModelIndex {
            "Next Page"
        } else {
            "Exit"
        }
    }
    
    var nextButtonIsEnabled: Bool {
        true
    }
    
    var previousButtonTitle: String {
        "Back"
    }
    
    var previousButtonIsEnabled: Bool {
        currentModelIndex > 0
    }
    
    var pageInfo: String {
        "\(currentModelIndex + 1)/\(itemsToShow)"
    }
}

private extension OnboardingCoordinator {
    
    var itemsToShow: Int {
        itemsToBePresented
            .count
    }
    
    var itemsToBePresented: [any OnboardingModelProtocol] {
        viewModels
            .filter { $0.needToBePresented }
    }
    
    var modelToPresent: any OnboardingModelProtocol {
        var model = itemsToBePresented[currentModelIndex]
        model.coordinator = self
        return model
    }
}
