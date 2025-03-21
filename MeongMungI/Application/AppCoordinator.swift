//
//  AppCoordinator.swift
//  MeongMungI
//
//  Created by 7aeHoon on 3/18/25.
//

import UIKit

// MARK: - 코디네이터 프로토콜
protocol Coordinator: AnyObject {
    // 자식 코디네이터
    var childCoordinators: [Coordinator] { get set }
    
    // 네비게이션 컨트롤러
    var navigationController: UINavigationController { get set }
    
    // 초기 메서드
    func start()
}

// MARK: - 최상위에 존재하는 AppCoordinator
public final class AppCoordinator: NSObject, Coordinator {
    // 자식 코디네이터
    var childCoordinators: [Coordinator] = []
    // 시작 뷰 컨트롤러
    private var rootViewController = LoginViewController()
    // 네비게이션 컨트롤러
    public var navigationController: UINavigationController
    // 윈도우
    public let window: UIWindow
    
    // init
    init(window: UIWindow) {
        // 씬 델리게이트에서 전달된 윈도우 객체
        self.window = window
        self.navigationController = UINavigationController()
    }
}

extension AppCoordinator {
    // 앱 코디네이터 시작
    public func start() {
        // 루트 뷰 컨트롤러인 로그인 뷰 컨트롤러의 코디네이터로 자신을 설정
        rootViewController.coordinator = self
        // 라이트 모드만 허용
        window.overrideUserInterfaceStyle = .light
        // 루트 뷰 교체
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
    
    // 탭 바로 화면 전환
    public func transitionToMainTabBarController() {
        let mainTabBarController = MainTabBarController()
        // 탭바 코디네이터 생성
        let tabBarCoordinator = MainTabBarCoordinator(tabBarController: mainTabBarController)
        // 탭 바 코디네이터를 자식 코디네이터로 등록
        childCoordinators.append(tabBarCoordinator)
        // 탭 바 코디네이터의 부모 코디네이터는 앱 코디네이터
        tabBarCoordinator.parentCoordinator = self
        // 탭 바 코디네이터 시작
        tabBarCoordinator.start()
        // 루트 뷰 교체
        window.rootViewController = mainTabBarController
        // 루트 뷰 컨트롤러 전환 시 애니메이션 적용
        UIView.transition(with: window, duration: 0.2, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}
