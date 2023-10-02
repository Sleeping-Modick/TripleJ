//
//  DiaryAddView.swift
//  MeYouMeYou
//
//  Created by SeoJunYoung on 2023/09/20.
//

import UIKit
import SnapKit

final class DiaryAddView: UIView {
    // MARK: - Property
    private lazy var scrollView = UIScrollView()
    
    private lazy var contentView = UIView()
    
    lazy var imageButton = UIButton()
    
    lazy var titleTextField: UITextField = {
        let view = UITextField()
        let placeHolder = NSAttributedString(
            string: "제목", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray]
        )
        view.attributedPlaceholder = placeHolder
        view.font = UIFont.boldSystemFont(ofSize: 20)
        view.textAlignment = .center
        return view
    }()
    
    private lazy var optionCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        flowLayout.scrollDirection = .horizontal
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
    // MARK: - SetUp

    // TODO: - titleTextField 기능 활성화
    // TODO: - optionCollectionView 기능 활성화
    // TODO: - textView 기능 활성화
    
    func setUp() {
        self.backgroundColor = .clear
        setUpScrollView()
        setUpContentView()
        setUpImageButton()
        setUpTitleLabel()
        setUpOptionCollectionView()
        setUpContentTextView()
    }
    
    func setUpScrollView() {
        self.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setUpContentView() {
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView.snp.width)
        }
    }
    
    func setUpImageButton() {
        contentView.addSubview(imageButton)
        imageButton.tintColor = .pointColor2
        imageButton.backgroundColor = .pointColor1
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 100)
        let image = UIImage(systemName: "plus.app.fill", withConfiguration: imageConfig)
        imageButton.setImage(image, for: .normal)
        imageButton.snp.makeConstraints { make in
            make.height.width.equalTo(scrollView.snp.width)
            make.top.centerX.equalToSuperview()
        }
    }
    
    func setUpTitleLabel() {
        contentView.addSubview(titleTextField)
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(imageButton.snp.bottom).offset(Constant.defalutPadding)
//            make.left.right.equalToSuperview().inset(Constant.defalutPadding)
            make.centerX.equalToSuperview()
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
