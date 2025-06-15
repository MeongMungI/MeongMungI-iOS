//
//  MyPageView.swift
//  MeongMungI
//
//  Created by 7aeHoon on 3/22/25.
//

import UIKit
import Then
import SnapKit

// MARK: - 마이페이지 커스텀 뷰
public final class MyPageView: UIView {
    
    // 네비게이션 왼쪽 바 버튼 커스텀 레이블
    private let titleLabel = UILabel().then {
        $0.text = "마이"
        $0.numberOfLines = 1
        $0.font = UIFont.Moneygraphy(size: 25)
        $0.textColor = .black
    }
    
    // 네비게이션 왼쪽 바 버튼 아이템에 커스텀 레이블 적용
    public lazy var leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
    
    // MARK: - init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }
    
    // MARK: - required init
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setupUI
    private func setupUI() {
        self.backgroundColor = .backgroundColor
    }
    
    // MARK: - setupLayout
    private func setupLayout() {
        
    }
    
}
