//
//  CollectionListViewCell.swift
//  AnimatedCollection
//
//  Created by Артем on 22.03.2023.
//

import UIKit


final class CollectionListViewCell: UICollectionViewCell {

    // MARK: - Properties

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    static var reuseIdentifier: String {
        return String(describing: CollectionListViewCell.self)
    }

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public
    
    func configure(with image: UIImage?) {
        guard let image = image else {
            imageView.image = .imageLoadingError
            return
        }

        imageView.image = image
    }

    // MARK: - Private

    private func setupImageView() {
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

        contentView.layer.cornerRadius = .cornerRadius
        contentView.layer.masksToBounds = true
    }
}

private extension CGFloat {
    static let cornerRadius: CGFloat = 20
}
