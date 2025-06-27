//
//  PostCreationView.swift
//  MeongMungI
//
//  Created by 7aeHoon on 6/16/25.
//

import UIKit
import SnapKit
import Then

// MARK: - 사용자가 커뮤니티에 게시글을 작성하기 위한 뷰
public final class PostEditorView: UIView {
    
    // 게시판 선택 버튼
    public let boardSelectionButton = UIButton(type: .custom).then {
        // Configuration 객체 생성
        var config = UIButton.Configuration.plain()
        // 텍스트 설정
        var attributedStr = AttributedString("게시판을 선택해주세요")
        attributedStr.font = UIFont.pretendard(size: 16, family: .semiBold)
        config.attributedTitle = attributedStr
        // 버튼의 텍스트와 이미지의 색상
        config.baseForegroundColor = .secondaryTextColor
        // 텍스트의 위치
        config.titleAlignment = .leading
        config.image = UIImage(systemName: "chevron.down")
        // 이미지의 위치
        config.imagePlacement = .trailing
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        // 버튼에 Configuration 적용
        $0.configuration = config
        // 내부 컨텐츠 사이즈를 영역만큼 채우기
        $0.contentHorizontalAlignment = .fill
        $0.clipsToBounds = true
    }
    
    // 구분선
    public let boardSelectionView = UIView().then {
        $0.backgroundColor = .backgroundColor
        $0.clipsToBounds = true
    }
    
    // 제목 텍스트 필드
    public let titleTextField = UITextField().then {
        $0.placeholder = "제목을 입력하세요"
        $0.font = .pretendard(size: 18, family: .semiBold)
        $0.textColor = .secondaryTextColor
        $0.clearButtonMode = .whileEditing
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.contentVerticalAlignment = .center
    }
    
    // 구분선
    public let titleTextFieldView = UIView().then {
        $0.backgroundColor = .backgroundColor
        $0.clipsToBounds = true
    }
    
    // 게시글 내용 텍스트 뷰
    public let contentTextView = UITextView().then {
        $0.text = "내용을 입력하세요"
        $0.font = .pretendard(size: 18, family: .medium)
        $0.textColor = .placeholderText
        $0.clipsToBounds = true
        $0.textContainerInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        $0.textContainer.lineFragmentPadding = 0
    }
    
    // 게시글 올리기 버튼
    public let publishPostButton = UIButton(type: .custom).then {
        $0.setTitle("올리기", for: .normal)
        $0.setTitleColor(.mainColor, for: .normal)
        $0.titleLabel?.font = .pretendard(size: 17, family: .semiBold)
        $0.isHighlighted = false
    }
    
    // 네비게이션 오른쪽 바 버튼 아이템에 커스텀 버튼 적용
    public lazy var rightBarButtonItem = UIBarButtonItem(customView: publishPostButton)
    
    // 사진첩에서 사진 가져오기 버튼
    public let photoSelectionButton = UIButton(type: .custom).then {
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 22, weight: .medium)
        let image = UIImage(systemName: "photo.stack")?
            .withConfiguration(symbolConfig)
            .withTintColor(.secondaryTextColor, renderingMode: .alwaysOriginal)
        $0.setImage(image, for: .normal)
        $0.contentHorizontalAlignment = .center
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .backgroundColor
        $0.layer.cornerRadius = 17
        $0.clipsToBounds = true
        $0.adjustsImageWhenHighlighted = false
    }
    
    // 사진첩에서 선택된 사진을 보여주기 위하 컬렉션뷰
    public let photoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then {
        $0.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.ID)
        $0.showsHorizontalScrollIndicator = false
        $0.clipsToBounds = true
    }
    
    // 사진 컬렉션뷰에 적용할 레이아웃
    private let photoLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 15
        $0.minimumInteritemSpacing = 15
    }
    
    private var contentTextViewBottomToPhotoButtonConstraint: Constraint?
    private var contentTextViewBottomToKeyboardConstraint: Constraint?
    
    // MARK: - init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        setupUI()
        setupLayout()
        configureKeyboardHandling()
        photoCollectionView.setCollectionViewLayout(photoLayout, animated: false)
    }
    
    // MARK: - required init
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - layoutSubviews
    public override func layoutSubviews() {
        super.layoutSubviews()
        let height = photoCollectionView.bounds.height
        let width = height
        photoLayout.itemSize = CGSize(width: width, height: height)
    }
    
    // MARK: - addSubViews
    private func addSubViews() {
        [boardSelectionButton,
         boardSelectionView,
         titleTextField,
         titleTextFieldView,
         contentTextView,
         photoSelectionButton,
         photoCollectionView
        ].forEach { addSubview($0) }
    }
    
    // MARK: - setupUI
    private func setupUI() {
        self.backgroundColor = .white
    }
    
    // MARK: - setupLayout
    private func setupLayout() {
        boardSelectionButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        boardSelectionView.snp.makeConstraints { make in
            make.top.equalTo(boardSelectionButton.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(1.5)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(boardSelectionView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        titleTextFieldView.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(1.5)
        }
        
        contentTextView.snp.makeConstraints { make in
//            make.top.equalTo(titleTextFieldView.snp.bottom).offset(10)
//            make.leading.trailing.equalToSuperview()
//            make.bottom.equalTo(photoSelectionButton.snp.top).offset(-20)
            
            make.top.equalTo(titleTextFieldView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()

            // 1) photoSelectionButton.top 제약 (기본 활성)
            contentTextViewBottomToPhotoButtonConstraint = make
                .bottom.equalTo(photoSelectionButton.snp.top)
                .offset(-20)
                .constraint

            // 2) keyboardLayoutGuide.top 제약 (초기엔 비활성)
            contentTextViewBottomToKeyboardConstraint = make
                .bottom.equalTo(keyboardLayoutGuide.snp.top)
                .offset(-20)
                .constraint
            contentTextViewBottomToKeyboardConstraint?.deactivate()
        }
        
        photoSelectionButton.snp.makeConstraints { make in
//            make.bottom.equalTo(keyboardLayoutGuide.snp.top).offset(-20)
//            make.leading.equalToSuperview().inset(20)
//            make.height.width.equalTo(90)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(20)
            make.leading.equalToSuperview().inset(20)
            make.height.width.equalTo(90)
        }
    
        
        photoCollectionView.snp.makeConstraints { make in
            make.leading.equalTo(photoSelectionButton.snp.trailing).offset(15)
            make.top.bottom.equalTo(photoSelectionButton)
            make.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func configureKeyboardHandling() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        contentTextViewBottomToPhotoButtonConstraint?.deactivate()
        contentTextViewBottomToKeyboardConstraint?.activate()
        UIView.animate(withDuration: 0.25) { self.layoutIfNeeded() }
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        contentTextViewBottomToKeyboardConstraint?.deactivate()
        contentTextViewBottomToPhotoButtonConstraint?.activate()
        UIView.animate(withDuration: 0.25) { self.layoutIfNeeded() }
    }

    // 메모리 해제 시 옵저버 제거
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}
