//
//  UIFont+.swift
//  MeongMungI
//
//  Created by 7aeHoon on 3/22/25.
//

import UIKit

// MARK: - UIFont의 확장
extension UIFont {
    // 프리텐다드 폰트
    enum PretendardFamily: String {
        case regular = "Regular"
        case medium = "Medium"
        case semiBold = "SemiBold"
        case bold = "Bold"
    }

    // 프리텐다드 폰트
    static func pretendard(size: CGFloat = 10, family: PretendardFamily = .medium) -> UIFont {
        return UIFont(name: "Pretendard-\(family.rawValue)", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    // 머니그라피 폰트
    static func Moneygraphy(size: CGFloat) -> UIFont {
        return UIFont(name: "Moneygraphy-Rounded", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
}
