//
//  MainFlowCoordinator.swift
//  Flowery
//

import UIKit

// MARK: MainFlowCoordinator

/// A Flow Coordinator responsible for handling list of items.
final class MainFlowCoordinator: FlowCoordinator {

    // MARK: Properties

    /// A flow coordinator name.
    let name = "Main"

    /// A main navigation controller.
    /// SeeAlso: FlowCoordinator.navigationController.
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

    /// Starts the flow.
    /// SeeAlso: FlowCoordinator.start()
    func start(animated: Bool) {
        log(message: "MainFlowCoordinator:start - flow started")
        navigationController.navigationBar.setAppStyle()
        showProductsListViewController()
    }
}

// MARK: FlowCoordinatorDelegate

extension MainFlowCoordinator: FlowCoordinatorDelegate {

    func flowCoordinatorDidFinish(_ flowCoordinator: FlowCoordinator) {
        log(message: "MainFlowCoordinator:flowCoordinatorDidFinish - Coordinator name: \(flowCoordinator.name)")
    }
}

// MARK: ProductsListsViewControllerDelegate

extension MainFlowCoordinator: ProductsListsViewControllerDelegate {
    func productsListViewControllerDidSelectProduct(_ ProductsListViewController: ProductsListViewController, product: Product) {
        log(message: "MainFlowCoordinator:productsListViewControllerDidSelectProduct - selected a product with id: \(product.id)")
        showDetailsProductView(with: product)
    }
}

// MARK: Implementation Details

private extension MainFlowCoordinator {

    func showProductsListViewController(animated: Bool = true) {
        let viewModel = DefaultProductsListViewModel(
            productsNetworkController: dependencyProvider.productsNetworkController
        )
        let viewController = ProductsListViewController(
            viewModel: viewModel,
            imageDownloader: dependencyProvider.imageDownloader
        )
        viewController.delegate = self
        navigationController.setViewControllers([viewController], animated: animated)
    }
    
    func showDetailsProductView(with product: Product, animated: Bool = true) {
        let viewModel = DefaultProductDetailsViewModel()
        let viewController = ProductDetailsViewController(
            viewModel: viewModel, product: product,
            imageDownloader: dependencyProvider.imageDownloader
        )
        navigationController.pushViewController(viewController, animated: animated)
    }
}
