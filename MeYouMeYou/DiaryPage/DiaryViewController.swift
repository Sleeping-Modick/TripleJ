//
//  DiaryViewController.swift
//  MeYouMeYou
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit
import SnapKit
import SwiftUI

final class DiaryViewController: UIViewController {
    private let backgroundView = BackgroundView()
    private let pictureView = PictureView()
    private let viewModel = DiaryViewModel()
    
    private var prevIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setLayout()
    }
}

private extension DiaryViewController {
    private func configure() {
        view.backgroundColor = .systemBackground
        
        pictureView.collectionView.dataSource = self
        pictureView.collectionView.delegate = self
        pictureView.collectionView.prefetchDataSource = self
    }
    
    private func setLayout() {
        [backgroundView, pictureView].forEach {
            view.addSubview($0)
        }
        
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        pictureView.snp.makeConstraints {
            $0.leading.right.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(Constant.itemSize.height)
            $0.centerY.equalToSuperview()
        }
    }
}

extension DiaryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getItemCount
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PictureCell.identifier,
            for: indexPath
        ) as? PictureCell else { return UICollectionViewCell() }
        let image = viewModel.loadImage(imageName: viewModel.dummyImageName)
        cell.configure(img: image)
        return cell
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let scrolledOffsetX = targetContentOffset.pointee.x + scrollView.contentInset.left
        let cellWidth = Constant.itemSize.width + Constant.itemSpacing
        let index = round(scrolledOffsetX / cellWidth)
        targetContentOffset.pointee = CGPoint(x: index * cellWidth - scrollView.contentInset.left,
                                              y: scrollView.contentInset.top)
        let image = viewModel.loadImage(imageName: viewModel.dummyImageName)
        backgroundView.configure(image: image)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrolledOffsetX = scrollView.contentOffset.x + scrollView.contentInset.left
        let cellWidth = Constant.itemSize.width + Constant.itemSpacing
        let index = round(scrolledOffsetX / cellWidth)

        let indexPath = IndexPath(item: Int(index), section: 0)
        
        if let cell = pictureView.collectionView.cellForItem(at: indexPath) {
            zoomFocusCell(cell: cell, isFocus: true)
        }
        if Int(index) != prevIndex {
            let preIndexPath = IndexPath(item: Int(index) - 1, section: 0)
            if let preCell = pictureView.collectionView.cellForItem(at: preIndexPath) {
                zoomFocusCell(cell: preCell, isFocus: false)
            }
            let nextIndexPath = IndexPath(item: Int(index) + 1, section: 0)
            if let nextCell = pictureView.collectionView.cellForItem(at: nextIndexPath) {
                zoomFocusCell(cell: nextCell, isFocus: false)
            }
            prevIndex = indexPath.item
        }
    }
    
    private func zoomFocusCell(cell: UICollectionViewCell, isFocus: Bool ) {
         UIView.animate( withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
             if isFocus {
                 cell.transform = .identity
             } else {
                 cell.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
             }
         }, completion: nil)
     }
}

extension DiaryViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            print("indexPath: \(indexPath)")
            viewModel.prefetchImage()
        }
    }
}

// SwiftUI를 활용한 미리보기
struct DiaryViewController_Previews: PreviewProvider {
    static var previews: some View {
        DiaryVCReprsentable().edgesIgnoringSafeArea(.all)
    }
}

struct DiaryVCReprsentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let diaryVC = DiaryViewController()
        return UINavigationController(rootViewController: diaryVC)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
    typealias UIViewControllerType = UIViewController
}
