//
//  PopularProductsView.swift
//  Flowery
//

import UIKit

/// A main popular products view with a list.
final class PopularProductsView: UIView {

    // MARK: Properties

    /// Executed on a user refresh action for the list.
    var onRefresh: (() -> Void)?

    /// A loading progress indicator.
    let progressIndicator = UIActivityIndicatorView()

    /// A refresh controller for the table view.
    let refreshControl = UIRefreshControl()

    /// A table view with popular products.
    let tableView = makeProductsTableView()

    /// An empty label indicator for the table view.
    let emptyTableViewLabel = makeEmptyLabel()

    // MARK: Initializer

    /// Initializes the view.
    init() {
        super.init(frame: UIScreen.main.bounds)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Methods

    /// Updates table view with an empty or not state.
    /// - Parameter isEmpty: Indentifies whether table view is empty.
    func updateTableViewEmptyState(isEmpty: Bool) {
        tableView.backgroundView = isEmpty ? emptyTableViewLabel : nil
    }
}

// MARK: Setup Methods

private extension PopularProductsView {

    func setupView() {
        setupSubviews()
        setupConstraints()
        setupProperties()
    }

    func setupSubviews() {
        addSubview(tableView)
        addSubview(progressIndicator)
        progressIndicator.translatesAutoresizingMaskIntoConstraints = false
    }

    func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
                tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
                progressIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
                progressIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
            ]
        )
    }

    func setupProperties() {
        backgroundColor = .clear
        refreshControl.addTarget(self, action: #selector(refreshChanged), for: .valueChanged)
        tableView.refreshControl = refreshControl
        progressIndicator.color = .appDarkGreen
    }
}

// MARK: Implementation Details

private extension PopularProductsView {

    @objc func refreshChanged() {
        onRefresh?()
    }

    static func makeProductsTableView() -> UITableView {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 200
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.clipsToBounds = true
        tableView.separatorInset = .zero
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.reuseIdentifier)
        return tableView
    }

    static func makeEmptyLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.text = Localizable.ProductList.noData
        return label
    }
}
