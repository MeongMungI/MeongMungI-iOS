//
//  CommunityView.swift
//  MeongMungI
//
//  Created by 7aeHoon on 3/22/25.
//

import UIKit
import Then
import SnapKit

/// 커뮤니티 커스텀 뷰
public final class CommunityView: UIView {
    
    /// 네비게이션 왼쪽 바 버튼 커스텀 레이블
    public let titleLabel = UILabel().then {
        $0.text = "커뮤니티"
        $0.numberOfLines = 1
        $0.font = UIFont.Moneygraphy(size: 25)
        $0.textColor = .black
    }
    
    /// 게시글 작성 플로팅 버튼
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
    
    /// 게시글 서치 버튼
    public let searchButton = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "search"), for: .normal)
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .black
    }
    
    // MARK: - init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupUI()
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View
    
    private func addSubviews() {
        self.addSubview(floatingButton)
    }
    
    private func setupUI() {
        self.backgroundColor = .white
    }
    
    // MARK: - Layout
    
    private func setupLayout() {
        floatingButton.snp.makeConstraints { make in
            make.width.height.equalTo(60)
            make.trailing.bottom.equalTo(safeAreaLayoutGuide).inset(20)
        }
        
        searchButton.snp.makeConstraints { make in
            make.size.equalTo(21)
        }
    }
}
