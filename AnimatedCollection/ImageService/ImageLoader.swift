//
//  ImageLoader.swift
//  AnimatedCollection
//
//  Created by Артем on 22.03.2023.
//

import UIKit

final class ImageLoader {

    // MARK: - Properties

    private let cache = NSCache<NSString, UIImage>()
    private let utilityQueue = DispatchQueue.global(qos: .utility)
    private let mainQueue = DispatchQueue.main

    // MARK: - Public

    func getImage(for urlString: String, completion: @escaping (UIImage?) -> Void) {
        utilityQueue.async { [weak self] in
            guard let url = URL(string: urlString), let self = self else {
                return
            }

            if let cachedImage = self.cache.object(forKey: urlString as NSString) {
                self.mainQueue.async {
                    completion(cachedImage)
                }
            }

            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard error == nil, let data = data, let image = UIImage(data: data) else {
                    self.mainQueue.async {
                        completion(.imageLoadingError)
                    }
                    return
                }

                self.cache.setObject(image, forKey: urlString as NSString)
                self.mainQueue.async {
                    completion(image)
                }
            }

            task.resume()
        }
    }
}

extension UIImage {
    static let imageLoadingError = UIImage(named: "image_loading_error")
}
