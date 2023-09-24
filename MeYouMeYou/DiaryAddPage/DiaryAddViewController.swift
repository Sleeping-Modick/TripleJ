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
    private let viewModle = DiaryAddViewModel()
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
    }
}

extension UIColor {
    static var backGroundColor = UIColor(named: "SeoBackColor")
    static var pointColor1 = UIColor(named: "SeoPointColor1")
    static var pointColor2 = UIColor(named: "SeoPointColor2")
}
