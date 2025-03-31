//
//  DogProfileCell.swift
//  MeongMungI
//
//  Created by 7aeHoon on 3/25/25.
//

import UIKit
import SnapKit
import Then

// MARK: - 반려동물 프로필 셀
public final class PetProfileCell: UICollectionViewCell {
    // 셀 아이디
    static let ID = "PetProfileCell"
    
    private lazy var stackView = UIStackView(arrangedSubviews: [shadowView, nameLabel]).then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.alignment = .center
        $0.distribution = .fillProportionally
    }
    
    // 반려동물 프로필 이미지 뷰
    private let mainImageView = UIImageView().then {
        $0.image = .cat5
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 0
    }
    
    private let shadowView = UIView().then {
        $0.layer.cornerRadius = 45
        $0.layer.shadowOpacity = 0.9    
        $0.layer.shadowRadius = 3
        $0.layer.shadowColor = UIColor.gray.cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    
    // 이름 레이블
    private let nameLabel = UILabel().then {
        $0.text = "멍뭉이"
        $0.numberOfLines = 1
        $0.font = UIFont.pretendard(size: 13, family: .Medium)
        $0.textColor = .mainTextColor
        $0.textAlignment = .center
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
    
    public override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // UI 설정
    private func setupUI() {
        //self.backgroundColor = .backgroundColor
        [stackView].forEach {
            self.contentView.addSubview($0)
        }
        shadowView.addSubview(mainImageView)
    }
    
    // Layout 설정
    private func setupLayout() {
        stackView.snp.makeConstraints { make in
            make.edges.centerY.centerX.equalToSuperview()
        }
        
        shadowView.snp.makeConstraints { make in
            make.height.width.equalTo(90)
        }
        
        mainImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    // 셀 configure
    public func configure(pet: Pet) {
        self.mainImageView.image = pet.image
        self.mainImageView.layer.cornerRadius = 45
        self.nameLabel.text = pet.name
    }
}

