//
//  DiaryAddView.swift
//  MeYouMeYou
//
//  Created by SeoJunYoung on 2023/09/20.
//

import UIKit
import SnapKit

class DiaryAddView: UIView {
    
    private lazy var scrollView = UIScrollView()
    
    private lazy var contentView = UIView()
    
    private lazy var titleTextField = UITextField()
    
    lazy var myCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        let showRow: CGFloat = 5
        let spacing: CGFloat = 10
        let cellWidth = (
            Constant.screenWidth
            - (Constant.defalutPadding * 2)
            - (spacing * (showRow - 1)
              )
        ) / showRow
        flowLayout.itemSize = CGSize(
            width: (cellWidth),
            height: (Constant.screenHeight * 0.04)
        )
        flowLayout.minimumLineSpacing = spacing
        flowLayout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    private lazy var textView = UITextView()

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
        setUpTitleTextField()
        setUpCollectionView()
        setUpTextView()
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
    
    func setUpTitleTextField() {
        contentView.addSubview(titleTextField)
        titleTextField.placeholder = "제목"
        titleTextField.font = UIFont.boldSystemFont(ofSize: 30)
//        titleTextField.layer.borderWidth = 1
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(Constant.defalutPadding)
            make.height.equalTo(Constant.screenHeight * 0.07)
        }
    }
    
    func setUpCollectionView() {
        contentView.addSubview(myCollectionView)
        myCollectionView.backgroundColor = .clear
        myCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom)
            make.left.right.equalToSuperview().inset(Constant.defalutPadding)
            make.height.equalTo(Constant.screenHeight * 0.04)
        }
    }
    
    func setUpTextView() {
        contentView.addSubview(textView)
        textView.layer.cornerRadius = 16
        textView.backgroundColor = .pointColor1
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(myCollectionView.snp.bottom).offset(Constant.screenHeight * 0.05)
            make.left.right.equalToSuperview().inset(Constant.defalutPadding)
            make.height.equalTo(Constant.screenHeight * 0.5)
            make.bottom.equalToSuperview().inset(Constant.screenHeight * 0.05)
        }
    }
}
