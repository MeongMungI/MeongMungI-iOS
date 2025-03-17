//
//  LoginView.swift
//  MeongMungI
//
//  Created by 7aeHoon on 3/17/25.
//

import UIKit
import Then
import SnapKit
import AuthenticationServices

// MARK: - 사용자가 로그인하기 위한 커스텀 로그인 뷰
public final class LoginView: UIView {
    // 버튼의 테두리 둥글기
    private static let buttonCornerRadius: CGFloat = 17
    
    // 앱 메인 로고 이미지
    private let logoImageView = UIImageView().then {
        $0.image = .logo
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
    }
    
    // 카카오톡 로그인 버튼
    public let kakaoLoginButton = UIButton(type: .custom).then {
        $0.setBackgroundImage(UIImage(resource: .kakaoLogin), for: .normal)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = buttonCornerRadius
        // 버튼을 클릭했을 때 깜빡이는 효과 제거
        $0.adjustsImageWhenHighlighted = false
    }
    
    // 애플 로그인 버튼
    public let appleLoginButton = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn, authorizationButtonStyle: .black).then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = buttonCornerRadius
    }
    
    // 초기화
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
        [logoImageView, kakaoLoginButton, appleLoginButton].forEach {
            self.addSubview($0)
        }
    }
    
    // UI 설정
    private func setupUI() {
        self.backgroundColor = .white
    }
    
    // Layout 설정
    private func setupLayout() {
        // 버튼의 높이 값
        let buttonHeight = 57
        
        // 수평 inset 값
        let horizonInset = 20
        
        logoImageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(50)
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(300)
            make.width.equalTo(logoImageView.snp.height)
        }
        
        kakaoLoginButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(horizonInset)
            make.bottom.equalTo(appleLoginButton.snp.top).offset(-20)
            make.centerX.equalToSuperview()
            make.height.equalTo(buttonHeight)
        }
        
        appleLoginButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(horizonInset)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(40)
            make.centerX.equalToSuperview()
            make.height.equalTo(buttonHeight)
        }
    }
    

}
