//
//  ProductDetailsViewController.swift
//  Flowery
//

import UIKit

/// A detail view controller of the product.
final class ProductDetailsViewController: UIViewController {

    // MARK: Properties

    let customView: ProductDetailsView
    let product: Product

    // MARK: Private Properties

    private var productImageURLs: [URL] = []
    private let viewModel: ProductDetailsViewModel
    private let imageDownloader: ImageDownloader

    // MARK: Initializers

    /// Initializing the view controller.
    ///
    /// - Parameters:
    ///     - viewModel: a view model for the controller.
    ///     - product: a product for which the screen is being shown.
    ///     - imageDownloader: image downloader used for fetching images.
    init(
        viewModel: ProductDetailsViewModel,
        product: Product,
        imageDownloader: ImageDownloader
    ) {
        customView = ProductDetailsView(
            name: product.attributes.name,
            description: product.attributes.description,
            price: NumberFormatter.getAmountPriceText(for: product)
        )
        self.viewModel = viewModel
        self.product = product
        self.imageDownloader = imageDownloader
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable, message: "Use init() instead")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life Cycle

    override func loadView() {
        super.loadView()
        view = customView
        view.clipsToBounds = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        customView.collectionView.dataSource = self
        customView.collectionView.delegate = self
        productImageURLs = viewModel.getImagesURL(for: product)
        customView.update(numberOfImages: productImageURLs.count)
        customView.collectionView.reloadData()
    }
}

// MARK: UICollectionViewDataSource & UICollectionViewDelegate

extension ProductDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        productImageURLs.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
        cell.update(with: productImageURLs[indexPath.row], imageDownloader: imageDownloader)
        return cell
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        customView.pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}

