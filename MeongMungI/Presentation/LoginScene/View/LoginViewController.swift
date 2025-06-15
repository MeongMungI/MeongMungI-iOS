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
    
    private let disposeBag = DisposeBag()
    
    // MARK: - loadView
    public override func loadView() {
        self.view = loginView
    }
    
    // MARK: - viewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupNavi()
        kakaoLoginButtontapped()
        appleLoginButtonTapped()
    }
    
    // MARK: - 네비게이션 설정
    private func setupNavi() {
        // 뒤로가기 버튼 아이템 커스텀(A에서 B로 화면전환일 경우 A가 아닌 B의 속성이 변경)
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    // MARK: - 카카오 소셜 로그인 버튼 클릭 이벤트
    private func kakaoLoginButtontapped() {
        loginView.kakaoLoginButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                if let scene = owner.view.window?.windowScene,
                   let sceneDelegate = scene.delegate as? SceneDelegate {
                    sceneDelegate.transitionToMainTabBarController()
                }
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - 애플 소셜 로그인 버튼 클릭 이벤트
    private func appleLoginButtonTapped() {
        loginView.appleLoginButton.rx
            .controlEvent(.touchUpInside)
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                let petProfileBasicInputVC = PetProfileBasicInputViewController()
                owner.navigationController?.pushViewController(petProfileBasicInputVC, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
}
