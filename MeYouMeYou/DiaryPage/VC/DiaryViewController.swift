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
    private let searchView = SearchView()
    private let viewModel = DiaryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setLayout()
        setGesture()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

private extension DiaryViewController {
    func configure() {
        view.backgroundColor = .systemBackground
        
        pictureView.collectionView.dataSource = self
        pictureView.collectionView.delegate = self
        pictureView.collectionView.prefetchDataSource = self
        searchView.searchBar.delegate = self
        searchView.isHidden = true
    }
    
    func setLayout() {
        [backgroundView, pictureView, searchView].forEach {
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
        
        searchView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(Constant.defalutPadding)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(Constant.defalutPadding)
            $0.height.equalTo(120)
        }
    }
    
    func setGesture() {
        let upGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        let downGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        upGesture.direction = .up
        downGesture.direction = .down
        
        [upGesture, downGesture].forEach {
            view.addGestureRecognizer($0)
        }
    }
    
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .up {
            searchView.isHidden = true
        }
        if gesture.direction == .down {
            searchView.isHidden = false
        }
    }
}

extension DiaryViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("text: \(searchText)")
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("====> \(searchBar.text)")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("search click")
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
        if Int(index) != viewModel.getPrevIndex {
            let preIndexPath = IndexPath(item: Int(index) - 1, section: 0)
            if let preCell = pictureView.collectionView.cellForItem(at: preIndexPath) {
                zoomFocusCell(cell: preCell, isFocus: false)
            }
            let nextIndexPath = IndexPath(item: Int(index) + 1, section: 0)
            if let nextCell = pictureView.collectionView.cellForItem(at: nextIndexPath) {
                zoomFocusCell(cell: nextCell, isFocus: false)
            }
            viewModel.setPrevIndex(index: indexPath.item)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DiaryDetailViewController()
        detailVC.configure(image: UIImage(named: viewModel.dummyImageName))
        detailVC.modalTransitionStyle = .crossDissolve
        detailVC.modalPresentationStyle = .custom
        searchView.isHidden = true
        view.endEditing(true)
        present(detailVC, animated: true)
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
