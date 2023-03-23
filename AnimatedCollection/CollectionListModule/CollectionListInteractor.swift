//
//  CollectionListInteractor.swift
//  AnimatedCollection
//
//  Created by Артем on 22.03.2023.
//

import Foundation

protocol CollectionListInteractorProtocol: AnyObject {
    func initializeView()
    func reloadData()
    func removeAt(indexPath: IndexPath)
}

final class CollectionListInteractor {
    weak var presenter: CollectionListPresenterProtocol?
    private(set) var urlStrings: [String] = []
    private let imageManager = ImageManager()
    
}

// MARK: - CollectionListInteractorProtocol
extension CollectionListInteractor: CollectionListInteractorProtocol {
    func initializeView() {
        imageManager.fetch { [weak self] urlStrings in
            self?.urlStrings = urlStrings
            self?.presenter?.configureView(with: urlStrings)
        }
    }

    func reloadData() {
        imageManager.fetch { [weak self] urlStrings in
            self?.urlStrings = urlStrings
            self?.presenter?.reloadCollectionView(with: urlStrings)
        }
    }

    func removeAt(indexPath: IndexPath) {
        if urlStrings.count > indexPath.row {
            urlStrings.remove(at: indexPath.row)
            presenter?.removeCellAt(indexPath: indexPath)
        }
    }
}
