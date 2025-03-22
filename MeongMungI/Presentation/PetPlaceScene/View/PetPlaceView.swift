//
//  PetPlaceView.swift
//  MeongMungI
//
//  Created by 7aeHoon on 3/22/25.
//

import UIKit
import Then
import SnapKit

// MARK: - 반려동물 동반 지도 커스텀 뷰
public final class PetPlaceView: UIView {
    
    // 네비게이션 왼쪽 바 버튼 커스텀 레이블
    private let titleLabel = UILabel().then {
        $0.text = "지도"
        $0.numberOfLines = 1
        $0.font = UIFont.Moneygraphy(size: 25)
        $0.textColor = .black
    }
    
    // 네비게이션 왼쪽 바 버튼 아이템에 커스텀 레이블 적용
    public lazy var leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
    
    // init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupUI()
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PetPlaceView {
    // 하위 뷰 설정
    private func setupViews() {
    }
    
    // 초기 UI 설정
    private func setupUI() {
        self.backgroundColor = .backgroundColor
    }
    
    // 초기 Layout 설정
    private func setupLayout() {
    }
}

