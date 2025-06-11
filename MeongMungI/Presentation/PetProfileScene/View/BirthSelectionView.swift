//
//  BirthSelectionView.swift
//  MeongMungI
//
//  Created by 7aeHoon on 6/9/25.
//

import UIKit
import SnapKit
import Then

// MARK: - 사용자가 반려동물의 생년월일을 입력하기 위한 뷰
public final class BirthSelectionView: UIView {
    // 생년월일 선택 데이트 피커
    public let datePicker = UIDatePicker().then {
        $0.datePickerMode = .date
        $0.preferredDatePickerStyle = .wheels
        $0.locale = Locale(identifier: "ko_KR")
        $0.maximumDate = Date()
        $0.clipsToBounds = true
    }
    
    // 선택하기 버튼
    public let completeButton = UIButton(type: .custom).then {
        $0.setTitle("선택하기", for: .normal)
        $0.titleLabel?.font = .pretendard(size: 18, family: .medium)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .mainColor
        $0.layer.cornerRadius = 17
        $0.clipsToBounds = true
    }
    
    public let formatter = DateFormatter().then {
        $0.locale = Locale(identifier: "ko_KR")
        $0.timeZone = TimeZone.current
        $0.dateFormat = "yyyy년 MM월 dd일"
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
    
    private func addSubviews() {
        self.addSubview(datePicker)
        self.addSubview(completeButton)
    }
    
    // MARK: - setupUI
    private func setupUI() {
        self.backgroundColor = .white
    }
    
    // MARK: - setupLayout
    private func setupLayout() {
        let horizonInset = 20
        let verticalInset = 20
        let buttonHeight = 57
        
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(verticalInset)
            make.leading.trailing.equalToSuperview().inset(horizonInset)
        }
        
        completeButton.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(datePicker.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(horizonInset)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(10)
            make.height.equalTo(buttonHeight)
        }
    }
    
}
