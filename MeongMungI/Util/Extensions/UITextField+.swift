//
//  UITextField+.swift
//  MeongMungI
//
//  Created by 7aeHoon on 4/30/25.
//

import UIKit

extension UITextField {
    // 텍스트 필드의 왼쪽에 간격주기
    func leftPadding(_ width: CGFloat = 20) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
    
    // 텍스트 필드의 오른쪽에 간격주기
    func rightPadding(_ width: CGFloat = 20) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.frame.height))
        rightView = paddingView
        rightViewMode = .always
    }
    
    // 양쪽에 패딩을 동시에 설정
    func horizontalPadding(left: CGFloat = 20, right: CGFloat = 20) {
        leftPadding(left)
        rightPadding(right)
    }
    

}
