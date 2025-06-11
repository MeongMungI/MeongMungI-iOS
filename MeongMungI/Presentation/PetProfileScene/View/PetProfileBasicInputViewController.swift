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
    
    private let isMaleSelectedRelay = PublishRelay<Bool>()
    
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
        bindGenderButtons()
        
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
    
    // MARK: - 반려동물 성별 버튼 바인드
    private func bindGenderButtons() {
        // 남아 버튼의 클릭은 true
        petProfileBasicInputView.maleSelectionButton.rx.tap
            .map { true }
            .bind(to: isMaleSelectedRelay)
            .disposed(by: disposeBag)
        
        // 남아 버튼의 클릭은 false
        petProfileBasicInputView.femaleSelectionButton.rx.tap
            .map { false }
            .bind(to: isMaleSelectedRelay)
            .disposed(by: disposeBag)
        
        isMaleSelectedRelay
            .distinctUntilChanged()
            .withUnretained(self)
            .subscribe(onNext: { owner, isMale in
                if isMale {
                    owner.petProfileBasicInputView.applySelectedStyle(to: owner.petProfileBasicInputView.maleSelectionButton)
                    owner.petProfileBasicInputView.applyDeselectedStyle(to: owner.petProfileBasicInputView.femaleSelectionButton)
                } else {
                    owner.petProfileBasicInputView.applySelectedStyle(to: owner.petProfileBasicInputView.femaleSelectionButton)
                    owner.petProfileBasicInputView.applyDeselectedStyle(to: owner.petProfileBasicInputView.maleSelectionButton)
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - 텍스트필드 델리게이트 익스텐션
extension PetProfileBasicInputViewController: UITextFieldDelegate {
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == petProfileBasicInputView.breedSelectionField {
            navigateToBreedSelection()
            return false
        } else if textField == petProfileBasicInputView.birthSelectionField {
            presentToBirthSelection()
            return false
        }
        
        return true
    }
}

// MARK: - 화면 전환 익스텐션
extension PetProfileBasicInputViewController {
    // MARK: - 견종 선택 클릭 이벤트 -> 견종을 선택하는 화면으로 이동
    private func navigateToBreedSelection() {
        let breedSelectionViewController = BreedSelectionViewController()
        
        // 클로저로부터 전달된 견종을 텍스트 필드에 설정
        breedSelectionViewController.didSelectBreed = { [weak self] selectedBreed in
            self?.petProfileBasicInputView.breedSelectionField.text = selectedBreed
        }
        
        navigationController?.pushViewController(breedSelectionViewController, animated: true)
    }
    
    // MARK: - 생년월일 선택 클릭 이벤트 -> 생년월일을 선택하는 화면으로 이동
    private func presentToBirthSelection() {
        let birthSelectionViewController = BirthSelectionViewController()
        birthSelectionViewController.modalPresentationStyle = .pageSheet
        
        if let sheet = birthSelectionViewController.sheetPresentationController {
            // 커스텀 detent
            let small = UISheetPresentationController.Detent.custom(identifier: .init("small")) { _ in return 330 }
            sheet.detents = [small]
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.preferredCornerRadius = 20
            // 손잡이 숨기기
            sheet.prefersGrabberVisible = false
        }
        
        // 클로저로부터 전달된 생년월일을 텍스트 필드에 할당
        birthSelectionViewController.didSelectBirth = { [weak self] selectedDate in
            print("date picker send \(selectedDate)")
            self?.petProfileBasicInputView.birthSelectionField.text = selectedDate
        }
        
        present(birthSelectionViewController, animated: true)
    }
}
