//
//  PostListView.swift
//  MeongMungI
//
//  Created by 7aeHoon on 7/1/25.
//

import UIKit

import SnapKit
import Then

// MARK: - 사용자에게 커뮤니티에 작성된 게시글을 보여주기 위한 뷰
public final class PostListView: UIView {
    public let tableView = UITableView(frame: .zero, style: .plain).then {
        $0.register(PostListTableViewCell.self, forCellReuseIdentifier: PostListTableViewCell.ID)
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 80
        $0.separatorStyle = .singleLine
        $0.separatorInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        $0.backgroundColor = .white
    }
    
    // MARK: - init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        setupUI()
        setupLayout()
    }
    
    // MARK: - required init
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - addSubViews
    private func addSubViews() {
        self.addSubview(tableView)
    }
    
    // MARK: - setupUI
    private func setupUI() {
        self.backgroundColor = .white
    }
    
    // MARK: - setupLayout
    private func setupLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
}
