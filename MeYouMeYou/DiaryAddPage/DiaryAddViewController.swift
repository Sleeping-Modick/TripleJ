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
    // MARK: - SetUp

    func setUp() {
        view.backgroundColor = .backGroundColor
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
    
    @objc func didTapButton(_ sender: UIButton) {
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

    func textFieldDidChangeSelection(_ textField: UITextField) {

        var text = textField.text ?? ""
        let width = textField.frame.width
        if width > (Constant.screenWidth - (Constant.defalutPadding * 2)) {
            text.popLast()
            print("text\(text),width\(width)")
            diaryAddView.titleTextField.text = text
            let frame = diaryAddView.titleTextField.frame
            diaryAddView.titleTextField.frame = CGRect(x: frame.midX, y: frame.midY, width: 300, height: frame.height)
        }
    }
    
//    func textField(
//        _ textField: UITextField,
//        shouldChangeCharactersIn range: NSRange,
//        replacementString string: String
//    ) -> Bool {
//
//        let currentText = textField.text ?? ""
//        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
//        let screenWidth = (Constant.screenWidth - (Constant.defalutPadding * 2))
//        let maxWidth = Int(screenWidth / textField.font!.pointSize)
//        if newText.count <= maxWidth {
//            return true
//        } else {
//            return false
//        }
//    }
}

extension UIColor {
    static var backGroundColor = UIColor(named: "SeoBackColor")
    static var pointColor1 = UIColor(named: "SeoPointColor1")
    static var pointColor2 = UIColor(named: "SeoPointColor2")
}
