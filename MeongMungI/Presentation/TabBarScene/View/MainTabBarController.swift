//
//  MainTabBarController.swift
//  MeongMungI
//
//  Created by 7aeHoon on 3/18/25.
//

import UIKit

// MARK: - 앱의 메인 탭 바 컨트롤러
public final class MainTabBarController: UITabBarController {
    
    // MARK: - Life-cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupViewControllers()
        addTopStripe(color: .backgroundColor, height: 0.5)   // 상단 라인(원하면 색·두께 조절)
    }
    
    // MARK: - 탭바 기본 설정
    private func setupTabBar() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.shadowColor = nil
        tabBar.standardAppearance   = appearance
        tabBar.scrollEdgeAppearance = appearance
        tabBar.tintColor            = .primaryTextColor
        tabBar.isTranslucent        = false
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
    
    // MARK: - 탭바 상단 스트라이프(라인) 추가
    private func addTopStripe(color: UIColor, height: CGFloat) {
        let stripe = UIView()
        stripe.backgroundColor = color
        stripe.translatesAutoresizingMaskIntoConstraints = false
        tabBar.addSubview(stripe)
        
        NSLayoutConstraint.activate([
            stripe.topAnchor.constraint(equalTo: tabBar.topAnchor),
            stripe.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
            stripe.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor),
            stripe.heightAnchor.constraint(equalToConstant: height)
        ])
    }
}
