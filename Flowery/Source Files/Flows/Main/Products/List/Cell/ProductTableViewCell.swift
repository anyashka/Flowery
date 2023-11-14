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
    let descriptionLabel = makeDefaultLabel()
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
        description: String
    ) {
        self.imageDownloader = imageDownloader
        if let url = imageURL {
            downloadImage(with: url)
        } else {
            logError("ProductTableViewCell:update - received empty URL for image")
            progressIndicator.stopAnimating()
        }
        nameLabel.text = name
        descriptionLabel.text = description
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
            productImageView, descriptionLabel,
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
                nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
                nameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 16),
                nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
                descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
                descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
                descriptionLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor)
            ]
        )
    }

    func setupProperties() {
        backgroundColor = .clear
        nameLabel.font = .boldSystemFont(ofSize: 17)
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
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = CGFloat(CGFloat(ProductsListsViewConstants.imageWidth) / CGFloat(3.5))
        return imageView
    }

    static func makeDefaultLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
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
