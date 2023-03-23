//
//  CollectionListView.swift
//  AnimatedCollection
//
//  Created by Артем on 22.03.2023.
//

import UIKit

protocol CollectionListViewProtocol: AnyObject {
    var refreshControlWasTriggered: (() -> Void)? { get set }
    var cellSelectedAt: ((IndexPath) -> Void)? { get set }

    func configureView(with urlStrings: [String])
    func removeCellAt(indexPath: IndexPath)
    func reloadCollectionView(with urlStrings: [String])
}

final class CollectionListView: UIView {

    // MARK: - Properties

    private lazy var collectionView: UICollectionView = {
        let collectionView: UICollectionView = UICollectionView(frame: CGRect.zero,
                                                                collectionViewLayout: UICollectionViewFlowLayout.init())

        collectionView.register(CollectionListViewCell.self,
                                forCellWithReuseIdentifier: CollectionListViewCell.reuseIdentifier)

        collectionView.refreshControl = self.refreshControl
        return collectionView
    }()

    private lazy var refreshControl: UIRefreshControl = {
        let myRefreshControl = UIRefreshControl()

        myRefreshControl.addTarget(self,
                                   action: #selector(refreshAction),
                                   for: .valueChanged)
        return myRefreshControl
    }()

    private let imageLoader = ImageLoader()

    private var stringURLs: [String] = []

    var refreshControlWasTriggered: (() -> Void)?
    var cellSelectedAt: ((IndexPath) -> Void)?

    // MARK: - Init

    init() {
        super.init(frame: .zero)
        backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private

    @objc private func refreshAction() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.refreshControlWasTriggered?()
        }
    }

    private func setupCollectionListView() {
        let layout = setupCollectionViewLayout()
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear

        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: .defaultInset),
            collectionView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    private func setupCollectionViewLayout() -> UICollectionViewFlowLayout {
        // Ширина ячейки равна ширине экрана с отступами по 10 с каждого края
        let itemWidth = self.frame.width - 2 * CGFloat.sectionInset
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        // Высота ячейки равна ширине
        layout.itemSize = CGSize(width: itemWidth,
                                 height: itemWidth)

        layout.sectionInset = UIEdgeInsets(top: .sectionInset,
                                           left: .sectionInset,
                                           bottom: .sectionInset,
                                           right: .sectionInset)

        layout.minimumLineSpacing = .defaultInset

        return layout
    }
}

// MARK: - CollectionListViewProtocol

extension CollectionListView: CollectionListViewProtocol {
    func configureView(with urlStrings: [String]) {
        stringURLs = urlStrings
        setupCollectionListView()
        collectionView.reloadData()
    }

    func removeCellAt(indexPath: IndexPath) {
        if stringURLs.count > indexPath.row {
            stringURLs.remove(at: indexPath.row)
        }
        collectionView.deleteItems(at: [indexPath])
    }

    func reloadCollectionView(with urlStrings: [String]) {
        stringURLs = urlStrings
        collectionView.reloadData()
        collectionView.refreshControl?.endRefreshing()
    }
}

// MARK: - UICollectionViewDataSource

extension CollectionListView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stringURLs.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionListViewCell.reuseIdentifier,
                                                            for: indexPath) as? CollectionListViewCell
        else {
            fatalError("Can't dequeue reusable cell")
        }

        imageLoader.getImage(for: stringURLs[indexPath.row]) { image in
            cell.configure(with: image)
        }

        return cell
    }
}

extension CollectionListView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.3) {
            cell?.transform = CGAffineTransform(translationX: UIScreen.main.bounds.width,
                                                y: 0)
            cell?.alpha = 0
        } completion: { [weak self] _ in
            self?.cellSelectedAt?(indexPath)
        }

    }
}

// MARK: - CGFloat constants

private extension CGFloat {
    static let sectionInset: CGFloat = 10
    static let defaultInset: CGFloat = 16
}
