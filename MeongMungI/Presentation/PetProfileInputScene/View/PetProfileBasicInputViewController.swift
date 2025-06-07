//
//  PetBreedInputViewController.swift
//  MeongMungI
//
//  Created by 7aeHoon on 5/3/25.
//

import UIKit
import RxSwift
import RxCocoa

// MARK: - 사용자가 자신의 반려동물 정보를 입력하기 위한 뷰 컨트롤러
public final class PetProfileBasicInputViewController: UIViewController {
    
    private let petProfileBasicInputView = PetProfileBasicInputView()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - loadView
    public override func loadView() {
        self.view = petProfileBasicInputView
    }
    
    // MARK: - viewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
        hideKeyboardWhenTappedAround()
    }
    
    // MARK: - 델리게이트 설정
    private func setupDelegate() {
        self.petProfileBasicInputView.breedSelectionField.delegate = self
        self.petProfileBasicInputView.birthSelectionField.delegate = self
    }
    
}

extension PetProfileBasicInputViewController: UITextFieldDelegate {
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == petProfileBasicInputView.breedSelectionField {
            print("견종 필드 입력 감지")
            return false
        } else if textField == petProfileBasicInputView.birthSelectionField {
            print("생년월일 필드 입력 감지")
            return false
        }
        
        return true
    }
}
