//
//  ModalView.swift
//  OnboardingDemo
//
//  Created by Jeanette Müller on 28.02.24.
//

import SwiftUI

protocol ModalViewCoordinatorProtocol: ObservableObject {
    func getFirstView() -> AnyView?
    func next()
    
    var nextButtonTitle: String { get }
}

struct ModalView: View {
    var coordinator: any ModalViewCoordinatorProtocol
    
    @State var path = NavigationPath()
    
    var body: some View {
        GeometryReader{ geometry in
            VStack(spacing: 0) {
                ScrollView {
                    coordinator.getFirstView()
                        .frame(width: geometry.size.width)
                }
                .frame(width: geometry.size.width)
                .background(Color.orange)
                
                HStack {
                    Button {
                        coordinator.next()
                    } label: {
                        Text(coordinator.nextButtonTitle)
                            .fontWeight(.bold)
                    }
                }
                .frame(width: geometry.size.width, height: 40)
                .background(Color.red)
            }
            .frame(width: geometry.size.width)
            .background(Color.blue)
        }
    }
}
