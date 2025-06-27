//
//  PetProfileDetailInputViewController.swift
//  MeongMungI
//
//  Created by 7aeHoon on 6/11/25.
//

import UIKit
import RxSwift
import RxCocoa

// MARK: - 사용자가 반려동물의 상세 프로필을 입력하기 위한 뷰 컨트롤러
public final class PetProfileDetailInputViewController: UIViewController {
    
    // custom View
    private let petProfileDetailInputView = PetProfileDetailInputView()
    
    // 중성화 여부 릴레이
    private let hasNeuteredRelay = PublishRelay<Bool>()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - loadView
    public override func loadView() {
        self.view = petProfileDetailInputView
    }
    
    // MARK: - viewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setupDelegate()
        bindNeuteringButtons()
    }
    
    // MARK: - viewDidAppear
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.layoutIfNeeded()
        // 입력 진행상태 바 애니메이션 설정
        self.petProfileDetailInputView.inputProgressView.setProgress(0.7, animated: true)
    }
    
    // MARK: - 델리게이트 설정
    private func setupDelegate() {
        self.petProfileDetailInputView.personalityTextView.delegate = self
    }
    
    // MARK: - 중성화 여부 버튼 바인드
    private func bindNeuteringButtons() {
        // 중성화 했어요 버튼의 클릭은 true
        petProfileDetailInputView.hasNeuteredButton.rx.tap
            .map { true }
            .bind(to: hasNeuteredRelay)
            .disposed(by: disposeBag)
        
        // 중성화 안했어요 버튼의 클릭은 false
        petProfileDetailInputView.notNeuteredButton.rx.tap
            .map { false }
            .bind(to: hasNeuteredRelay)
            .disposed(by: disposeBag)
        
        hasNeuteredRelay
            .distinctUntilChanged()
            .withUnretained(self)
            .subscribe(onNext: { owner, isMale in
                if isMale {
                    owner.petProfileDetailInputView.applySelectedStyle(to: owner.petProfileDetailInputView.hasNeuteredButton)
                    owner.petProfileDetailInputView.applyDeselectedStyle(to: owner.petProfileDetailInputView.notNeuteredButton)
                } else {
                    owner.petProfileDetailInputView.applySelectedStyle(to: owner.petProfileDetailInputView.notNeuteredButton)
                    owner.petProfileDetailInputView.applyDeselectedStyle(to: owner.petProfileDetailInputView.hasNeuteredButton)
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - 텍스트뷰 델리게이트 익스텐션
extension PetProfileDetailInputViewController: UITextViewDelegate {
    // MARK: - textViewDidBeginEditing
    public func textViewDidBeginEditing(_ textView: UITextView) {
        // 텍스트뷰의 텍스트 컬러가 placeholderText일 경우. 즉 텍스트가 없는 상태
        if textView.textColor == .placeholderText {
            textView.text = nil
            textView.textColor = .primaryTextColor
        }
    }
    
    // MARK: - textViewDidEndEditing
    public func textViewDidEndEditing(_ textView: UITextView) {
        // 사용자가 입력을 하지 않았을 때
        if textView.text.isEmpty {
            // placeholder 설정
            textView.text = "성격을 알려주세요"
            textView.textColor = .placeholderText
        }
    }
}
