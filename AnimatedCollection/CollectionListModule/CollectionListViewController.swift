//
//  CollectionListViewController.swift
//  AnimatedCollection
//
//  Created by Артем on 22.03.2023.
//

import UIKit


final class CollectionListViewController: UIViewController {

    // MARK: - Properties

    private let presenter: CollectionListPresenterProtocol?

    // MARK: - Init

    init(presenter: CollectionListPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Controller Lifecycle
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
