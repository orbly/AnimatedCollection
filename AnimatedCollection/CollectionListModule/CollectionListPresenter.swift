//
//  CollectionListPresenter.swift
//  AnimatedCollection
//
//  Created by Артем on 22.03.2023.
//

import UIKit

protocol CollectionListPresenterProtocol: AnyObject {
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
}
