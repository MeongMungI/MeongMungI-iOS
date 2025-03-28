//
//  HotPostCell.swift
//  MeongMungI
//
//  Created by 7aeHoon on 3/23/25.
//

import UIKit
import SnapKit
import Then

// MARK: - 실시간 인기글 커스텀 셀
public final class HotPostCell: UICollectionViewCell {
    /// 셀 아이디
    static let ID = "HotPostCell"
    
    /// 포스트 메인 이미지 뷰
    private let mainImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 15
    }
    
    /// 포스트 제목 레이블
    private let titleLabel = UILabel().then {
        $0.text = ""
        
    }
    
    /// 포스트 타입 레이블
    private let typeLabel = UILabel().then {
        $0.text = ""
        
    }
    
    /// 좋아요와 댓글 레이블
    private let likeAndCommentLabel = UILabel().then {
        $0.text = "좋아요 12 댓글 7"
        $0.font = UIFont.pretendard(size: 14, family: .Medium)
        $0.textColor = .mainTextColor
    }
    
    
    /// init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
        addShadow(offset: CGSize(width: 5, height: 5), opacity: 0.7, radius: 5, color: UIColor.gray.cgColor)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HotPostCell {
    // UI 설정
    private func setupUI() {
        self.contentView.addSubview(mainImageView)
    }
    
    // Layout 설정
    private func setupLayout() {
        // 백그라운드 이미지의 레이아웃 설정
        mainImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    // 셀 configure
    public func configure() {
        
    }
    
}

