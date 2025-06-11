//
//  PetProfileInputView.swift
//  MeongMungI
//
//  Created by 7aeHoon on 5/4/25.
//

import UIKit
import Then
import SnapKit

// MARK: - 사용자가 반려동물의 기본 프로필을 입력하기 위한 뷰
public final class PetProfileBasicInputView: UIView {
    
    // 스크롤 뷰
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.alwaysBounceVertical = true
    }
    
    // 스택 뷰
    private lazy var stackView = UIStackView(
        arrangedSubviews: [inputProgressView, infoLabel, nameContainerView, breedContainerView, birthContainerView, genderContainerView]).then {
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
        $0.progress = 0
        $0.layer.cornerRadius = 4
        $0.clipsToBounds = true
    }
    
    // 인포 레이블
    private let infoLabel = UILabel().then {
        $0.text = "반려견을 알려주세요"
        $0.numberOfLines = 1
        $0.font = .pretendard(size: 23, family: .semiBold)
        $0.textColor = .primaryTextColor
    }
    
    // MARK: - 이름 필드
    // 이름 컨테이너 뷰
    private let nameContainerView = UIView()
    
    // 이름 제목 레이블
    private let nameTitleLabel = UILabel().then {
        $0.text = "이름"
        $0.font = .pretendard(size: 14, family: .medium)
        $0.textColor = .secondaryTextColor
    }
    
    // 이름 텍스트 필드를 감싸고 있는 컨테이너 뷰
    private let nameSelectionContainerView = UIView().then {
        $0.backgroundColor = .textFieldBackgroundColor
        $0.layer.cornerRadius = 15
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.borderColor.cgColor
    }
    
    // 이름 텍스트 필드
    public let nameSelectionField = UITextField().then {
        $0.placeholder = "이름을 입력해 주세요"
        $0.font = .pretendard(size: 15, family: .medium)
        $0.textColor = .primaryTextColor
        $0.clearButtonMode = .whileEditing
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.contentVerticalAlignment = .center
    }
    
    // MARK: - 견종 필드
    // 견종 컨테이너 뷰
    private let breedContainerView = UIView()
    
    // 견종 제목 레이블
    private let breedTitleLabel = UILabel().then {
        $0.text = "견종"
        $0.font = .pretendard(size: 14, family: .medium)
        $0.textColor = .secondaryTextColor
    }
    
    // 견종 텍스트 필드를 감싸고 있는 컨테이너 뷰
    private let breedSelectionContainerView = UIView().then {
        $0.backgroundColor = .textFieldBackgroundColor
        $0.layer.cornerRadius = 15
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.borderColor.cgColor
    }
    
    // 견종 텍스트 필드
    public let breedSelectionField = UITextField().then {
        $0.placeholder = "견종을 선택해 주세요"
        $0.font = .pretendard(size: 15, family: .medium)
        $0.textColor = .primaryTextColor
        // 커서 색상
        $0.tintColor = .clear

        // 화살표 아이콘 이미지
        let iconImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        iconImageView.image = UIImage(systemName: "chevron.right")
        iconImageView.tintColor = .secondaryLabel
        iconImageView.contentMode = .scaleAspectFit
        // 오른쪽 뷰로 아이콘 이미지 추가
        $0.rightView = iconImageView
        $0.rightViewMode = .always
    }
    
    // MARK: - 생년월일 필드
    // 생년월일 컨테이너 뷰
    private let birthContainerView = UIView()
    
    // 생년월일 제목 레이블
    private let birthTitleLabel = UILabel().then {
        $0.text = "생년월일"
        $0.font = .pretendard(size: 14, family: .medium)
        $0.textColor = .secondaryTextColor
    }
    
    // 생년월일 텍스트 필드를 감싸고 있는 컨테이너 뷰
    private let birthSelectionContainerView = UIView().then {
        $0.backgroundColor = .textFieldBackgroundColor
        $0.layer.cornerRadius = 15
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.borderColor.cgColor
    }
    
    // 생년월일 텍스트 필드
    public let birthSelectionField = UITextField().then {
        $0.placeholder = "2025년 01월 01일"
        $0.font = .pretendard(size: 15, family: .medium)
        $0.textColor = .primaryTextColor
        // 커서 색상
        $0.tintColor = .clear

        // 달력 아이콘 이미지
        let iconImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        iconImageView.image = UIImage(systemName: "calendar")
        iconImageView.tintColor = .secondaryLabel
        iconImageView.contentMode = .scaleAspectFit
        // 오른쪽 뷰로 아이콘 이미지 추가
        $0.rightView = iconImageView
        $0.rightViewMode = .always
    }
    
    // MARK: - 성별 필드
    // 성별 컨테이너 뷰
    private let genderContainerView = UIView()
    
    // 성별 제목 레이블
    private let genderTitleLabel = UILabel().then {
        $0.text = "성별"
        $0.font = .pretendard(size: 14, family: .medium)
        $0.textColor = .secondaryTextColor
    }
    
    // 성별 텍스트 필드를 감싸고 있는 컨테이너 뷰
    private let genderSelectionContainerView = UIView()
    
    // 남아 선택 버튼
    public let maleSelectionButton = UIButton(type: .custom).then {
        $0.setTitle("남아", for: .normal)
        $0.titleLabel?.font = .pretendard(size: 15, family: .medium)
        $0.setTitleColor(.secondaryTextColor, for: .normal)
        $0.backgroundColor = .textFieldBackgroundColor
        $0.layer.cornerRadius = 15
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.borderColor.cgColor
        $0.clipsToBounds = true
    }
    
    // 여아 선택 버튼
    public let femaleSelectionButton = UIButton(type: .custom).then {
        $0.setTitle("여아", for: .normal)
        $0.titleLabel?.font = .pretendard(size: 15, family: .medium)
        $0.setTitleColor(.secondaryTextColor, for: .normal)
        $0.backgroundColor = .textFieldBackgroundColor
        $0.layer.cornerRadius = 15
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.borderColor.cgColor
        $0.clipsToBounds = true
    }
    
    // 다음 버튼
    public let nextButton = UIButton(type: .custom).then {
        $0.setTitle("다음", for: .normal)
        $0.titleLabel?.font = .pretendard(size: 18, family: .medium)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .buttonEableColor
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
        addSubview(nextButton)
        
        scrollView.addSubview(stackView)
        
        nameContainerView.addSubview(nameTitleLabel)
        nameContainerView.addSubview(nameSelectionContainerView)
        nameSelectionContainerView.addSubview(nameSelectionField)
        
        breedContainerView.addSubview(breedTitleLabel)
        breedContainerView.addSubview(breedSelectionContainerView)
        breedSelectionContainerView.addSubview(breedSelectionField)
        
        birthContainerView.addSubview(birthTitleLabel)
        birthContainerView.addSubview(birthSelectionContainerView)
        birthSelectionContainerView.addSubview(birthSelectionField)
        
        genderContainerView.addSubview(genderTitleLabel)
        genderContainerView.addSubview(genderSelectionContainerView)
        genderSelectionContainerView.addSubview(maleSelectionButton)
        genderSelectionContainerView.addSubview(femaleSelectionButton)
        
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
            make.bottom.equalTo(nextButton.snp.top).offset(-10)
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
        
        // MARK: - 이름
        nameTitleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        nameSelectionContainerView.snp.makeConstraints { make in
            make.top.equalTo(nameTitleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(55)
            make.bottom.equalToSuperview()
        }
        nameSelectionField.snp.makeConstraints { make in
            make.top.bottom.centerY.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        // MARK: - 견종
        breedTitleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        breedSelectionContainerView.snp.makeConstraints { make in
            make.top.equalTo(breedTitleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(55)
            make.bottom.equalToSuperview()
        }
        breedSelectionField.snp.makeConstraints { make in
            make.top.bottom.centerY.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        // MARK: - 생년월일
        birthTitleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        birthSelectionContainerView.snp.makeConstraints { make in
            make.top.equalTo(birthTitleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(55)
            make.bottom.equalToSuperview()
        }
        birthSelectionField.snp.makeConstraints { make in
            make.top.bottom.centerY.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        // MARK: - 성별
        genderTitleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        genderSelectionContainerView.snp.makeConstraints { make in
            make.top.equalTo(genderTitleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(55)
            make.bottom.equalToSuperview()
        }
        
        let spacing: CGFloat = 15
        maleSelectionButton.snp.remakeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalTo(femaleSelectionButton.snp.leading).offset(-spacing)
            make.width.equalTo(femaleSelectionButton)
        }
        femaleSelectionButton.snp.remakeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
            make.leading.equalTo(maleSelectionButton.snp.trailing).offset(spacing)
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(keyboardLayoutGuide.snp.top).offset(-verticalInset)
            make.leading.trailing.equalToSuperview().inset(horizonInset)
            make.height.equalTo(buttonHeight)
        }
    }
}

extension PetProfileBasicInputView {
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
