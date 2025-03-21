//
//  UIFont+.swift
//  MeongMungI
//
//  Created by 7aeHoon on 3/22/25.
//

import UIKit

// MARK: - UIFont의 확장
extension UIFont {
    // 지마켓 산스 폰트 사이즈
    enum GmarketSansFamily: String {
        case Light
        case Medium
        case Bold
    }
    
    // 프리텐다드 폰트 사이즈
    enum PretendardFamily: String {
        case Regular
        case Medium
        case SemiBold
        case Bold
    }
    
    // 지마켓 산스 폰트 커스텀
    static func gmarketSans(size: CGFloat = 10, family: GmarketSansFamily = .Medium) -> UIFont {
        return UIFont(name: "GmarketSans\(family)", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    // 프리텐다드 폰트 커스텀
    static func pretendard(size: CGFloat = 10, family: PretendardFamily = .Medium) -> UIFont {
        return UIFont(name: "Pretendard-\(family)", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
