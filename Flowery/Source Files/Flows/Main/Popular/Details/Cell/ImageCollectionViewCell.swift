//
//  ImageCollectionViewCell.swift
//  Flowery
//

import UIKit

final class ImageCollectionViewCell: UICollectionViewCell {

    /// Reuse identifier for this cell used to identify them while rendering in table view.
    static let reuseIdentifier = "ImageCollectionViewCell"

    private let productImageView = makeImageView()

    private let progressIndicator = UIActivityIndicatorView()

    private var imageDownloader: ImageDownloader?

    private var imageDowloadingID: UUID?
    
    // MARK: - Initializers

    /// Initializes the view
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    // MARK: - Overrides

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        guard let imageDowloadingID = imageDowloadingID else { return }
        imageDownloader?.cancelTask(for: imageDowloadingID)
        productImageView.image = nil
    }

    func update(with imageURL: URL, imageDownloader: ImageDownloader) {
        self.imageDownloader = imageDownloader
        downloadImage(with: imageURL)
    }
}

private extension ImageCollectionViewCell {

    func setupView() {
        addSubview(productImageView)
        progressIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(progressIndicator)
        NSLayoutConstraint.activate(
            [
                productImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                productImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
                productImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
                productImageView.topAnchor.constraint(equalTo: topAnchor),
                progressIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
                progressIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
            ]
        )
        progressIndicator.startAnimating()
        progressIndicator.color = .appDarkGreen
    }
}

private extension ImageCollectionViewCell {

    static func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
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
