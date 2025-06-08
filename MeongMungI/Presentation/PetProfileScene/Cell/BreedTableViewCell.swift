//
//  BreedTableViewCell.swift
//  MeongMungI
//
//  Created by 7aeHoon on 6/8/25.
//

import UIKit
import SnapKit
import Then

public final class BreedTableViewCell: UITableViewCell {
    
    static let ID = "BreedTableViewCell"
    
    public let breedTitleLabel = UILabel().then {
        $0.font = .pretendard(size: 16, family: .medium)
        $0.textColor = .secondaryTextColor
        $0.numberOfLines = 1
    }
    
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
        self.breedTitleLabel.text = ""
    }
    
    // MARK: - layoutSubviews
    public override func layoutSubviews() {
      super.layoutSubviews()
      contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25))
    }
    
    // MARK: - setupUI
    private func setupUI() {
        self.selectionStyle = .none
        self.contentView.addSubview(breedTitleLabel)
    }
    
    // MARK: - setupLayout
    private func setupLayout() {
        breedTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(25)
        }
    }
    
    // MARK: - configure
    public func configure(with text: String) {
        self.breedTitleLabel.text = text
    }


}
