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
        setupNavigation()
        setupDelegate()
        hideKeyboardWhenTappedAround()
    }
    
    // MARK: - 네비게이션 설정
    private func setupNavigation() {
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    // MARK: - 델리게이트 설정
    private func setupDelegate() {
        self.petProfileBasicInputView.breedSelectionField.delegate = self
        self.petProfileBasicInputView.birthSelectionField.delegate = self
    }
    
    // MARK: - "견종을 선택해 주세요" 클릭 이벤트 -> 견종을 선택하는 화면으로 이동
    private func navigateToBreedSelection() {
        let breedSelectionViewController = BreedSelectionViewController()
        breedSelectionViewController.didSelectBreed = { [weak self] selectedBreed in
            self?.petProfileBasicInputView.breedSelectionField.text = selectedBreed
        }
        navigationController?.pushViewController(breedSelectionViewController, animated: true)
    }
    
}

// MARK: - 텍스트필드 델리게이트 익스텐션
extension PetProfileBasicInputViewController: UITextFieldDelegate {
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == petProfileBasicInputView.breedSelectionField {
            navigateToBreedSelection()
            return false
        } else if textField == petProfileBasicInputView.birthSelectionField {
            print("생년월일 필드 입력 감지")
            return false
        }
        
        return true
    }
}
