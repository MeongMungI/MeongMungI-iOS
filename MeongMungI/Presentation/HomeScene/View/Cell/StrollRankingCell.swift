//
//  StrollRankingCell.swift
//  MeongMungI
//
//  Created by 7aeHoon on 4/9/25.
//

import UIKit
import SnapKit
import Then

// MARK: - 산책 랭킹 커스텀 셀
public final class StrollRankingCell: UICollectionViewCell {
    // 셀 아이디
    static let ID = "StrollRankingCell"
    
    // 산책 랭킹 정보
    private let rankingLabel = UILabel().then {
        $0.font = UIFont.pretendard(size: 14, family: .Bold)
        $0.numberOfLines = 1
        $0.textColor = .mainTextColor
        $0.clipsToBounds = true
    }
    
    // 반려동물 이미지
    private let thumbnailImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
    }
    
    // 반려동물의 이름과 견종을 포함하는 스택 뷰
    private lazy var petNameBreedStackView = UIStackView(arrangedSubviews: [petNameLabel, petBreedLabel]).then {
        $0.axis = .vertical
        $0.spacing = 7
        $0.alignment = .fill
    }
    
    // 반려동물 이름
    private let petNameLabel = UILabel().then {
        $0.font = UIFont.pretendard(size: 15, family: .SemiBold)
        $0.numberOfLines = 1
        $0.textColor = .mainTextColor
        $0.clipsToBounds = true
    }
    
    // 반려동물 종류(견종)
    private let petBreedLabel = UILabel().then {
        $0.font = UIFont.pretendard(size: 11, family: .Medium)
        $0.numberOfLines = 1
        $0.textColor = .subTextColor
        $0.clipsToBounds = true
    }
    
    // 총 산책 거리
    private let totalStrollDistanceLabel = UILabel().then {
        $0.font = UIFont.pretendard(size: 17, family: .SemiBold)
        $0.numberOfLines = 1
        $0.textColor = .mainTextColor
        $0.clipsToBounds = true
    }
    
    // 구분선
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
    
    override public func layoutSubviews() {
        self.contentView.layoutIfNeeded()
        thumbnailImageView.layer.cornerRadius = (contentView.bounds.height - 10) / 2
    }
    
    // 셀 재사용
    override public func prepareForReuse() {
        super.prepareForReuse()
        rankingLabel.text = nil
        thumbnailImageView.image = nil
        petNameLabel.text = nil
        petBreedLabel.text = nil
        totalStrollDistanceLabel.text = nil
    }
    
}

extension StrollRankingCell {
    // UI 설정
    private func setupUI() {
        [rankingLabel, thumbnailImageView, petNameBreedStackView, totalStrollDistanceLabel, seperateView].forEach {
            self.contentView.addSubview($0)
        }
        
    }
    
    // Layout 설정
    private func setupLayout() {
        let defaultInset: CGFloat = 10
        let defaultOffset: CGFloat = 15
        
        rankingLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        rankingLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalTo(thumbnailImageView.snp.centerY)
        }
        
        thumbnailImageView.snp.makeConstraints { make in
            make.leading.equalTo(rankingLabel.snp.trailing).offset(20)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(defaultInset)
            make.width.equalTo(thumbnailImageView.snp.height)
        }
        
        petNameBreedStackView.snp.makeConstraints { make in
            make.leading.equalTo(thumbnailImageView.snp.trailing).offset(defaultOffset)
            make.centerY.equalTo(thumbnailImageView.snp.centerY)
        }
        
        totalStrollDistanceLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        totalStrollDistanceLabel.snp.makeConstraints { make in
            make.leading.greaterThanOrEqualTo(petNameBreedStackView.snp.trailing).offset(defaultOffset)
            make.trailing.equalToSuperview()
            make.centerY.equalTo(petNameBreedStackView.snp.centerY)
        }
        
        seperateView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
    }
    
    // 셀 configure
    public func configure(strollRanking: StrollRanking) {
        rankingLabel.text = "\(strollRanking.rank)위"
        thumbnailImageView.image = strollRanking.pet.image
        petNameLabel.text = "\(strollRanking.pet.name)"
        petBreedLabel.text = "\(strollRanking.pet.breed)"
        totalStrollDistanceLabel.attributedText = getString(distance: strollRanking.TotalDistance)
    }
    
    //
    private func getString(distance: Double) -> NSAttributedString {
        let numberString = "\(distance)"
        let unitString = " Km"
        let completeString = numberString + unitString
        
        let attributedText = NSMutableAttributedString(string: completeString)
        // 전체 문자열에 우선 적용
        let fullRange = NSRange(location: 0, length: completeString.count)
        attributedText.addAttribute(.font, value: UIFont.pretendard(size: 18, family: .SemiBold), range: fullRange)
        // "Km" 부분만 더 작은 폰트로 변경
        let unitRange = NSRange(location: numberString.count, length: unitString.count)
        attributedText.addAttribute(.font, value: UIFont.pretendard(size: 11, family: .Medium), range: unitRange)
        
        return attributedText
    }
    
}


