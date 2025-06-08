//
//  BreedSelectionView.swift
//  MeongMungI
//
//  Created by 7aeHoon on 6/7/25.
//

import UIKit
import Then
import SnapKit

public final class BreedSelectionView: UIView {
    
    // 메인 인포 레이블
    public let mainInfoLabel = UILabel().then {
        $0.text = "견종을 선택해주세요"
        $0.numberOfLines = 1
        $0.font = .pretendard(size: 23, family: .semiBold)
        $0.textColor = .primaryTextColor
    }
    
    // 서브 인포 레이블
    public let subInfoLabel = UILabel().then {
        $0.text = "찾으시는 견종이 없다면 기타를 선택해주세요"
        $0.numberOfLines = 1
        $0.font = .pretendard(size: 16, family: .medium)
        $0.textColor = .secondaryTextColor
    }
    
    // 견종 서치 바
    public let breedSearchBar = UISearchBar().then {
        $0.backgroundImage = UIImage()
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
        $0.clipsToBounds = true
        // 돋보기 아이콘 위치 조정
        $0.setPositionAdjustment(UIOffset(horizontal: 10, vertical: 0), for: .search)
        // 클리어 아이콘 위치 조정
        $0.setPositionAdjustment(UIOffset(horizontal: -10, vertical: 0), for: .clear)
        // 플레이스홀더 및 텍스트 위치 조정
        $0.searchTextPositionAdjustment = UIOffset(horizontal: 10, vertical: 0)
        $0.setImage(UIImage(systemName: "magnifyingglass"), for: .search, state: .normal)
        $0.setImage(UIImage(systemName: "xmark.circle.fill")?.withTintColor(#colorLiteral(red: 0.4900242686, green: 0.5378706455, blue: 0.5890643001, alpha: 1), renderingMode: .alwaysOriginal), for: .clear, state: .normal)

        if let tf = $0.value(forKey: "searchField") as? UITextField {
            tf.font = .pretendard(size: 16, family: .medium)
            tf.textColor = .primaryTextColor
            tf.backgroundColor = .backgroundColor
            tf.layer.cornerRadius = 15
            tf.clipsToBounds = true
            tf.attributedPlaceholder = NSAttributedString(
                string: "견종을 검색하세요",
                attributes: [NSAttributedString.Key.foregroundColor : UIColor.tertiaryTextColor]
            )
        }
        
    }
    
    // 견종 테이블 뷰
    public let breedTableView = UITableView().then {
        $0.register(BreedTableViewCell.self, forCellReuseIdentifier: BreedTableViewCell.ID)
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
    
    // MARK: - 하위 뷰 추가
    private func addSubviews() {
        self.addSubview(mainInfoLabel)
        self.addSubview(subInfoLabel)
        self.addSubview(breedSearchBar)
        self.addSubview(breedTableView)
    }
    
    // MARK: - UI 설정
    private func setupUI() {
        self.backgroundColor = .white
    }
    
    // MARK: - Layout 설정
    private func setupLayout() {
        let horizonInset = 20
        
        mainInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(30)
            make.leading.trailing.equalToSuperview().inset(horizonInset)
        }
        
        subInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(mainInfoLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(horizonInset)
        }
        
        breedSearchBar.snp.makeConstraints { make in
            make.top.equalTo(subInfoLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        breedSearchBar.searchTextField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(subInfoLabel)
            make.height.equalTo(50)
        }
        
        breedTableView.snp.makeConstraints { make in
            make.top.equalTo(breedSearchBar.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
    }
    
}
