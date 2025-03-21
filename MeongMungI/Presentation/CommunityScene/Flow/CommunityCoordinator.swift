//
//  CommunityCoordinator.swift
//  MeongMungI
//
//  Created by 7aeHoon on 3/21/25.
//

import UIKit

// MARK: - 커뮤니티 화면을 관리하는 코디네이터
public final class CommunityCoordinator: Coordinator {
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
        let communityVC = CommunityViewController()
        
        // 홈 뷰 컨트롤러를 관리하는 코디네이터로 자신을 설정
        communityVC.coordinator = self
        
        navigationController.setViewControllers([communityVC], animated: false)
    }


}
