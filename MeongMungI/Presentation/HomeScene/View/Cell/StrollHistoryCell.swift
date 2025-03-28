//
//  StrollHistoryCell.swift
//  MeongMungI
//
//  Created by 7aeHoon on 3/22/25.
//

import UIKit
import SnapKit
import Then

// MARK: - 지난 산책기록 커스텀 셀
public final class StrollHistoryCell: UICollectionViewCell {
    // 셀 아이디
    static let ID = "StrollHistoryCell"
    
    private var id: Int = 0
    
    // 셀의 배경 이미지는 산책 기록에 저장된 메인 이미지로
    private let backgroundImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = 15
    }
    
    // init
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

extension StrollHistoryCell {
    // UI 설정
    private func setupUI() {
        self.contentView.addSubview(backgroundImageView)
    }
    
    // Layout 설정
    private func setupLayout() {
        // 백그라운드 이미지의 레이아웃 설정
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    // 셀 configure
    public func configure(id: Int, image: UIImage) {
        self.id = id
        self.backgroundImageView.image = image
    }
}
