//
//  PetNameInputViewController.swift
//  MeongMungI
//
//  Created by 7aeHoon on 5/3/25.
//

import UIKit
import Then
import SnapKit
import RxSwift

// MARK: - 사용자가 자신의 반려동물 정보를 입력하기 위한 화면의 하위 뷰 컨트롤러
public final class PetNameInputViewController: UIViewController {
    
    // 반려동물 정보 입력 진행 상태 바
    private var inputProgressView = UIProgressView(progressViewStyle: .default).then {
        $0.trackTintColor = #colorLiteral(red: 0.9147436619, green: 0.9277587533, blue: 0.9341855645, alpha: 1)
        $0.progressTintColor = .mainColor
        $0.progress = 0.0
        $0.layer.cornerRadius = 4
        $0.clipsToBounds = true
    }
    
    // 인포 레이블
    private let infoLabel = UILabel().then {
        $0.text = "반려견의 이름을 알려주세요"
        $0.setLineSpacing(spacing: 5)
        $0.numberOfLines = 1
        $0.font = UIFont.pretendard(size: 23, family: .semiBold)
        $0.textColor = .primaryTextColor
    }
    
    // 반려동물 이름 레이블
    private let petNameLabel = UILabel().then {
        $0.text = "이름"
        $0.numberOfLines = 1
        $0.font = UIFont.pretendard(size: 14, family: .medium)
        $0.textColor = .secondaryTextColor
    }
    
    // 텍스트 필드 백그라운드 뷰
    private lazy var petNameTextFieldBackgroundView = UIView().then {
        $0.backgroundColor = .textFieldBackgroundColor
        $0.layer.cornerRadius = 15
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.borderColor.cgColor
        $0.clipsToBounds = true
    }
    
    // 반려동물 이름 텍스트 필드
    private let petNameTextField = UITextField().then {
        $0.placeholder = "이름을 입력해주세요"
        $0.font = .pretendard(size: 17, family: .medium)
        $0.textColor = .primaryTextColor
        $0.clipsToBounds = true
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.contentVerticalAlignment = .center
        $0.clearButtonMode = .whileEditing
    }
    
    // 다음 버튼
    public let nextButton = UIButton(type: .custom).then {
        $0.setTitle("다음", for: .normal)
        $0.titleLabel?.font = UIFont.pretendard(size: 18, family: .semiBold)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .mainColor
        $0.layer.cornerRadius = 17
        $0.clipsToBounds = true
    }
    
    weak var coordinator: AppCoordinator?
    
    private let disposeBag = DisposeBag()
    
    // MARK: - viewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupUI()
        setupLayout()
        hideKeyboardWhenTappedAround()
    }
    
    // MARK: - viewDidAppear
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
            self?.inputProgressView.setProgress(0.2, animated: true)
        }
    }
    
    // 하위 뷰 추가
    private func addSubviews() {
        [inputProgressView, infoLabel, petNameLabel, petNameTextFieldBackgroundView, nextButton].forEach {
            self.view.addSubview($0)
        }
        
        petNameTextFieldBackgroundView.addSubview(petNameTextField)
    }
    
    // UI 설정
    private func setupUI() {
        self.view.backgroundColor = .white
    }
    
    // Layout 설정
    private func setupLayout() {
        // 버튼의 높이 값
        let buttonHeight = 57
        // 수평 inset 값
        let horizonInset = 20
        // 수직 inset 값
        let verticalInset = 20
        
        inputProgressView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            make.leading.trailing.equalToSuperview().inset(horizonInset)
            make.centerX.equalToSuperview()
            make.height.equalTo(8)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(inputProgressView.snp.bottom).offset(50)
            make.leading.trailing.equalToSuperview().inset(horizonInset)
            make.centerX.equalToSuperview()
        }
        
        petNameLabel.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(50)
            make.leading.trailing.equalToSuperview().inset(horizonInset)
        }
        
        petNameTextFieldBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(petNameLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(horizonInset)
            make.centerX.equalToSuperview()
            make.height.equalTo(55)
        }
        
        petNameTextField.snp.makeConstraints { make in
            make.top.bottom.centerX.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(horizonInset)
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.keyboardLayoutGuide.snp.top).offset(-verticalInset)
            make.leading.trailing.equalToSuperview().inset(horizonInset)
            make.centerX.equalToSuperview()
            make.height.equalTo(buttonHeight)
        }
    }

}
