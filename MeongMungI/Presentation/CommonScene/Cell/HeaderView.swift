//
//  HeaderView.swift
//  MeongMungI
//
//  Created by 7aeHoon on 3/23/25.
//

import UIKit
import Then
import SnapKit

// MARK: - 컬렉션 뷰의 섹션 헤더 뷰
public final class HeaderView: UICollectionReusableView {
    // 아이디
    static let ID = "HeaderView"
    
    private lazy var stackView = UIStackView(arrangedSubviews: [titleLabel, viewAllButton]).then {
        $0.axis = .horizontal
        $0.spacing = 20
        $0.alignment = .fill
        $0.distribution = .fill
    }
    
    // 타이틀 레이블
    private let titleLabel = UILabel().then {
        $0.font = UIFont.pretendard(size: 18, family: .SemiBold)
        $0.textColor = .mainTextColor
        $0.textAlignment = .left
        $0.numberOfLines = 1
    }
    
    // 전체보기 버튼
    private let viewAllButton = UIButton(type: .system).then {
        $0.setTitle("전체보기", for: .normal)
        $0.titleLabel?.font = UIFont.pretendard(size: 13, family: .Medium)
        $0.setTitleColor(.mainTextColor, for: .normal)
        $0.isHidden = false
        $0.isHighlighted = false
    }
    
    // init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
        setPriority()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // prepareForReuse
    public override func prepareForReuse() {
        super.prepareForReuse()
        configure(title: "")
    }
}

extension HeaderView {
    // UI 설정
    private func setupUI() {
        self.addSubview(stackView)
    }
    
    // Layout 설정
    private func setupLayout() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    // Priority 설정
    private func setPriority() {
        // 레이블은 가능한 공간을 차지하도록 우선순위 설정
        titleLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        titleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        // 버튼은 자신의 크기를 유지하도록 우선순위 설정
        viewAllButton.setContentHuggingPriority(.required, for: .horizontal)
        viewAllButton.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    // Configure
    public func configure(title: String) {
        self.titleLabel.text = title
    }
}

