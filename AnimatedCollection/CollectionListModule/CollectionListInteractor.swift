//
//  CollectionListInteractor.swift
//  AnimatedCollection
//
//  Created by Артем on 22.03.2023.
//

import Foundation

protocol CollectionListInteractorProtocol: AnyObject {
}

final class CollectionListInteractor {
    weak var presenter: CollectionListPresenterProtocol?
    private(set) var urlStrings: [String] = []
    private let imageManager = ImageManager()
    
}

// MARK: - CollectionListInteractorProtocol
extension CollectionListInteractor: CollectionListInteractorProtocol {
}
