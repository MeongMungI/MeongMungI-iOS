//
//  BoardSelectionView.swift
//  MeongMungI
//
//  Created by 7aeHoon on 6/19/25.
//

import UIKit
import SnapKit
import Then

// MARK: - 사용자가 커뮤니티의 게시판 유형을 선택하기 위한 뷰
public final class BoardSelectionView: UIView {
    
    // 타이틀 레이블
    private let titleLabel = UILabel().then {
        $0.text = "게시판 선택"
        $0.numberOfLines = 1
        $0.font = .pretendard(size: 18, family: .semiBold)
        $0.textColor = .primaryTextColor
    }
    
    // 게시판 선택 테이블 뷰
    public let boardTableView = UITableView(frame: .zero, style: .plain).then {
        $0.register(BoardTableViewCell.self, forCellReuseIdentifier: BoardTableViewCell.ID)
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 80
        $0.separatorStyle = .none
    }
   
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
        self.addSubview(titleLabel)
        self.addSubview(boardTableView)
    }
    
    // MARK: - setupUI
    private func setupUI() {
        self.backgroundColor = .white
    }
    
    // MARK: - setupLayout
    private func setupLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
        }
        
        boardTableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
    }
}
