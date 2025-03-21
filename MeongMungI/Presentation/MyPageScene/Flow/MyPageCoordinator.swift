//
//  MyPageCoordinator.swift
//  MeongMungI
//
//  Created by 7aeHoon on 3/21/25.
//

import UIKit

// MARK: - 마이페이지 화면을 관리하는 코디네이터
public final class MyPageCoordinator: Coordinator {
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
    
    // 코디네이터 시작
    func start() {
        let myPageVC = MyPageViewController()
        
        // 마이페이지 뷰 컨트롤러를 관리하는 코디네이터로 자신을 설정
        myPageVC.coordinator = self
        
        navigationController.setViewControllers([myPageVC], animated: false)
    }


}
