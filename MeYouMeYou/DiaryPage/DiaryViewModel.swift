//
//  DiaryViewModel.swift
//  MeYouMeYou
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit

final class DiaryViewModel {
    private let imageManager = ImageCacheManager.shared
    let dummyImageName = "dummy"
}

extension DiaryViewModel {
    var getItemCount: Int {
        return 10
    }
    
    var getImageName: String {
        return dummyImageName
    }
    
    func loadImage(imageName: String) -> UIImage? {
        return imageManager.loadImage(imgName: imageName)
    }
    
    func prefetchImage() {
        imageManager.prefetchImage(imgName: dummyImageName)
    }
}
