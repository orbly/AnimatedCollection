//
//  CollectionListModuleAssembly.swift
//  AnimatedCollection
//
//  Created by Артем on 22.03.2023.
//
import UIKit

final class CollectionListModuleAssembly {
    static func createCollectionListModule() -> UIViewController {
        let interactor = CollectionListInteractor()
        let router = CollectionListRouter()
        let presenter = CollectionListPresenter(interactor: interactor, router: router)
        let viewController = CollectionListViewController(presenter: presenter)

        router.viewController = viewController
        interactor.presenter = presenter

        return viewController
    }
}
