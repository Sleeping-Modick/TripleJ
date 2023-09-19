//
//  PictureCell.swift
//  MeYouMeYou
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit
import SnapKit

final class PictureCell: UICollectionViewCell {
    static let identifier = "PictureCell"
 
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = Constant.cornerRadius
        view.clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    func configure(img: UIImage?) {
        imageView.image = img
    }
    
    private func setLayout() {
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(Constant.itemSize.width)
            $0.height.equalTo(Constant.itemSize.height)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
