//
//  BackgroundView.swift
//  MeYouMeYou
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit
import SnapKit

final class BackgroundView: UIView {
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private lazy var whiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0.3
        return view
    }()
    
    func configure(image: UIImage?) {
        imageView.image = image
    }
    
    init() {
        super.init(frame: .zero)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension BackgroundView {
    func setLayout() {
        [imageView, whiteView].forEach {
            self.addSubview($0)
        }
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        whiteView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
