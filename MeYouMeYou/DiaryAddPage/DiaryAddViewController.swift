//
//  DiaryAddViewController.swift
//  MeYouMeYou
//
//  Created by SeoJunYoung on 2023/09/20.
//

import UIKit
import SnapKit

class DiaryAddViewController: UIViewController {

    private let diaryAddView = DiaryAddView()
    
}
extension DiaryAddViewController {
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
}

private extension DiaryAddViewController {
    func setUp() {
        view.backgroundColor = .backGroundColor
        view.addSubview(diaryAddView)
        diaryAddView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        diaryAddView.myCollectionView.delegate = self
        diaryAddView.myCollectionView.dataSource = self
        diaryAddView.myCollectionView.register(
            DiaryAddPageButtonCell.self,
            forCellWithReuseIdentifier: DiaryAddPageButtonCell.identifier
        )
    }
}

extension DiaryAddViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return 5
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: DiaryAddPageButtonCell.identifier,
            for: indexPath
        ) as? DiaryAddPageButtonCell else { return UICollectionViewCell() }
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        guard let viewModel = viewModel else { return CGSize() }
//        let categoryTitle = Category.allCases[indexPath.row].categoryTitle
//        let size = viewModel.getCategoryCellSize(categoryText: categoryTitle)
//        let cellInset: CGFloat = 20
//        return CGSize(width: size.0 + cellInset, height: size.1 + cellInset)
//    }

}

extension UIColor {
    static var backGroundColor = UIColor(named: "SeoBackColor")
    static var pointColor1 = UIColor(named: "SeoPointColor1")
    static var pointColor2 = UIColor(named: "SeoPointColor2")
}
