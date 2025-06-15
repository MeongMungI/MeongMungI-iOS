//
//  MainTabBarController.swift
//  MeongMungI
//
//  Created by 7aeHoon on 3/18/25.
//

import UIKit

// MARK: - 앱의 메인 탭 바 컨트롤러
public final class MainTabBarController: UITabBarController {
    
    // MARK: - viewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupViewControllers()
    }
    
    // MARK: - 탭바 초기 설정
    private func setupTabBar() {
        tabBar.clipsToBounds = true
        // 탭바의 배경색상 설정
        tabBar.backgroundColor = .white
        // 탭바 아이템을 선택했을 때 색상 설정
        tabBar.tintColor = .primaryTextColor
        // 탭바 반투명 상태 여부 설정
        tabBar.isTranslucent = false
    }
    
    // MARK: - 탭 바 컨트롤러에 적용할 뷰 컨트롤러 설정
    private func setupViewControllers() {
        // 홈 네비게이션 컨트롤러
        let homeViewController = HomeViewController()
        let homeNVC = UINavigationController(rootViewController: homeViewController)
        homeNVC.configureBarAppearnace()
        
        // 반려견 동반 장소 네비게이션 컨트롤러
        let petPlaceViewController = PetPlaceViewController()
        let petPlaceNVC = UINavigationController(rootViewController: petPlaceViewController)
        petPlaceNVC.configureBarAppearnace()
        
        // 산책 네비게이션 컨트롤러
        let strollViewController = StrollViewController()
        let strollNVC = UINavigationController(rootViewController: strollViewController)
        strollNVC.configureBarAppearnace()
        
        // 커뮤니티 네비게이션 컨트롤러
        let communityTabmanViewController = CommunityTabmanViewController()
        let communityNVC = UINavigationController(rootViewController: communityTabmanViewController)
        communityNVC.configureBarAppearnace()
        
        // 마이 페이지 네비게이션 컨트롤러
        let myPageViewController = MyPageViewController()
        let myPageNVC = UINavigationController(rootViewController: myPageViewController)
        myPageNVC.configureBarAppearnace()
        
        // 탭 바 아이템 등록
        homeNVC.tabBarItem = UITabBarItem(title: "홈", image: .house, tag: 0)
        petPlaceNVC.tabBarItem = UITabBarItem(title: "지도", image: .petPlace, tag: 1)
        strollNVC.tabBarItem = UITabBarItem(title: "산책", image: .stroll, tag: 2)
        communityNVC.tabBarItem = UITabBarItem(title: "커뮤니티", image:.community, tag: 3)
        myPageNVC.tabBarItem = UITabBarItem(title: "마이", image: .myPage, tag: 4)
        
        // 메인 탭 바 컨트롤러에 각 네비게이션 컨트롤러를 등록
        self.viewControllers = [homeNVC, petPlaceNVC, strollNVC, communityNVC, myPageNVC]
    }
    
}
