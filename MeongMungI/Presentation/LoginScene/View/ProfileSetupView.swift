//
//  ProfileSetupView.swift
//  MeongMungI
//
//  Created by 7aeHoon on 4/30/25.
//

import UIKit
import Then
import SnapKit

// MARK: - 사용자가 소셜 로그인을 통한 회원가입 후 초기 프로필을 설정하기 위한 뷰
public final class ProfileSetupView: UIView {
    // 버튼의 테두리 둥글기
    private static let buttonCornerRadius: CGFloat = 17
    
    // 인포 레이블
    private let infoLabel = UILabel().then {
        $0.text = "멍뭉이에서 사용할\n닉네임을 설정해 주세요"
        $0.setLineSpacing(spacing: 5)
        $0.numberOfLines = 2
        $0.font = UIFont.pretendard(size: 23, family: .SemiBold)
        $0.textColor = .mainTextColor
    }
    
    // 닉네임 레이블
    private let nicknameLabel = UILabel().then {
        $0.text = "닉네임"
        $0.numberOfLines = 1
        $0.font = UIFont.pretendard(size: 14, family: .Medium)
        $0.textColor = .mainTextColor
    }
    
    // 닉네임 텍스트 필드
    private let nicknameTextField = UITextField().then {
        $0.placeholder = "닉네임을 입력해 주세요"
        $0.font = UIFont.pretendard(size: 20, family: .Medium)
        $0.textColor = .mainTextColor
        $0.clipsToBounds = true
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.contentVerticalAlignment = .center
        $0.clearButtonMode = .whileEditing
    }
    
    // 닉네임 텍스트 필드 언더라인
    private let nicknameUnderlineView = UIView().then {
        $0.backgroundColor = .underlineColor
        $0.clipsToBounds = true
    }
    
    // 닉네임 정규식 레이블
    private let nicknameRegexResultLabel = UILabel().then {
        $0.text = "2~10자, 한글·영문·숫자만 입력해 주세요"
        $0.numberOfLines = 1
        $0.font = UIFont.pretendard(size: 14, family: .Medium)
        $0.textColor = .redColor
        $0.isHidden = true
    }
    
    // 확인 버튼
    public let confirmButton = UIButton(type: .custom).then {
        $0.setTitle("확인", for: .normal)
        $0.titleLabel?.font = UIFont.pretendard(size: 18, family: .SemiBold)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .mainColor
        $0.layer.cornerRadius = buttonCornerRadius
        $0.clipsToBounds = true
    }
    
    // MARK: - init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupUI()
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 하위 뷰 추가
    private func addSubviews() {
        [infoLabel, nicknameLabel, nicknameTextField, nicknameUnderlineView, nicknameRegexResultLabel, confirmButton].forEach {
            self.addSubview($0)
        }
    }
    
    // UI 설정
    private func setupUI() {
        self.backgroundColor = .white
    }
    
    // Layout 설정
    private func setupLayout() {
        let horizonInset = 20 // 수평 inset 값
        let verticalInset = 20 // 수직 inset 값
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(35)
            make.leading.trailing.equalToSuperview().inset(horizonInset)
            make.centerX.equalToSuperview()
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(60)
            make.leading.trailing.equalToSuperview().inset(horizonInset)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(horizonInset)
            make.centerX.equalToSuperview()
            make.height.equalTo(55)
        }
        
        nicknameUnderlineView.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(horizonInset)
            make.centerX.equalToSuperview()
            make.height.equalTo(2)
        }
        
        nicknameRegexResultLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameUnderlineView.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().inset(horizonInset)
            make.centerX.equalToSuperview()
        }
        
        confirmButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.keyboardLayoutGuide.snp.top).offset(-verticalInset)
            make.leading.trailing.equalToSuperview().inset(horizonInset)
            make.centerX.equalToSuperview()
            make.height.equalTo(55)
        }
    }
}
