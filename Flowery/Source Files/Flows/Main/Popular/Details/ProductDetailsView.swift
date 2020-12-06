//
//  ProductDetailsView.swift
//  Flowery
//

import UIKit

/// A product details view.
final class ProductDetailsView: UIView {

    // MARK: Properties

    let nameLabel = makeDefaultLabel()
    let collectionView = makeCollectionView()
    let emptyCollectionLabel = makeDefaultLabel()
    let pageControl = makeDefaultPageControl()
    let descriptionLabel = makeDefaultLabel()
    let priceLabel = makeDefaultLabel()
    let scrollView = makeScrollView()
    let contentView = makeScrollContentView()

    // MARK: Initializer

    /// Initializing the view with a data.
    ///
    /// - Parameters:
    ///     - name: a name of the product to be shown in the view.
    ///     - description: a full description text for the product.
    ///     - price: a full price together with currency for the product.
    init(name: String, description: String, price: String) {
        super.init(frame: UIScreen.main.bounds)
        setupView()
        descriptionLabel.text = description
        nameLabel.text = name
        priceLabel.text = price
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Methods

    /// Updating a view.
    ///
    ///  - Parameter numberOfImages: a number of images to be contained in the collectiion view.
    func update(numberOfImages: Int) {
        if numberOfImages > 0 {
            pageControl.numberOfPages = numberOfImages
        } else {
            collectionView.backgroundView = emptyCollectionLabel
        }
    }
}

// MARK: Setup

private extension ProductDetailsView {

    func setupView() {
        setupSubviews()
        setupConstraints()
        setupProperties()
    }

    func setupSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        [
            nameLabel, collectionView, pageControl,
            descriptionLabel, priceLabel
        ].forEach {
            contentView.addSubview($0)
        }
    }

    func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
                scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
                scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
                contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                contentView.heightAnchor.constraint(greaterThanOrEqualTo: heightAnchor),
                contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
                nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                collectionView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
                collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                collectionView.heightAnchor.constraint(equalToConstant: ProductDetailsViewConstants.imageCellWidth),
                collectionView.widthAnchor.constraint(equalToConstant: ProductDetailsViewConstants.imageCellWidth),
                pageControl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 8),
                pageControl.heightAnchor.constraint(equalToConstant: 8),
                descriptionLabel.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 12),
                descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
                priceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 12),
                priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                priceLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -40)
            ]
        )
    }

    func setupProperties() {
        backgroundColor = .white
        nameLabel.font = .boldSystemFont(ofSize: 17)
        priceLabel.font = .boldSystemFont(ofSize: 17)
        nameLabel.textColor = .appDarkBeige
        emptyCollectionLabel.text = Localizable.ProductDetail.noImageData
    }
}

// MARK: Implementation Details

private extension ProductDetailsView {
    
    static func makeCollectionView() -> UICollectionView {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: ProductDetailsViewConstants.imageCellWidth, height: ProductDetailsViewConstants.imageCellWidth)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.reuseIdentifier)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }

    static func makeDefaultLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    static func makeDefaultPageControl() -> UIPageControl {
        let view = UIPageControl()
        view.pageIndicatorTintColor = .appGreen
        view.currentPageIndicatorTintColor = .appDarkGreen
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        return view
    }

    static func makeScrollView() -> UIScrollView {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }

    static func makeScrollContentView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}
