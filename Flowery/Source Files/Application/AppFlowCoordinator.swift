//
//  AppFlowCoordinator.swift
//  Flowery
//

import UIKit

// MARK: AppFlowCoordinator

/// A Main Flow Coordinator for the app.
final class AppFlowCoordinator: FlowCoordinator {

    // MARK: Properties

    /// A flow coordinator name.
    let name = "App"

    /// - SeeAlso: `FlowCoordinator.navigationController`
    let navigationController: UINavigationController

    /// - SeeAlso: `FlowCoordinator.delegate`
    weak var flowCoordinatorDelegate: FlowCoordinatorDelegate?

    /// - SeeAlso: `FlowCoordinator.currentFlowCoordinator`
    private(set) var currentFlowCoordinator: FlowCoordinator?

    /// - SeeAlso: `FlowCoordinator.dependencyProvider`
    private(set) unowned var dependencyProvider: DependencyProvider

    /// - SeeAlso: `FlowCoordinator.rootViewController`
    var rootViewController: UIViewController {
        navigationController
    }

    // MARK: Initializers

    ///
    /// - Parameters:
    ///   - dependencyProvider: a reference to the application Dependency Provider.
    ///   - navigationController: a Navigation Controller to lay the flow on.
    init(
        dependencyProvider: DependencyProvider,
        navigationController: UINavigationController = UINavigationController()
    ) {
        self.navigationController = navigationController
        self.dependencyProvider = dependencyProvider
    }

    // MARK: methods

    /// - SeeAlso: `FlowCoordinator.start`
    func start(animated: Bool) {
        log(message: "AppFlowCoordinator:start - flow started")
        let coordinator = MainFlowCoordinator(dependencyProvider: dependencyProvider, navigationController: navigationController)
        currentFlowCoordinator = coordinator
        coordinator.start(animated: animated)
    }
}

// MARK: FlowCoordinatorDelegate

extension AppFlowCoordinator: FlowCoordinatorDelegate {

    func flowCoordinatorDidFinish(_ flowCoordinator: FlowCoordinator) {
        log(message: "AppFlowCoordinator:flowCoordinatorDidFinish - Coordinator name: \(flowCoordinator.name)")
    }
}
