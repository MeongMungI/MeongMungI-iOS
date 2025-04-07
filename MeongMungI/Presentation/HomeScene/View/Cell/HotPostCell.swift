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
    // 셀 아이디
    static let ID = "HotPostCell"
    
    // 게시글 랭킹 순위
    private let rankingLabel = UILabel().then {
        $0.font = UIFont.pretendard(size: 20, family: .Bold)
        $0.numberOfLines = 1
        $0.textColor = .mainTextColor
        $0.clipsToBounds = true
    }
    private lazy var containerStackView = UIStackView(arrangedSubviews: [stackView, thumbnailImageView] ).then {
        $0.axis = .horizontal
        $0.spacing = 10
    }
    
    // 게시글 타입, 게시글 제목, 게시글 좋아요 및 댓글을 담고있는 스택 뷰
    private lazy var stackView = UIStackView(arrangedSubviews: [typeView, titleLabel, likeAndCommentLabel]).then {
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.alignment = .leading
    }
    
    // 게시글 타입 뷰 - 게시글 타입명 레이블을 담고 있는 뷰
    private let typeView = UIView().then {
        $0.backgroundColor = .postTypeBackgorundColor
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 3
    }
    
    // 게시글 타입명
    private let typeLabel = UILabel().then {
        $0.font = UIFont.pretendard(size: 11, family: .Medium)
        $0.numberOfLines = 1
        $0.textColor = .subTextColor
        $0.clipsToBounds = true
    }
    
    // 게시글 제목
    private let titleLabel = UILabel().then {
        $0.font = UIFont.pretendard(size: 15, family: .SemiBold)
        $0.numberOfLines = 1
        $0.textColor = .subTextColor
        $0.clipsToBounds = true
    }
    
    // 게시글 좋아요 및 댓글
    private let likeAndCommentLabel = UILabel().then {
        $0.font = UIFont.pretendard(size: 11, family: .Medium)
        $0.numberOfLines = 1
        $0.textColor = .subTextColor
        $0.clipsToBounds = true
    }
    
    // 게시글 대표 썸네일 이미지
    private let thumbnailImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
    }
    
    private let seperateView = UIView().then {
        $0.backgroundColor = .backgroundColor
    }
    
    // init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func prepareForReuse() {
        super.prepareForReuse()
        self.rankingLabel.text = nil
        self.typeLabel.text = nil
        self.titleLabel.text = nil
        self.likeAndCommentLabel.text = nil
        self.thumbnailImageView.image = nil
        self.thumbnailImageView.isHidden = true
    }
    
}

extension HotPostCell {
    // UI 설정
    private func setupUI() {
        [rankingLabel, containerStackView, seperateView].forEach {
            self.contentView.addSubview($0)
        }
    
        self.typeView.addSubview(typeLabel)
    }
    
    // Layout 설정
    private func setupLayout() {
        let defaultInset: CGFloat = 10
        let defaultOffset: CGFloat = 13
        
        rankingLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        rankingLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalTo(typeView)
        }
        
        containerStackView.snp.makeConstraints { make in
            make.leading.equalTo(rankingLabel.snp.trailing).offset(defaultOffset)
            make.top.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(defaultInset)
        }
        
        typeLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(4)
            make.top.bottom.equalToSuperview().inset(2)
        }
        
        seperateView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
        thumbnailImageView.snp.makeConstraints { make in
            make.width.equalTo(thumbnailImageView.snp.height)
        }

    }
    
    // 셀 configure
    public func configure(post: Post) {
        self.rankingLabel.text = "\(post.ranking)"
        self.typeLabel.text = post.type
        self.titleLabel.text = post.title
        self.likeAndCommentLabel.text = "좋아요 \(post.like)\t댓글 \(post.comment)"
        
        // 썸네일 이미지의 유무에 따른 썸네일 이미지 뷰 설정
        if let thumbnail = post.thumbnailImage {
            self.thumbnailImageView.image = thumbnail
            self.thumbnailImageView.isHidden = false
        } else {
            self.thumbnailImageView.image = nil
            self.thumbnailImageView.isHidden = true
        }
    }
    
}

