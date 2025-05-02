//
//  LoginViewController.swift
//  MeongMungI
//
//  Created by 7aeHoon on 3/17/25.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

// MARK: - 로그인 뷰 컨트롤러
public final class LoginViewController: UIViewController {
    
    // 커스텀 로그인 뷰
    private let loginView = LoginView()
    
    // 로그인 화면을 관리하는 코디네이터
    weak var coordinator: AppCoordinator?
    
    private let disposeBag = DisposeBag()
    
    // loadView
    public override func loadView() {
        self.view = loginView
    }
    
    // viewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()
        kakaoLoginButtontapped()
        appleLoginButtonTapped()
        // 뒤로가기 버튼 아이템 커스텀(A에서 B로 화면전환일 경우 A가 아닌 B의 속성이 변경)
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    // 카카오 소셜 로그인 버튼 클릭 이벤트
    private func kakaoLoginButtontapped() {
        loginView.kakaoLoginButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.coordinator?.transitionToMainTabBarController() // 코디네이터에 화면전환 요청
            })
            .disposed(by: disposeBag)
    }
    
    // 애플 소셜 로그인 버튼 클릭 이벤트
    private func appleLoginButtonTapped() {
        loginView.appleLoginButton.rx
            .controlEvent(.touchUpInside)
            .withUnretained(self)
            .throttle(.microseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { owner, _ in
                owner.coordinator?.transitionToProfileSetupView() // 코디네이터에 화면전환 요청
            })
            .disposed(by: disposeBag)
    }
    
}
