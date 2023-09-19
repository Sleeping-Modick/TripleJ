//
//  ImageCacheManager.swift
//  MeYouMeYou
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit

final class ImageCacheManager {
    static let shared = ImageCacheManager()
    private init() { }
    
    private let cache = NSCache<NSString, UIImage>()
    
    func prefetchImage(imgName: String) {
        let image = UIImage(named: imgName)
        cachingImage(imgName: imgName, image: image)
    }
    
    func loadImage(imgName: String) -> UIImage? {
        if let image = cachedImage(imgName: imgName) {
            return image
        }
        return UIImage(named: imgName)
    }
    
    private func cachingImage(imgName: String, image: UIImage?) {
        guard let image = image else { return }
        cache.setObject(image, forKey: imgName as NSString)
    }
    
    private func cachedImage(imgName: String) -> UIImage? {
        cache.object(forKey: imgName as NSString)
    }
}
