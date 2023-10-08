//
//  Constant.swift
//  MeYouMeYou
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit

enum Constant {
    static let itemSize = CGSize(width: 250, height: 333)
    static let itemSpacing: CGFloat = 10
    static let cornerRadius: CGFloat = 20
    
    static var insetX: CGFloat {
        (UIScreen.main.bounds.width - Self.itemSize.width) / 2
    }
    static var collectionViewContentInset: UIEdgeInsets {
        UIEdgeInsets(top: 0, left: Self.insetX, bottom: 0, right: Self.insetX)
    }
}

extension Constant {
    static let defalutPadding: CGFloat = 16
    static let screenHeight = UIScreen.main.bounds.height
    static let screenWidth = UIScreen.main.bounds.width
}
