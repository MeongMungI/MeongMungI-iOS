//
//  CommunityView.swift
//  MeongMungI
//
//  Created by 7aeHoon on 3/22/25.
//

import UIKit
import Then
import SnapKit

// MARK: - 커뮤니티 커스텀 뷰
public final class CommunityView: UIView {
    
    // 네비게이션 왼쪽 바 버튼 커스텀 레이블
    private let titleLabel = UILabel().then {
        $0.text = "커뮤니티"
        $0.numberOfLines = 1
        $0.font = UIFont.Moneygraphy(size: 25)
        $0.textColor = .black
    }
    
    // 플로팅 버튼
    public let floatingButton = UIButton(type: .custom).then {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 23, weight: .medium)
        $0.setImage(UIImage(systemName: "plus", withConfiguration: imageConfig), for: .normal)
        $0.backgroundColor = .mainColor
        $0.tintColor = .white
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.3
        $0.layer.shadowOffset = CGSize(width: 0, height: 3)
        $0.layer.shadowRadius = 6
        $0.layer.cornerRadius = 30
        $0.adjustsImageWhenHighlighted = false
    }
    
    // 네비게이션 왼쪽 바 버튼 아이템에 커스텀 레이블 적용
    public lazy var leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
    
    // MARK: - init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupUI()
        setupLayout()
    }
    
    // MARK: - required init
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - addSubviews
    private func addSubviews() {
        self.addSubview(floatingButton)
    }
    
    
    // MARK: - setupUI
    private func setupUI() {
        self.backgroundColor = .backgroundColor
    }
    
    // MARK: - setupLayout
    private func setupLayout() {
        floatingButton.snp.makeConstraints { make in
            make.width.height.equalTo(60)
            make.trailing.bottom.equalTo(safeAreaLayoutGuide).inset(20)
        }
    }
    
    
    
}
