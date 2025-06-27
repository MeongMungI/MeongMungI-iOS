//
//  PhotoCollectionViewCell.swift
//  MeongMungI
//
//  Created by 7aeHoon on 6/20/25.
//

import UIKit
import SnapKit
import Then

// MARK: - 사용자의 사진첩에서 선택된 사진을 보여주기 위한 셀
public final class PhotoCollectionViewCell: UICollectionViewCell {
    static let ID = "PhotoCollectionViewCell"
    
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 17
        $0.clipsToBounds = true
    }
    
    // 사진 삭제 버튼
    private let removeButton = UIButton(type: .custom).then {
        let iconImage = UIImage(named: "xMark")?.withRenderingMode(.alwaysTemplate)
        $0.setImage(iconImage, for: .normal)
        $0.tintColor = .primaryTextColor
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 11
        $0.clipsToBounds = true
        $0.adjustsImageWhenHighlighted = false
    }
    
    // 삭제 버튼 터치 이벤트 클로저
    public var onRemove: (() -> Void)?
    
    // MARK: - init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
        removeButton.addTarget(self, action: #selector(didTappedRemoveButton), for: .touchUpInside)
    }
    
    // MARK: - required init
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - prepareForReuse
    public override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    // MARK: - setupUI
    private func setupUI() {
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(removeButton)
    }
    
    // MARK: - setupLayout
    private func setupLayout() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        removeButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(5)
            make.size.equalTo(22)
        }
    }
    
    // MARK: - configure
    public func configure(with photo: Photo) {
        imageView.image = photo.image
    }
    
    // MARK: - didTappedRemoveButton
    @objc
    private func didTappedRemoveButton() {
        onRemove?()
    }
    
}

// MARK: - 사진 구조체
public struct Photo: Hashable {
    let id = UUID()
    let image: UIImage
}
