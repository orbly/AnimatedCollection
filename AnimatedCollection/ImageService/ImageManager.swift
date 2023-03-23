//
//  ImageManager.swift
//  AnimatedCollection
//
//  Created by Артем on 22.03.2023.
//

import Foundation

final class ImageManager {

    func fetch(completion: ([String]) -> Void) {
        let imageURLs = [
            "https://mcdn.wallpapersafari.com/medium/85/39/Uew4R6.jpg",
            "https://mcdn.wallpapersafari.com/medium/46/84/PkNvVj.jpg",
            "https://mcdn.wallpapersafari.com/medium/45/41/y1LjfG.jpg",
            "https://mcdn.wallpapersafari.com/medium/75/29/zyj9VZ.jpg",
            "https://mcdn.wallpapersafari.com/medium/75/50/2uRkPv.jpg",
            "https://mcdn.wallpapersafari.com/medium/16/94/6UX4py.jpg"
        ]

        completion(imageURLs)
    }
}
