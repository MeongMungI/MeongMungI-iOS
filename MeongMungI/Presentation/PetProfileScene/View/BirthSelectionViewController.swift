//
//  BirthSelectionViewController.swift
//  MeongMungI
//
//  Created by 7aeHoon on 6/9/25.
//

import UIKit
import RxSwift
import RxCocoa

public final class BirthSelectionViewController: UIViewController {
    
    private let birthSelectionView = BirthSelectionView()
    // 이전화면에 생년월일 데이터를 전달하기 위한 클로저
    public var didSelectBirth: ((String) -> Void)?
    
    private let disposeBag = DisposeBag()
    
    // MARK: - loadView
    public override func loadView() {
        self.view = birthSelectionView
    }

    // MARK: - viewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()
        bindCompleteButton()
    }
    
    // MARK: - bindCompleteButton
    private func bindCompleteButton() {
        self.birthSelectionView.completeButton.rx.tap
            .withLatestFrom(birthSelectionView.datePicker.rx.date)
            .withUnretained(self)
            .subscribe(onNext: { owner, date in
                let dateString = owner.birthSelectionView.formatter.string(from: date)
                owner.didSelectBirth!(dateString)
                owner.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }
}
