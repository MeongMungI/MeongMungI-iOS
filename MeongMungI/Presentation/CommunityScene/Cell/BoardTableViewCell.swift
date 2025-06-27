//
//  BoardTableViewCell.swift
//  MeongMungI
//
//  Created by 7aeHoon on 6/19/25.
//

import UIKit
import SnapKit
import Then

public final class BoardTableViewCell: UITableViewCell {
    
    static let ID = "BoardTableViewCell"
    static let bottomInset: CGFloat = 40
    
    private lazy var stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel]).then {
        $0.axis = .vertical
        $0.spacing = 5
        $0.distribution = .equalSpacing
        $0.alignment = .leading
    }
    
    public let titleLabel = UILabel().then {
        $0.font = .pretendard(size: 18, family: .medium)
        $0.textColor = .primaryTextColor
        $0.numberOfLines = 1
    }
    
    public let descriptionLabel = UILabel().then {
        $0.font = .pretendard(size: 14, family: .medium)
        $0.textColor = .tertiaryTextColor
        $0.numberOfLines = 1
    }
    
    private var bottomConstraint: Constraint?
    
    // MARK: - init
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupLayout()
    }
    
    // MARK: - required init
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - prepareForReuse
    public override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = ""
        self.descriptionLabel.text = ""
    }
    
    // MARK: - setupUI
    private func setupUI() {
        self.selectionStyle = .none
        self.contentView.addSubview(stackView)
    }
    
    // MARK: - setupLayout
    private func setupLayout() {
        stackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            bottomConstraint = make.bottom.equalToSuperview().inset(BoardTableViewCell.bottomInset).constraint
        }
    }
    
    // MARK: - configure
    public func configure(title titleText: String, desc descriptionText: String) {
        self.titleLabel.text = titleText
        self.descriptionLabel.text = descriptionText
    }

    // MARK: - setBottomSpacing
    public func setBottomSpacing(_ spacing: CGFloat) {
        bottomConstraint?.update(inset: spacing)
    }

}
