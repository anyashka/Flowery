//
//  FlowCoordinatorDelegate.swift
//  Flowery
//

import Foundation

/// An abstraction describing Flow Coordinator Delegate.
/// Informs a delegate when a given flow is finished.
protocol FlowCoordinatorDelegate: AnyObject {

    /// Executed when flow is finished.
    ///
    /// - Parameter flowCoordinator: root flow coordinator.
    func flowCoordinatorDidFinish(_ flowCoordinator: FlowCoordinator)
}
