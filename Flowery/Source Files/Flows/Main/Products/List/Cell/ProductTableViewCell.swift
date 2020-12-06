//
//  ProductTableViewCell.swift
//  Flowery
//

import UIKit

/// A product table view cell.
final class ProductTableViewCell: UITableViewCell {

    // MARK: Properties

    /// Reuse identifier for this cell used to identify them while rendering in table view.
    static let reuseIdentifier = "ProductTableViewCell"

    // MARK: Private Properties

    private let productImageView = makeImageView()
    let priceLabel = makeDefaultLabel()
    let nameLabel = makeDefaultLabel()
    private let progressIndicator = UIActivityIndicatorView()
    private var imageDownloader: ImageDownloader?
    private var imageDowloadingID: UUID?

    // MARK: Initializers

    /// Initialize an instance and calls required methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    @available(*, unavailable, message: "Use init(style:reuseIdentifier:) instead")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life Cycle

    override func prepareForReuse() {
        super.prepareForReuse()
        guard let imageDowloadingID = imageDowloadingID else { return }
        imageDownloader?.cancelTask(for: imageDowloadingID)
        productImageView.image = nil
        progressIndicator.startAnimating()
    }

    // MARK: Methods

    func update(
        with imageURL: URL?,
        imageDownloader: ImageDownloader,
        name: String,
        price: String
    ) {
        self.imageDownloader = imageDownloader
        if let url = imageURL {
            downloadImage(with: url)
        } else {
            logError("ProductTableViewCell:update - received empty URL for image")
            progressIndicator.stopAnimating()
        }
        nameLabel.text = name
        priceLabel.text = price
    }

}

// MARK: Setup Methods

private extension ProductTableViewCell {

    func setupView() {
        setupSubviews()
        setupConstraints()
        setupProperties()
    }

    func setupSubviews() {
        [
            productImageView, priceLabel,
            nameLabel, progressIndicator
        ].forEach {
            addSubview($0)
        }
        progressIndicator.translatesAutoresizingMaskIntoConstraints = false
    }

    func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                progressIndicator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat(ProductsListsViewConstants.imageWidth) / 2),
                progressIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
                productImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                productImageView.widthAnchor.constraint(equalToConstant: CGFloat(ProductsListsViewConstants.imageWidth)),
                productImageView.heightAnchor.constraint(equalToConstant: CGFloat(ProductsListsViewConstants.imageWidth)),
                productImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
                nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 46),
                nameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 12),
                nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
                priceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
                priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -46),
                priceLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor)
            ]
        )
    }

    func setupProperties() {
        backgroundColor = .white
        nameLabel.font = .boldSystemFont(ofSize: 17)
        nameLabel.numberOfLines = 0
        nameLabel.textColor = .appDarkBeige
        progressIndicator.startAnimating()
        selectionStyle = .none
    }
}

// MARK: Implementation details

private extension ProductTableViewCell {

    static func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }

    static func makeDefaultLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    func downloadImage(with URL: URL) {
        imageDowloadingID = imageDownloader?.download(with: URL, completionHandler: { [weak self] result in
            DispatchQueue.main.async {
                self?.progressIndicator.stopAnimating()
                switch result {
                case let .success(image):
                    self?.productImageView.image = image
                case .failure:
                    logError("ProductTableViewCell:downloadImage - failed to download image")
                }
            }
        })
    }
}
