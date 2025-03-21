//
//  MainTabBarCoordinator.swift
//  MeongMungI
//
//  Created by 7aeHoon on 3/21/25.
//

import UIKit

// MARK: - 메인 탭 바 코디네이터
public final class MainTabBarCoordinator: Coordinator {
    // 부모 코디네이터
    weak var parentCoordinator: Coordinator?
    
    // 자식 코디네이터
    var childCoordinators: [Coordinator] = []
    
    // 네비게이션 컨트롤러
    var navigationController: UINavigationController = UINavigationController()
    
    // 탭 바 컨트롤러
    var tabBarController: UITabBarController
    
    // init
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }
    
}

extension MainTabBarCoordinator {
    // 탭 바 코디네이터 시작
    public func start() {
        // 네비게이션 컨트롤러 생성
        let homeNVC = UINavigationController()
        let petPlaceNVC = UINavigationController()
        let strollNVC = UINavigationController()
        let communityNVC = UINavigationController()
        let myPageNVC = UINavigationController()
        
        // 탭 바 아이템 등록
        homeNVC.tabBarItem = UITabBarItem(title: "홈", image: .house, tag: 0)
        petPlaceNVC.tabBarItem = UITabBarItem(title: "지도", image: .petPlace, tag: 1)
        strollNVC.tabBarItem = UITabBarItem(title: "산책", image: .stroll, tag: 2)
        communityNVC.tabBarItem = UITabBarItem(title: "커뮤니티", image:.community, tag: 3)
        myPageNVC.tabBarItem = UITabBarItem(title: "마이", image: .myPage, tag: 4)
        
        // 탭 바 컨트롤러에 네비게이션 컨트롤러 등록
        tabBarController.viewControllers = [homeNVC, petPlaceNVC, strollNVC, communityNVC, myPageNVC]
        
        // 탭 바의 코디네이터 생성
        let homeCoordinator = HomeCoordinator(navigationController: homeNVC)
        let petPlaceCoordinator = PetPlaceCoordinator(navigationController: petPlaceNVC)
        let strollCoordinator = StrollCoordinator(navigationController: strollNVC)
        let communityCoordinator = CommunityCoordinator(navigationController: communityNVC)
        let myPageCoordinator = MyPageCoordinator(navigationController: myPageNVC)
        
        // 자식 코디네이터 등록
        childCoordinators.append(homeCoordinator)
        childCoordinators.append(petPlaceCoordinator)
        childCoordinators.append(strollCoordinator)
        childCoordinators.append(communityCoordinator)
        childCoordinators.append(myPageCoordinator)
        
        // 각 화면의 코디네이터 시작
        homeCoordinator.start()
        petPlaceCoordinator.start()
        strollCoordinator.start()
        communityCoordinator.start()
        myPageCoordinator.start()

    }
}
