//
//  HeaderView.swift
//  MeongMungI
//
//  Created by 7aeHoon on 3/23/25.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

// MARK: - 컬렉션 뷰의 섹션 헤더 뷰
public final class HeaderView: UICollectionReusableView {
    // 아이디
    static let ID = "HeaderView"
    
    private lazy var stackView = UIStackView(arrangedSubviews: [titleLabel, viewAllButton]).then {
        $0.axis = .horizontal
        $0.spacing = 20
        $0.alignment = .fill
        $0.distribution = .fill
    }
    
    // 타이틀 레이블
    private let titleLabel = UILabel().then {
        $0.font = UIFont.pretendard(size: 16, family: .semiBold)
        $0.textColor = .primaryTextColor
        $0.textAlignment = .left
        $0.numberOfLines = 1
    }
    
    // 전체보기 버튼
    public let viewAllButton = UIButton(type: .system).then {
        $0.setTitle("전체보기", for: .normal)
        $0.titleLabel?.font = UIFont.pretendard(size: 13, family: .medium)
        $0.setTitleColor(.primaryTextColor, for: .normal)
        $0.isHidden = false
    }
    
    // 전체보기 버튼의 탭 이벤트
    public var viewAllButtonRelay = PublishRelay<Void>()
    public var disposeBag = DisposeBag()

    // init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
        setPriority()
        bindUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // prepareForReuse
    public override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = DisposeBag()
        configure(title: "")
    }
}

extension HeaderView {
    // UI 설정
    private func setupUI() {
        self.addSubview(stackView)
    }
    
    // Layout 설정
    private func setupLayout() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    // Priority 설정
    private func setPriority() {
        // 레이블은 가능한 공간을 차지하도록 우선순위 설정
        titleLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        titleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        // 버튼은 자신의 크기를 유지하도록 우선순위 설정
        viewAllButton.setContentHuggingPriority(.required, for: .horizontal)
        viewAllButton.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    private func bindUI() {
        // 전체보기 버튼의 클릭 이벤트 바인드
        viewAllButton.rx.tap
            .bind(to: viewAllButtonRelay)
            .disposed(by: disposeBag)
    }
    
    // Configure
    public func configure(title: String) {
        self.titleLabel.text = title
    }
    

}

