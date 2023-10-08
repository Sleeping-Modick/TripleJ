//
//  DiaryDetailViewController.swift
//  MeYouMeYou
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit
import SnapKit
import SwiftUI

final class DiaryDetailViewController: UIViewController {
    
    private let diaryDetailView = DiaryDetailView()
    
    override func loadView() {
        super.loadView()
        
        view = diaryDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setGesture()
        setTarget()
    }
    
    func configure(image: UIImage?) {
        diaryDetailView.imageView.image = image
    }
    
    deinit {
        print("deinit - DiaryDetailVC")
    }
}

private extension DiaryDetailViewController {
    func setGesture() {
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        gesture.direction = .down
        view.addGestureRecognizer(gesture)
    }
    
    func setTarget() {
        diaryDetailView.closeBtn.addTarget(
            self,
            action: #selector(didTappedCloseBtn),
            for: .touchUpInside)
        
        diaryDetailView.bubbleBtn.addTarget(
            self,
            action: #selector(didTappedBubbleBtn),
            for: .touchUpInside)
    }
    
    @objc func didTappedCloseBtn() {
        dismiss(animated: true)
    }
    
    @objc func didTappedBubbleBtn() {
        UIView.animate(withDuration: 0.7) {
            if self.diaryDetailView.descriptionLabel.alpha == 0 {
                self.diaryDetailView.descriptionLabel.alpha = 1
                return
            }
            self.diaryDetailView.descriptionLabel.alpha = 0
        }
    }
    
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        let direction = gesture.direction
        if direction == .down {
            dismiss(animated: true)
        }
    }
}
