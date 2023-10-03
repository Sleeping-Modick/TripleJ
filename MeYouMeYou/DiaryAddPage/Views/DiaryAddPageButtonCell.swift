//
//  DiaryAddPageButtonCell.swift
//  MeYouMeYou
//
//  Created by SeoJunYoung on 2023/09/20.
//

import UIKit
import SnapKit

class DiaryAddPageButtonCell: UICollectionViewCell {
    
    static let identifier = "DiaryAddPageButtonCell"
    
    private lazy var button = UIButton()
    
    // MARK: - initializer

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - method

    func bind(image: UIImage?) {
        button.setImage(image, for: .normal)
    }
}

private extension DiaryAddPageButtonCell {
    func setUp() {
        contentView.addSubview(button)
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
