//
//  CalendarCollectionViewCell.swift
//  MeYouMeYou
//
//  Created by t2023-m0056 on 2023/09/20.
//

import UIKit
import SnapKit

class CalendarCollectionViewCell: UICollectionViewCell {
    static var identifier = "CalendarCollectionViewCell"
    
    var calendarPostTitle: UILabel = {
        var label = UILabel()
        label.text = "empty"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        contentView.backgroundColor = UIColor(named: "CustomBackgroundColor")
//        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = Constant.cornerRadius
        
        contentView.addSubview(calendarPostTitle)
        
        calendarPostTitle.snp.makeConstraints{
            $0.top.leading.trailing.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
    }
    
    func bind(_ title: String) {
        calendarPostTitle.text = title
    }
}
