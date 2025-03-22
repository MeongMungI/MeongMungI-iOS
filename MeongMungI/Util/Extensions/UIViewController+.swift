//
//  UIViewController.swift
//  MeongMungI
//
//  Created by 7aeHoon on 3/22/25.
//

import UIKit

// MARK: - UIViewController의 확장
extension UIViewController {
    // 네비게이션 왼쪽 바 버튼 아이템 설정
    public func configureLeftNavigationBarItem(with item: UIBarButtonItem?) {
        self.navigationItem.leftBarButtonItem = item
    }
}
