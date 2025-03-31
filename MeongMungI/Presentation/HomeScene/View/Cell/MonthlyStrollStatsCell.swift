//
//  MonthlyStrollStatsCell.swift
//  MeongMungI
//
//  Created by 7aeHoon on 3/29/25.
//

import UIKit
import SnapKit
import Then

public final class MonthlyStrollStatsCell: UICollectionViewCell {
    
    static let ID = "MonthlyStrollStatsCell"
    private static let panelCornerRadius: CGFloat = 25
    
    private lazy var countPanelData = createStatsPanel(valueText: "13", unitText: "번", titleText: "함께한\n산책", iconSystemName: "dog.fill")
    
    private lazy var distancePanelData = createStatsPanel(valueText: "27.5", unitText: "Km", titleText: "산책한\n거리", iconSystemName: "road.lanes")
    
    private lazy var timePanelData = createStatsPanel(valueText: "126", unitText: "분", titleText: "산책한\n시간", iconSystemName: "clock.fill")
    
    private lazy var containerStack = UIStackView(arrangedSubviews: [countPanelData.view, distancePanelData.view, timePanelData.view]).then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.alignment = .center
        $0.spacing = 10
    }
    
    // MARK: - 초기화
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI 구성
    private func setupUI() {
        contentView.addSubview(containerStack)
    }
    
    private func setupLayout() {
        containerStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // 모든 패널이 정사각형 비율을 유지하도록 제약 설정
        [countPanelData.view, distancePanelData.view, timePanelData.view].forEach { panel in
            panel.snp.makeConstraints { make in
                make.height.equalTo(panel.snp.width)
            }
        }
    }
    
    // 헬퍼 메서드: 통계 패널 생성 (패널과 valueLabel 레퍼런스를 함께 반환)
    private func createStatsPanel(valueText: String, unitText: String, titleText: String, iconSystemName: String) -> (view: UIView, valueLabel: UILabel) {
        let panel = UIView().then {
            $0.backgroundColor = .tossBackgroundColor
            $0.layer.cornerRadius = MonthlyStrollStatsCell.panelCornerRadius
            $0.clipsToBounds = true
        }
        
        let valueLabel = UILabel().then {
            $0.text = valueText
            $0.numberOfLines = 1
            $0.font = UIFont.pretendard(size: 26, family: .Medium)
            $0.textColor = #colorLiteral(red: 0.1254901961, green: 0.168627451, blue: 0.2392156863, alpha: 1)
            $0.textAlignment = .left
        }
        
        let unitLabel = UILabel().then {
            $0.text = unitText
            $0.numberOfLines = 1
            $0.font = UIFont.pretendard(size: 13, family: .Medium)
            $0.textColor = #colorLiteral(red: 0.2666666667, green: 0.3411764706, blue: 0.4235294118, alpha: 1)
            $0.textAlignment = .left
        }
        
        let titleLabel = UILabel().then {
            $0.text = titleText
            $0.numberOfLines = 2
            $0.font = UIFont.pretendard(size: 13, family: .Medium)
            $0.textColor = #colorLiteral(red: 0.2666666667, green: 0.3411764706, blue: 0.4235294118, alpha: 1)
            $0.textAlignment = .left
        }
        
        let iconImageView = UIImageView().then {
            $0.image = UIImage(systemName: iconSystemName)
            $0.tintColor = #colorLiteral(red: 0.2666666667, green: 0.3411764706, blue: 0.4235294118, alpha: 1)
            $0.contentMode = .scaleAspectFit
            $0.clipsToBounds = true
        }
        
        [valueLabel, unitLabel, titleLabel, iconImageView].forEach { panel.addSubview($0) }
        
        let insetvalue = 15
        
        // valueLabel 제약 조건
        valueLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        valueLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(insetvalue)
        }
        
        // unitLabel 제약 조건
        unitLabel.snp.makeConstraints { make in
            make.leading.equalTo(valueLabel.snp.trailing).offset(5)
            make.firstBaseline.equalTo(valueLabel.snp.firstBaseline)
            make.trailing.equalToSuperview().inset(insetvalue)
        }
        
        // titleLabel 제약 조건
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(insetvalue)
            make.bottom.equalToSuperview().inset(insetvalue)
            make.top.greaterThanOrEqualTo(valueLabel.snp.bottom).offset(10)
        }
        
        // iconImageView 제약 조건
        iconImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.trailing.equalToSuperview().inset(insetvalue)
            make.leading.greaterThanOrEqualTo(titleLabel.snp.trailing).offset(10)
        }
        
        return (panel, valueLabel)
    }
    
    // MARK: - 셀 업데이트 (configure)
    public func configure(with stroll: Stroll) {
        // 예를 들어, 산책 횟수만 업데이트할 경우:
        //countPanelData.valueLabel.text = "15"
    }
}
