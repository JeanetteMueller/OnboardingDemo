//
//  OnboardingCoordinator.swift
//  OnboardingDemo
//
//  Created by Jeanette Müller on 28.02.24.
//

import SwiftUI

protocol OnboardingModelProtocol {
    var coordinator: OnboardingCoordinator? { get set }
    var view: AnyView { get }
    var needToBePresented: Bool { get }
    var done: Bool { get set }
}

@Observable
final class OnboardingCoordinator: ObservableObject {
    var viewModels = [any OnboardingModelProtocol]()
    var modal: ModalView {
        ModalView(coordinator: self)
    }
    var presenting: Binding<Bool> {
        Binding<Bool> {
            return self.shouldBePresented
        } set: { newValue in
            print("binding set to \(newValue)")
        }
    }
    var nextButtonTitle: String = "#"
    
    private var shouldBePresented: Bool = false
    
    func setup(_ viewModels: [any OnboardingModelProtocol]) {
        self.viewModels = viewModels
    }
    
    func start() {
        updateNextButtonTitle()
        shouldBePresented = itemsToShow > 0
    }
}

private extension OnboardingCoordinator {
    private var itemsToShow: Int {
        self.viewModels
            .filter { $0.needToBePresented && !$0.done }
            .count
    }
    private var itemsToBePresented: Int {
        self.viewModels
            .filter { $0.needToBePresented }
            .count
    }
    
    func updateNextButtonTitle() {
        if itemsToShow > 1 {
            self.nextButtonTitle = "Next Page \(itemsToBePresented - (itemsToShow - 1))/\(itemsToBePresented)"
        }else {
            self.nextButtonTitle = "Exit"
        }
    }
}

extension OnboardingCoordinator: ModalViewCoordinatorProtocol {
    
    func getFirstModel() -> (any OnboardingModelProtocol)? {
        if var firstModel = self.viewModels.first(where: { $0.needToBePresented && !$0.done }) {
            firstModel.coordinator = self
            return firstModel
        }
        return nil
    }
    
    func getFirstView() -> AnyView? {
        if let firstModel = getFirstModel() {
            return firstModel.view
        }
        return nil
    }
    
    func next() {
        print("next")
        
        var done = false
        var newModels = [any OnboardingModelProtocol]()
        for var type in self.viewModels {
            if !done && type.needToBePresented && !type.done {
                type.done = true
                newModels.append(type)
                done = true
            }else{
                newModels.append(type)
            }
        }
        
        self.viewModels = newModels
        
        updateNextButtonTitle()
        
        if let firstModel = getFirstModel() {
            print("preset next view \(firstModel)")
        }else{
            shouldBePresented = false
            
            self.viewModels.removeAll()
        }
    }
    
    func forceExit() {
        shouldBePresented = false
        
        self.viewModels.removeAll()
    }
}
