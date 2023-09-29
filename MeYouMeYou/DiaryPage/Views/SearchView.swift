//
//  SearchView.swift
//  MeYouMeYou
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit
import SnapKit

final class SearchView: UIView {
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "검색"
        searchBar.searchTextField.font = .systemFont(ofSize: 12)
        return searchBar
    }()
    
    init() {
        super.init(frame: .zero)
        configure()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SearchView {
    func configure() {
        self.backgroundColor = .systemBackground
        self.layer.cornerRadius = 10
    }
    
    func setLayout() {
        [searchBar].forEach {
            self.addSubview($0)
        }
        
        searchBar.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview().inset(Constant.defalutPadding)
        }
    }
}
