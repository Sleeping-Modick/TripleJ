//
//  DiaryAddView.swift
//  MeYouMeYou
//
//  Created by SeoJunYoung on 2023/09/20.
//

import UIKit
import SnapKit

class DiaryAddView: UIView {
    
    private lazy var myCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: (UIScreen.main.bounds.width / 3), height: (UIScreen.main.bounds.width / 2))
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
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
        self.backgroundColor = .blue
        setUpCollectionView()
        setUpTextView()
    }
    
    func setUpCollectionView() {
        self.addSubview(myCollectionView)
        myCollectionView.backgroundColor = .green
        myCollectionView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(Constant.screenHeight * 0.05)
        }
    }
    
    func setUpTextView() {
        self.addSubview(textView)
        textView.backgroundColor = .red
        textView.snp.makeConstraints { make in
            make.top.equalTo(myCollectionView.snp.bottom).offset(Constant.screenHeight * 0.05)
            make.left.right.equalToSuperview().inset(Constant.defalutPadding)
            make.bottom.equalToSuperview().inset(Constant.screenHeight * 0.05)
        }
    }
}
