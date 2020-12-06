//
//  FlowCoordinator.swift
//  Flowery
//

import UIKit

/// An abstraction describing Flow Coordinator.
/// A Flow Coordinator executed on application root.
protocol FlowCoordinator: AnyObject {

    /// A flow coordinator delegate.
    var flowCoordinatorDelegate: FlowCoordinatorDelegate? { get set }

    /// A View Controller being the root of a flow, usually a UINavigationController.
    var rootViewController: UIViewController { get }

    /// Flow distinct name.
    var name: String { get }

    /// Currently presented flow coordinator.
    var currentFlowCoordinator: FlowCoordinator? { get }

    /// Starts the flow.
    ///
    /// - Parameter animated: perform animation when showing flow initial screen.
    func start(animated: Bool)
}

