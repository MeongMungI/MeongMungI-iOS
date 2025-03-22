//
//  MainTabBarController.swift
//  MeongMungI
//
//  Created by 7aeHoon on 3/18/25.
//

import UIKit

// MARK: - 앱의 메인 탭 바 컨트롤러
public final class MainTabBarController: UITabBarController {
    
    // viewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    // 탭바 초기 설정
    private func setupTabBar() {
        tabBar.clipsToBounds = true
        // 탭바의 배경색상 설정
        tabBar.backgroundColor = .white
        // 탭바 아이템을 선택했을 때 색상 설정
        tabBar.tintColor = UIColor.mainColor
        // 탭바 반투명 상태 여부 설정
        tabBar.isTranslucent = false
    }
    
}
