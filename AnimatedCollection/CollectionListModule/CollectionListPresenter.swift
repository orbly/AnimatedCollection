//
//  CollectionListPresenter.swift
//  AnimatedCollection
//
//  Created by Артем on 22.03.2023.
//

import UIKit

protocol CollectionListPresenterProtocol: AnyObject {
    func viewDidAppear(ui: CollectionListViewProtocol)
    func configureView(with urlStrings: [String])
    func removeCellAt(indexPath: IndexPath)
    func reloadCollectionView(with urlStrings: [String])
}

final class CollectionListPresenter {

    // MARK: - Properties

    private let interactor: CollectionListInteractorProtocol
    private let router: CollectionListRouterProtocol
    private(set) weak var listView: CollectionListViewProtocol?

    // MARK: - Init

    init(interactor: CollectionListInteractorProtocol, router: CollectionListRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - CollectionListPresenterProtocol

extension CollectionListPresenter: CollectionListPresenterProtocol {
    func viewDidAppear(ui: CollectionListViewProtocol) {
        listView = ui

        listView?.cellSelectedAt = { [weak self] indexPath in
            self?.interactor.removeAt(indexPath: indexPath)
        }

        listView?.refreshControlWasTriggered = { [weak self] in
            self?.interactor.reloadData()
        }

        interactor.initializeView()
    }

    func configureView(with urlStrings: [String]) {
        listView?.configureView(with: urlStrings)
    }

    func removeCellAt(indexPath: IndexPath) {
        listView?.removeCellAt(indexPath: indexPath)
    }

    func reloadCollectionView(with urlStrings: [String]) {
        listView?.reloadCollectionView(with: urlStrings)
    }
}
