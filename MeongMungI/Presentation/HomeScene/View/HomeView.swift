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
    
    // 컬렉션 뷰
    public lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewCompositionalLayout()).then {
        // 헤더 뷰 등록
        $0.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.ID)
        // 지난 산책기록 셀 등록
        $0.register(StrollHistoryCell.self, forCellWithReuseIdentifier: StrollHistoryCell.ID)
        $0.backgroundColor = .clear
        $0.clipsToBounds = true

    }
    
    // 컬렉션 뷰에 적용할 diffableDataSource
    public var diffableDataSource: UICollectionViewDiffableDataSource<HomeSection, HomeSectionItem>! = nil
    
    // init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupUI()
        setupLayout()
        setupDiffableDatasource()
        setupHeaderView()
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
        self.backgroundColor = .white
    }
    
    // 초기 Layout 설정
    private func setupLayout() {
        // 컬렉션 뷰의 레이아웃 설정
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(1500)
        }
    }
}

extension HomeView {
    // 컬렉션 뷰의 CompositionalLayout 설정
    private func createCollectionViewCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        // 섹션 사이 간격 설정
        config.interSectionSpacing = 20
        // 섹션 맞춤 레이아웃 생성
        let layout = UICollectionViewCompositionalLayout { [weak self] (sectionIndex, _ ) -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            // diffableDataSource에서 섹션을 가져오기
            let homeSection = diffableDataSource.sectionIdentifier(for: sectionIndex)
            
            switch homeSection {
            case .strollHistory:
                // 지난 산책기록
                return createStrollHistorySection()
            default:
                return nil
            }
        }
        
        // 레이아웃에 configuration 적용
        layout.configuration = config
        // 레이아웃에 데코레이션 뷰 적용
        layout.register(DecorationView.self, forDecorationViewOfKind: DecorationView.ID)
        return layout
    }
    
    // 지난 산책기록 섹션 설정
    private func createStrollHistorySection() -> NSCollectionLayoutSection {
        // 아이템 설정
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        // 그룹 설정
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .absolute(280))
        // 그룹 내부에 1개의 아이템
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)
        // 섹션 설정
        let section = NSCollectionLayoutSection(group: group)
        // 그룹 간격 설정
        section.interGroupSpacing = 10
        // 섹션과 컬렉션뷰의 인셋 설정
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        // 섹션의 좌우 스크롤 효과 설정
        section.orthogonalScrollingBehavior = .continuous
        // 데코레이션 뷰 설정
        let decorationItem = NSCollectionLayoutDecorationItem.background(elementKind: DecorationView.ID)
        // decorationItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0) // 상단 간격 추가
        section.decorationItems = [decorationItem]
        
        // 헤더 설정
        let header = createHeaderView()
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    // 섹션의 HeaderView 생성
    private func createHeaderView() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40))
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        headerItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        return headerItem
    }
    
    // DiffableDatasource 설정
    private func setupDiffableDatasource() {
        diffableDataSource = UICollectionViewDiffableDataSource<HomeSection, HomeSectionItem>(collectionView: collectionView, cellProvider: { [weak self] collectionView, indexPath, itemIdentifier in
            guard let self = self else { return UICollectionViewCell() }
            switch itemIdentifier {
            // 지난 산책기록 아이템
            case .strollHistory(id: let id, image: let image):
                let snapshot = self.diffableDataSource.snapshot()
                let section = snapshot.sectionIdentifiers[indexPath.section]
                let items = snapshot.itemIdentifiers(inSection: section)
                print(items.count)
                print(indexPath.item)
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StrollHistoryCell.ID, for: indexPath) as? StrollHistoryCell
                cell?.configure(id: id, image: image)
                return cell
            }
        })
    }
    
    // HeaderView 설정
    private func setupHeaderView() {
        diffableDataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath -> UICollectionReusableView? in
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.ID, for: indexPath) as? HeaderView
            let section = self?.diffableDataSource.sectionIdentifier(for: indexPath.section)
            
            switch section {
            case .strollHistory(let title):
                headerView?.configure(title: title)
            default:
                break
            }
            return headerView
        }
    }
}



// 홈 화면 섹션
public enum HomeSection: Hashable {
    case strollHistory(String) // 지난 산책기록 섹션
    case communityHotPost(String) // 실시간 인기글 섹션
}

// 홈 화면 아이템
public enum HomeSectionItem: Hashable {
    case strollHistory(id: Int, image: UIImage)
}
