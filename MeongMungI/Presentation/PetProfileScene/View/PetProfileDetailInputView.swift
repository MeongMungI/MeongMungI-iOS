//
//  PetProfileDetailInputView.swift
//  MeongMungI
//
//  Created by 7aeHoon on 6/11/25.
//

import UIKit
import SnapKit
import Then

// MARK: - 사용자가 반려동물의 상세 프로필을 입력하기 위한 뷰
public final class PetProfileDetailInputView: UIView {
    
    // 스크롤 뷰
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.alwaysBounceVertical = true
    }
    
    // 스택 뷰
    private lazy var stackView = UIStackView(
        arrangedSubviews: [inputProgressView, infoLabel, weightContainerView, neuteringContainerView, personalityContainerView]).then {
        $0.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        $0.isLayoutMarginsRelativeArrangement = true
        $0.axis = .vertical
        $0.spacing = 40
        $0.clipsToBounds = true
    }
    
    // 반려견 정보 입력 진행 상태 바
    public var inputProgressView = UIProgressView(progressViewStyle: .default).then {
        $0.trackTintColor = #colorLiteral(red: 0.9147436619, green: 0.9277587533, blue: 0.9341855645, alpha: 1)
        $0.progressTintColor = .mainColor
        $0.progress = 0.35
        $0.layer.cornerRadius = 4
        $0.clipsToBounds = true
    }
    
    // 인포 레이블
    private let infoLabel = UILabel().then {
        $0.text = "추가 정보가 필요해요"
        $0.numberOfLines = 1
        $0.font = .pretendard(size: 23, family: .semiBold)
        $0.textColor = .primaryTextColor
    }
    
    // MARK: - 몸무게 필드
    // 몸무게 컨테이너 뷰
    private let weightContainerView = UIView()
    
    // 몸무게 제목 레이블
    private let weightTitleLabel = UILabel().then {
        $0.text = "몸무게"
        $0.font = .pretendard(size: 14, family: .medium)
        $0.textColor = .secondaryTextColor
    }
    
    // 몸무게 텍스트 필드를 감싸고 있는 컨테이너 뷰
    private let weightSelectionContainerView = UIView().then {
        $0.backgroundColor = .textFieldBackgroundColor
        $0.layer.cornerRadius = 15
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.borderColor.cgColor
    }
    
    // 몸무게 텍스트 필드
    public let weightSelectionField = UITextField().then {
        $0.placeholder = "Kg"
        $0.font = .pretendard(size: 15, family: .medium)
        $0.textColor = .primaryTextColor
        $0.clearButtonMode = .whileEditing
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.contentVerticalAlignment = .center
    }
    
    // MARK: - 중성화 필드
    // 중성화 컨테이너 뷰
    private let neuteringContainerView = UIView()
    
    // 중성화 제목 레이블
    private let neuteringTitleLabel = UILabel().then {
        $0.text = "중성화 여부"
        $0.font = .pretendard(size: 14, family: .medium)
        $0.textColor = .secondaryTextColor
    }
    
    // 중성화 텍스트 필드를 감싸고 있는 컨테이너 뷰
    private let neuteringSelectionContainerView = UIView()
    
    // 했어요 선택 버튼
    public let hasNeuteredButton = UIButton(type: .custom).then {
        $0.setTitle("했어요", for: .normal)
        $0.titleLabel?.font = .pretendard(size: 15, family: .medium)
        $0.setTitleColor(.secondaryTextColor, for: .normal)
        $0.backgroundColor = .textFieldBackgroundColor
        $0.layer.cornerRadius = 15
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.borderColor.cgColor
        $0.clipsToBounds = true
    }
    
    // 안했어요 선택 버튼
    public let notNeuteredButton = UIButton(type: .custom).then {
        $0.setTitle("안했어요", for: .normal)
        $0.titleLabel?.font = .pretendard(size: 15, family: .medium)
        $0.setTitleColor(.secondaryTextColor, for: .normal)
        $0.backgroundColor = .textFieldBackgroundColor
        $0.layer.cornerRadius = 15
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.borderColor.cgColor
        $0.clipsToBounds = true
    }
    
    // MARK: - 성격 필드
    // 성격 컨테이너 뷰
    private let personalityContainerView = UIView()
    
    // 성격 제목 레이블
    private let personalityTitleLabel = UILabel().then {
        $0.text = "성격(선택사항)"
        $0.font = .pretendard(size: 14, family: .medium)
        $0.textColor = .secondaryTextColor
    }
    
    // 성격 텍스트 뷰
    public let personalityTextView = UITextView().then {
        $0.text = "성격을 알려주세요"
        $0.font = .pretendard(size: 15, family: .medium)
        $0.textColor = .placeholderText
        $0.backgroundColor = .textFieldBackgroundColor
        $0.layer.cornerRadius = 15
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.borderColor.cgColor
        $0.clipsToBounds = true
        $0.showsVerticalScrollIndicator = false
        $0.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    // 확인 버튼
    public let completeButton = UIButton(type: .custom).then {
        $0.setTitle("확인", for: .normal)
        $0.titleLabel?.font = .pretendard(size: 18, family: .medium)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .buttonDisableColor
        $0.layer.cornerRadius = 17
        $0.clipsToBounds = true
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
        addSubview(scrollView)
        addSubview(completeButton)
        
        scrollView.addSubview(stackView)
        
        // 몸무게 필드
        weightContainerView.addSubview(weightTitleLabel)
        weightContainerView.addSubview(weightSelectionContainerView)
        weightSelectionContainerView.addSubview(weightSelectionField)
        
        // 중성화 필드
        neuteringContainerView.addSubview(neuteringTitleLabel)
        neuteringContainerView.addSubview(neuteringSelectionContainerView)
        neuteringSelectionContainerView.addSubview(hasNeuteredButton)
        neuteringSelectionContainerView.addSubview(notNeuteredButton)
        
        // 성격 필드
        personalityContainerView.addSubview(personalityTitleLabel)
        personalityContainerView.addSubview(personalityTextView)
    }
    
    // MARK: - UI 설정
    private func setupUI() {
        self.backgroundColor = .white
    }
    
    // MARK: - Layout 설정
    private func setupLayout() {
        // 버튼의 높이 값
        let buttonHeight = 57
        // 수평 inset 값
        let horizonInset = 20
        // 수직 inset 값
        let verticalInset = 20
        
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(completeButton.snp.top).offset(-10)
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        inputProgressView.snp.makeConstraints { make in
            make.height.equalTo(8)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(horizonInset)
        }
        
        // MARK: - 몸무게
        weightTitleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        weightSelectionContainerView.snp.makeConstraints { make in
            make.top.equalTo(weightTitleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(55)
            make.bottom.equalToSuperview()
        }
        weightSelectionField.snp.makeConstraints { make in
            make.top.bottom.centerY.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        // MARK: - 중성화
        neuteringTitleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        neuteringSelectionContainerView.snp.makeConstraints { make in
            make.top.equalTo(neuteringTitleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(55)
            make.bottom.equalToSuperview()
        }
        
        let spacing: CGFloat = 15
        hasNeuteredButton.snp.remakeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalTo(notNeuteredButton.snp.leading).offset(-spacing)
            make.width.equalTo(notNeuteredButton)
        }
        notNeuteredButton.snp.remakeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
            make.leading.equalTo(hasNeuteredButton.snp.trailing).offset(spacing)
        }
        
        // MARK: - 성격
        personalityTitleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        personalityTextView.snp.makeConstraints { make in
            make.top.equalTo(personalityTitleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(200)
            make.bottom.equalToSuperview()
        }
        
        // MARK: - 확인 버튼
        completeButton.snp.makeConstraints { make in
            make.bottom.equalTo(keyboardLayoutGuide.snp.top).offset(-verticalInset)
            make.leading.trailing.equalToSuperview().inset(horizonInset)
            make.height.equalTo(buttonHeight)
        }
    }
}

extension PetProfileDetailInputView {
    // MARK: - 버튼을 선택했을 때 적용할 스타일
    public func applySelectedStyle(to button: UIButton) {
        button.backgroundColor = .buttonSelectedColor
        button.layer.borderColor = UIColor.mainColor.cgColor
        button.layer.borderWidth = 2
        button.setTitleColor(.mainColor, for: .normal)
    }
    
    // MARK: - 버튼을 선택하지 않았을 때 적용할 스타일
    public func applyDeselectedStyle(to button: UIButton) {
        button.backgroundColor = .textFieldBackgroundColor
        button.layer.borderColor = UIColor.borderColor.cgColor
        button.layer.borderWidth = 1
        button.setTitleColor(.secondaryTextColor, for: .normal)
    }
    
}
