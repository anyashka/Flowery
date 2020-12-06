//
//  ProductsListViewController.swift
//  Flowery
//

import UIKit

/// A delegate for products list view controller.
protocol ProductsListsViewControllerDelegate: AnyObject {

    /// Identifies that user has selected a product from the list.
    ///
    /// - Parameters:
    ///     - ProductsListViewController: view controller that triggered this method.
    ///     - product: a chosen product by the user.
    func productsListViewControllerDidSelectProduct(_ ProductsListViewController: ProductsListViewController, product: Product)
}

/// A products list view controller.
final class ProductsListViewController: UIViewController {

    // MARK: Properties

    /// Delegate of view controller.
    weak var delegate: ProductsListsViewControllerDelegate?

    /// A custom view for the view controller.
    let customView: ProductsListsView

    // MARK: Private Properties

    private let viewModel: ProductsListViewModel
    private let imageDownloader: ImageDownloader
    private let infoAlert: InfoAlert
    private var products: [Product] = []

    // MARK: Initializers

    /// Initializes the view controller.
    ///
    /// - Parameters:
    ///     - viewModel: a view model for products list.
    ///     - imageDownloader: image downloader used for fetching images.
    ///     - infoAlert: an alert object to show to a user.
    init(
        viewModel: ProductsListViewModel,
        imageDownloader: ImageDownloader,
        infoAlert: InfoAlert = DefaultInfoAlert()
    ) {
        customView = ProductsListsView()
        self.viewModel = viewModel
        self.imageDownloader = imageDownloader
        self.infoAlert = infoAlert
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable, message: "Use init() instead")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life Cycle

    /// - SeeAlso: UIViewController.loadView()
    override func loadView() {
        super.loadView()
        view = customView
        view.clipsToBounds = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: UITableViewDataSource & UITableViewDelegate

extension ProductsListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.reuseIdentifier, for: indexPath) as! ProductTableViewCell
        let product = products[indexPath.row]
        let imageURL = viewModel.imageURL(for: product)
        cell.update(
            with: imageURL,
            imageDownloader: imageDownloader,
            name: String(product.attributes.name),
            price: NumberFormatter.getAmountPriceText(for: product)
        )
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.productsListViewControllerDidSelectProduct(self, product: products[indexPath.row])
    }
}

// MARK: Implementation Details

private extension ProductsListViewController {

    func setup() {
        title = Localizable.ProductList.nagivationBarTitle
        setupTableView()
        setupViewCallbacks()
        setupViewModelCallbacks()
        customView.progressIndicator.startAnimating()
        viewModel.fetchProducts()
    }

    func setupTableView() {
        customView.tableView.dataSource = self
        customView.tableView.delegate = self
    }

    func setupViewCallbacks() {
        customView.onRefresh = { [unowned self] in
            self.viewModel.fetchProducts()
        }
    }

    func setupViewModelCallbacks() {
        viewModel.onProductsFetch = { [unowned self] products in
            self.products = products
            self.handleProductsResponse()
        }

        viewModel.onNetworkError = { [unowned self] error in
            self.handleProductsResponse()
            switch error {
            case let .describedError(description):
                self.infoAlert.show(on: self, title: description, message: nil, acceptanceCompletion: nil)
            default:
                self.infoAlert.show(on: self, title: Localizable.General.Error.somethingWrongTitle, message: Localizable.General.Error.somethingWrongMessage, acceptanceCompletion: nil)
            }
        }
    }

    func handleProductsResponse() {
        customView.refreshControl.endRefreshing()
        customView.progressIndicator.stopAnimating()
        customView.updateTableViewEmptyState(isEmpty: self.products.isEmpty)
        customView.tableView.reloadData()
    }
}
