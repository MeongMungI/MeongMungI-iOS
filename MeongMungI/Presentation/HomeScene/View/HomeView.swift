//
//  HomeView.swift
//  MeongMungI
//
//  Created by 7aeHoon on 3/22/25.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

// MARK: - 메인 홈 화면 뷰
public final class HomeView: UIView {
    // 네비게이션 왼쪽 바 버튼 커스텀 레이블
    private let titleLabel = UILabel().then {
        $0.text = "멍뭉이"
        $0.numberOfLines = 1
        $0.font = UIFont.Moneygraphy(size: 25)
        $0.textColor = .black
    }
    
    // 버튼을 담고 있는 스택 뷰(하트 + 종)
    private lazy var stackView = UIStackView.init(arrangedSubviews: [heartButton, bellButton]).then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.alignment = .fill
        $0.spacing = 25
    }
    
    // 네비게이션 오른쪽 바 버튼 아이템 - 하트 아이콘 인터페이스
    private let heartButton = UIButton(type: .system).then {
        $0.setImage(UIImage(named: "heart"), for: .normal)
        $0.tintColor = .black
        
    }
    
    // 네비게이션 오른쪽 바 버튼 아이템 - 알림 아이콘
    private let bellButton = UIButton(type: .system).then{
        $0.setImage(UIImage(named: "bell"), for: .normal)
        $0.tintColor = .black
    }
    
    // 네비게이션 왼쪽 바 버튼 아이템에 커스텀 레이블 적용
    public lazy var leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
    // 네비게이션 오른쪽 바 버튼 아이템에 커스텀 레이블 적용
    public lazy var rightBarButtonItem = UIBarButtonItem(customView: stackView)
    
    // 컬렉션 뷰
    public let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then {
        $0.backgroundColor = .clear
        $0.clipsToBounds = true
        $0.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.ID)
        $0.register(PetProfileCell.self, forCellWithReuseIdentifier: PetProfileCell.ID)
        $0.register(MonthlyStrollStatsCell.self, forCellWithReuseIdentifier: MonthlyStrollStatsCell.ID)
        $0.register(StrollHistoryCell.self, forCellWithReuseIdentifier: StrollHistoryCell.ID)
        $0.register(HotPostCell.self, forCellWithReuseIdentifier: HotPostCell.ID)
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
    
    // 하위 뷰 설정
    private func setupViews() {
        self.addSubview(collectionView)
    }
    
    // 초기 UI 설정
    private func setupUI() {
        self.backgroundColor = .white
    }
    
    // 초기 Layout 설정
    private func setupLayout() {
        // 컬렉션 뷰의 레이아웃 설정
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

    }
}

// 홈 화면 섹션
public enum HomeSection: Hashable {
    // 내 반려동물 목록 섹션
    case myPetList
    // 최근 한 달 산책 통계 섹션
    case monthlyStrollStats
    // 최근 산책기록 섹션
    case strollHistory(String)
    // 실시간 인기글 섹션
    case hotPost(String)
}

// 홈 화면 아이템
public enum HomeItem: Hashable {
    case myPetList(Pet)
    case monthlyStrollStats(Stroll)
    case strollHistory(id: Int, image: UIImage)
    case hotPost(Post)
}


// MARK: - 더미 데이터를 위한 임시 구조체 선언

// 반려동물 프로필 구조체
public struct Pet: Hashable {
    // 사진
    let image: UIImage
    // 이름
    let name: String
    // 품종
    let breed: String
    // 생년월일
    let birth: String
}

public struct Stroll: Hashable {
    let count: Int
    let distance: Double
    let duration: Double
}

// 임시 게시글 구조체
public struct Post: Hashable {
    // 게시글 순위
    let ranking: Int
    // 게시글 타입
    let type: String
    // 게시글 제목
    let title: String
    // 게시글 좋아요 수
    let like: Int
    // 게시글 댓글 수
    let comment: Int
    // 썸네일 이미지
    let thumbnailImage: UIImage?
}
