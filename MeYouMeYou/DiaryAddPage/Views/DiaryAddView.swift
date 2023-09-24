//
//  DiaryAddView.swift
//  MeYouMeYou
//
//  Created by SeoJunYoung on 2023/09/20.
//

import UIKit
import SnapKit

class DiaryAddView: UIView {
    // MARK: - Property

    private lazy var scrollView = UIScrollView()
    private lazy var contentView = UIView()
    private lazy var imageView = UIImageView()
    private lazy var titleTextField = UITextField()
    private lazy var optionCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        flowLayout.scrollDirection = .horizontal
//        flowLayout.itemSize = CGSize(width: (UIScreen.main.bounds.width / 3), height: (UIScreen.main.bounds.width / 2))
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0

        return collectionView
    }()
    private lazy var contentTextView = UITextView()
    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
private extension DiaryAddView {
    
    func setUp() {
        self.backgroundColor = .clear
        setUpScrollView()
        setUpContentView()
        setUpImageView()
        setUpTitleLabel()
        setUpOptionCollectionView()
        setUpContentTextView()
    }
    
    func setUpScrollView() {
        self.addSubview(scrollView)
        scrollView.backgroundColor = .green
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
//            make.left.right.equalToSuperview().inset(Constant.defalutPadding)
        }
    }
    
    func setUpContentView() {
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView.snp.width)
        }
    }
    
    func setUpImageView() {
        contentView.addSubview(imageView)
        imageView.backgroundColor = .blue
        imageView.snp.makeConstraints { make in
            make.height.width.equalTo(scrollView.snp.width)
            make.top.centerX.equalToSuperview()
        }
    }
    
    func setUpTitleLabel() {
        contentView.addSubview(titleTextField)
        titleTextField.backgroundColor = .red
        titleTextField.placeholder = "제목"
        titleTextField.textAlignment = .center
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(Constant.defalutPadding)
            make.left.right.equalToSuperview()
        }
    }
    
    func setUpOptionCollectionView() {
        contentView.addSubview(optionCollectionView)
        optionCollectionView.backgroundColor = .cyan
        optionCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(Constant.defalutPadding)
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    func setUpContentTextView() {
        contentView.addSubview(contentTextView)
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(optionCollectionView.snp.bottom).offset(Constant.defalutPadding)
            make.height.equalTo(Constant.screenWidth)
            make.left.right.bottom.equalToSuperview().inset(Constant.defalutPadding)
        }
    }
}
