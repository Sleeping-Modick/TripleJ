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
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    private lazy var contentView = UIView()
    
    lazy var imageButton: UIButton = {
        let button = UIButton()
        button.tintColor = .systemGray
        button.backgroundColor = .systemGray5
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 100)
        let image = UIImage(systemName: "plus.app.fill", withConfiguration: imageConfig)
        button.setImage(image, for: .normal)
        return button
    }()
    
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
    
    lazy var optionCV: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        flowLayout.scrollDirection = .horizontal
        return collectionView
    }()
    
    private lazy var cvTopDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        return view
    }()
    
    private lazy var cvBottomDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        return view
    }()
    
    lazy var contentTextView: UITextView = {
        let view = UITextView()
        view.backgroundColor = .yellow
        view.text = "오늘 하루는 어땠어요?"
        view.isScrollEnabled = false
        return view
    }()
    
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
    
    // TODO: - optionCollectionView 기능 활성화
    
    func setUp() {
        setUpScrollView()
        setUpContentView()
        setUpImageButton()
        setUpTitleLabel()
        setUpCVTopDivder()
        setUpOptionCV()
        setUpCVBottomDivder()
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
        imageButton.snp.makeConstraints { make in
            make.height.width.equalTo(scrollView.snp.width)
            make.top.centerX.equalToSuperview()
        }
    }
    
    func setUpTitleLabel() {
        contentView.addSubview(titleTextField)
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(imageButton.snp.bottom).offset(Constant.defalutPadding)
            make.centerX.equalToSuperview()
        }
    }
    
    func setUpCVTopDivder() {
        contentView.addSubview(cvTopDivider)
        cvTopDivider.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(Constant.defalutPadding)
            make.left.right.equalToSuperview().inset(Constant.defalutPadding)
            make.height.equalTo(1)
        }
    }
    
    func setUpOptionCV() {
        contentView.addSubview(optionCV)
        optionCV.snp.makeConstraints { make in
            make.top.equalTo(cvTopDivider.snp.bottom).offset(Constant.defalutPadding)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(Constant.defalutPadding)
            make.height.equalTo(Constant.screenHeight * 0.05)
        }
    }
    
    func setUpCVBottomDivder() {
        contentView.addSubview(cvBottomDivider)
        cvBottomDivider.snp.makeConstraints { make in
            make.top.equalTo(optionCV.snp.bottom).offset(Constant.defalutPadding)
            make.left.right.equalToSuperview().inset(Constant.defalutPadding)
            make.height.equalTo(1)
        }
    }
    
    func setUpContentTextView() {
        contentView.addSubview(contentTextView)
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(cvBottomDivider.snp.bottom).offset(Constant.defalutPadding)
            make.height.equalTo(Constant.screenHeight * 0.05)
            make.left.right.bottom.equalToSuperview().inset(Constant.defalutPadding)
        }
    }
}
