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
    
    // 제스처에 탭을 등록하고, 탭 이벤트가 발생할 경우 키보드 내리기
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}

extension UIViewController: UIGestureRecognizerDelegate {
    // 탭 제스처가 UIControl 위의 터치를 가로채지 않도록 하기
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        // 만약 터치된 뷰가 UIButton, UISlider, UISwitch, UITextField 등 UIControl 계열이면 false
        if touch.view is UIControl {
            // 제스처를 무시
            return false
        }
        return true
    }
}
