//
//  DiaryAddViewController.swift
//  MeYouMeYou
//
//  Created by SeoJunYoung on 2023/09/20.
//

import UIKit
import SwiftUI
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
        view.backgroundColor = .systemBackground
        view.addSubview(diaryAddView)
        diaryAddView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// SwiftUI를 활용한 미리보기
struct DiaryAddViewController_Previews: PreviewProvider {
    static var previews: some View {
        DiaryAddVCReprsentable().edgesIgnoringSafeArea(.all)
    }
}

struct DiaryAddVCReprsentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let diaryVC = DiaryAddViewController()
        return UINavigationController(rootViewController: diaryVC)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
    typealias UIViewControllerType = UIViewController
}
