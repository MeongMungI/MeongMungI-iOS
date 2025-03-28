//
//  UICollectionViewCell.swift
//  MeongMungI
//
//  Created by 7aeHoon on 3/23/25.
//

import UIKit

// MARK: - 컬렉션 뷰 셀 확장
extension UICollectionViewCell {
    // 그림자 효과 추가
    public func addShadow(offset: CGSize, opacity: Float, radius: CGFloat, color: CGColor) {
        /// 얼마만큼 그림자를 옮길지(points 기준)
        self.layer.shadowOffset = offset
        /// 그림자 투명도
        self.layer.shadowOpacity = opacity
        /// 그림자 모서리 둥글게
        self.layer.shadowRadius = radius
        /// 그림자 색상
        self.layer.shadowColor = color
    }
}
