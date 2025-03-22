//
//  HomeView.swift
//  MeongMungI
//
//  Created by 7aeHoon on 3/22/25.
//

import UIKit
import Then
import SnapKit

// MARK: - 메인 홈 화면 뷰
public final class HomeView: UIView {
    
    // 네비게이션 왼쪽 바 버튼 커스텀 레이블
    private let titleLabel = UILabel().then {
        $0.text = "멍뭉이"
        $0.numberOfLines = 1
        $0.font = UIFont.Moneygraphy(size: 25)
        $0.textColor = .black
    }
    
    // 네비게이션 오른쪽 바 버튼 아이템 - 알림 아이콘
    private let bellButton = UIButton(type: .system).then{
        $0.setImage(UIImage(named: "bell"), for: .normal)
        $0.tintColor = .black
    }
    
    // 네비게이션 왼쪽 바 버튼 아이템에 커스텀 레이블 적용
    public lazy var leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
    
    // 네비게이션 오른쪽 바 버튼 아이템에 커스텀 레이블 적용
    public lazy var rightBarButtonItem = UIBarButtonItem(customView: bellButton)
    
    // 컬렉션 뷰 - Layer 1
    public lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then {
        $0.backgroundColor = .clear
        $0.clipsToBounds = true
    }
    
    // init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupUI()
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HomeView {
    // 하위 뷰 설정
    private func setupViews() {
        self.addSubview(collectionView)
    }
    
    // 초기 UI 설정
    private func setupUI() {
        self.backgroundColor = .backgroundColor
    }
    
    // 초기 Layout 설정
    private func setupLayout() {
        // 컬렉션 뷰의 레이아웃 설정
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide.snp.edges)
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(1500)
        }
    }
    
//    // 컬렉션 뷰의 레이아웃 설정
//    private func createCollectionViewlayout() -> UICollectionViewCompositionalLayout {
//
//    }
}
