//
//  PostListTableViewCell.swift
//  MeongMungI
//
//  Created by 7aeHoon on 7/1/25.
//

import UIKit
import SnapKit
import Then

// MARK: - 게시글 목록에 적용할 테이블 뷰 셀
public final class PostListTableViewCell: UITableViewCell {
    // 셀 아이디
    static let ID = "PostListTableViewCell"
    
    // 게시글 타입 컨테이너 뷰
    private let boardTypeContainerView = UIView().then {
        $0.backgroundColor = .backgroundColor
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 3
    }
    
    // 게시글 타입명
    private let boardTypeLabel = UILabel().then {
        $0.font = .pretendard(size: 12, family: .semiBold)
        $0.numberOfLines = 1
        $0.textColor = .secondaryTextColor
        $0.clipsToBounds = true
    }
    
    // 게시글 제목
    private let titleLabel = UILabel().then {
        $0.font = .pretendard(size: 16, family: .medium)
        $0.numberOfLines = 1
        $0.textColor = .primaryTextColor
        $0.clipsToBounds = true
    }
    
    // 게시글 내용
    private let contentLabel = UILabel().then {
        $0.font = .pretendard(size: 14, family: .medium)
        $0.numberOfLines = 1
        $0.textColor = .secondaryTextColor
        $0.clipsToBounds = true
    }
    
    // 썸네일 이미지
    private let thumbnailImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
    }
    
    // 작성자 + 작성 시간
    private let authorAndCreatedTimeLabel = UILabel().then {
        $0.font = .pretendard(size: 12, family: .regular)
        $0.numberOfLines = 1
        $0.textColor = .secondaryTextColor
        $0.clipsToBounds = true
    }
    
    // 좋아요 이미지
    private let likeImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "heart")!.withRenderingMode(.alwaysTemplate)
        $0.tintColor = .secondaryTextColor
        $0.clipsToBounds = true
    }
    
    // 좋아요 레이블
    private let likeLabel = UILabel().then {
        $0.text = "10"
        $0.font = .pretendard(size: 12, family: .regular)
        $0.numberOfLines = 1
        $0.textColor = .secondaryTextColor
        $0.clipsToBounds = true
    }
    
    // 댓글 이미지
    private let commentImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "message")!.withRenderingMode(.alwaysTemplate)
        $0.tintColor = .secondaryTextColor
        $0.clipsToBounds = true
    }
    
    // 댓글 레이블
    private let commentLabel = UILabel().then {
        $0.text = "5"
        $0.font = .pretendard(size: 12, family: .regular)
        $0.numberOfLines = 1
        $0.textColor = .secondaryTextColor
        $0.clipsToBounds = true
    }
    
    private lazy var likeStackView = UIStackView(arrangedSubviews: [likeImageView, likeLabel]).then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 5
    }
    
    private lazy var commentStackView = UIStackView(arrangedSubviews: [commentImageView, commentLabel]).then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 5
    }
    
    private lazy var likeAndCommentStackView = UIStackView(arrangedSubviews: [likeStackView, commentStackView]).then {
        $0.axis = .horizontal
        $0.spacing = 10
    }
    
    private lazy var containerStackView = UIStackView(arrangedSubviews: [rowStackView, metaStackView]).then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.spacing = 15
    }
    
    private lazy var rowStackView = UIStackView(arrangedSubviews: [bodyStackView, thumbnailImageView]).then {
          $0.axis = .horizontal
          $0.alignment = .top
          $0.spacing = 10
      }
    
    private lazy var metaStackView = UIStackView(arrangedSubviews: [authorAndCreatedTimeLabel, likeAndCommentStackView]).then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .equalSpacing
    }
    
    private lazy var bodyStackView = UIStackView(arrangedSubviews: [boardTypeContainerView, titleLabel, contentLabel]).then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = 6
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
        boardTypeLabel.text = nil
        titleLabel.text = nil
        contentLabel.text = nil
        authorAndCreatedTimeLabel.text = nil
        thumbnailImageView.image = nil
    }
    
    // MARK: - setupUI
    private func setupUI() {
        self.selectionStyle = .none
        self.contentView.addSubview(containerStackView)
        boardTypeContainerView.addSubview(boardTypeLabel)
    }
    
    // MARK: - setupLayout
    private func setupLayout() {
        containerStackView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(12)
            make.leading.equalTo(contentView).offset(20)
            make.trailing.equalTo(contentView).inset(20)
            make.bottom.equalTo(contentView).inset(12)
        }
        
        boardTypeLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(6)
            make.top.bottom.equalToSuperview().inset(4)
        }
        
        thumbnailImageView.snp.makeConstraints { make in
            make.size.equalTo(75)
        }
        
        likeImageView.snp.makeConstraints { make in
            make.size.equalTo(14)
        }
        
        commentImageView.snp.makeConstraints { make in
            make.size.equalTo(14)
        }
    }
    
    // MARK: - configure
    public func configure(with post: Post) {
        boardTypeLabel.text = post.boardType.rawValue
        titleLabel.text = post.title
        contentLabel.text = post.content
        likeLabel.text = post.likesCount.description
        commentLabel.text = post.commentsCount.description
        authorAndCreatedTimeLabel.text = "\(post.authorNickName) • \(post.createdAt.relativeString())"
        
        if post.likesCount == 0 { likeStackView.isHidden = true }
        if post.commentsCount == 0 { commentStackView.isHidden = true }
        
        if let image = post.imageURLs.first {
            thumbnailImageView.image = UIImage(named: image)
        } else {
            thumbnailImageView.isHidden = true
        }
    }
    
}
