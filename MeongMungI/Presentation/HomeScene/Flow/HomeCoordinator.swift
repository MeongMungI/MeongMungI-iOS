//
//  HomeVIewCoordinator.swift
//  MeongMungI
//
//  Created by 7aeHoon on 3/21/25.
//

import UIKit

// MARK: - 홈 화면을 관리하는 코디네이터
public final class HomeCoordinator: NSObject, Coordinator {
    // 부모 코디네이터
    weak var parentCoordinator: Coordinator?
    
    // 자식 코디네이터
    var childCoordinators: [Coordinator] = []
    
    // 네비게이션 컨트롤러
    var navigationController: UINavigationController
    
    // init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

}

extension HomeCoordinator {
    // 코디네이터 시작
    public func start() {
        let homeVC = HomeViewController()
        // 홈 뷰 컨트롤러를 관리하는 코디네이터로 자신을 설정
        homeVC.coordinator = self
        navigationController.setViewControllers([homeVC], animated: false)
    }
}
