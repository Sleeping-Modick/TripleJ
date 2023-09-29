//
//  DiaryDetailView.swift
//  MeYouMeYou
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit
import SnapKit

final class DiaryDetailView: UIView {
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    lazy var closeBtn: UIButton = {
        let button = UIButton(type: .close)
        return button
    }()
    
    lazy var bubbleBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "quote.bubble.fill"), for: .normal)
        button.tintColor = .systemPink
        return button
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        label.numberOfLines = 0
        label.text = """
        너무 잠와....
        하기 싫어...
        너무 잠와....
        하기 싫어...
        """
//        label.isHidden = true
        label.alpha = 0
        label.textAlignment = .center
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension DiaryDetailView {
    func setLayout() {
        [imageView, closeBtn, bubbleBtn, descriptionLabel].forEach {
            self.addSubview($0)
        }
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        closeBtn.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.leading.top.equalTo(self.safeAreaLayoutGuide).inset(Constant.defalutPadding)
        }
        
        bubbleBtn.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.trailing.top.equalTo(self.safeAreaLayoutGuide).inset(Constant.defalutPadding)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(bubbleBtn.snp.bottom).offset(50)
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(16)
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
