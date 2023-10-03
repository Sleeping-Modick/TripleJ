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
    private let viewModel = DiaryAddViewModel()
}
extension DiaryAddViewController {
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
}

private extension DiaryAddViewController {
    // MARK: - SetUp

    func setUp() {
        view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.isHidden = true
        diaryAddView.optionCV.delegate = self
        diaryAddView.optionCV.dataSource = self
        diaryAddView.optionCV.register(
            DiaryAddPageButtonCell.self,
            forCellWithReuseIdentifier: DiaryAddPageButtonCell.identifier)
        diaryAddView.contentTextView.delegate = self
        setUpDiaryView()
    }
    
    func setUpDiaryView() {
        view.addSubview(diaryAddView)
        diaryAddView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        diaryAddView.imageButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        diaryAddView.titleTextField.delegate = self
    }
}

extension DiaryAddViewController {
    // MARK: - ButtonTappedMethod
    
    @objc func didTapButton(_ button: UIButton) {
        print(#function)
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
}

extension DiaryAddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: - UIImagePickerDelegate

    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.diaryAddView.imageButton.setImage(selectedImage, for: .normal)
            }
            
        }
        dismiss(animated: true, completion: nil)
    }
}

extension DiaryAddViewController: UITextFieldDelegate {
    // MARK: - Title 입력 제한

    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {

        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        let screenWidth = (Constant.screenWidth - (Constant.defalutPadding * 2))
        let maxWidth = Int(screenWidth / textField.font!.pointSize)
        if newText.count <= maxWidth {
            return true
        } else {
            return false
        }
    }
}

extension DiaryAddViewController: UITextViewDelegate {
    // MARK: - 유동적인 높이를 가진 textView
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        textView.constraints.forEach { (constraint) in
            if estimatedSize.height > Constant.screenHeight * 0.05 {
                if constraint.firstAttribute == .height {
                    constraint.constant = estimatedSize.height
                }
            }
        }
    }
}

extension DiaryAddViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        let count = CGFloat(viewModel.buttonList.count)
        let totalCellWidth = Constant.screenHeight * 0.05 * count
        let totalSpacingWidth = viewModel.cellSpacing * count - 1
        let leftInset = (collectionView.frame.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        print(leftInset)
        print(rightInset)

        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return viewModel.cellSpacing
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: Constant.screenHeight * 0.05, height: Constant.screenHeight * 0.05)
    }
    
}

extension DiaryAddViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.buttonList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: DiaryAddPageButtonCell.identifier, for: indexPath) as? DiaryAddPageButtonCell else {
            return UICollectionViewCell()
        }
        
        cell.bind(image: viewModel.buttonList[indexPath.row])
        return cell
    }
}

extension UIColor {
    static var backGroundColor = UIColor(named: "SeoBackColor")
    static var pointColor1 = UIColor(named: "SeoPointColor1")
    static var pointColor2 = UIColor(named: "SeoPointColor2")
}
