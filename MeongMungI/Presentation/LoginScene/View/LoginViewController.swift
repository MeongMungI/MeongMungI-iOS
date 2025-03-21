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
    }
    
    // 카카오 로그인 버튼 클릭
    private func kakaoLoginButtontapped() {
        loginView.kakaoLoginButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.coordinator?.transitionToMainTabBarController()
            })
            .disposed(by: disposeBag)
    }
    
    

}
