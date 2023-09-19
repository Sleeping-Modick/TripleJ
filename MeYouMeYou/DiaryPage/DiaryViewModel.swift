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
    private var prevIndex: Int = 0
}

extension DiaryViewModel {
    var getItemCount: Int {
        return 10
    }
    
    var getPrevIndex: Int {
        return prevIndex
    }
    
    func setPrevIndex(index: Int) {
        prevIndex = index
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
