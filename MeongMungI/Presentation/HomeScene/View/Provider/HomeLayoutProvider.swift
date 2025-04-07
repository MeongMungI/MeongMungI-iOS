//
//  HomeLayoutProvider.swift
//  MeongMungI
//
//  Created by 7aeHoon on 3/24/25.
//

import UIKit

// MARK: - 컬렉션 뷰의 레이아웃 설정을 도와주는 HomeLayoutProvider
public struct HomeLayoutProvider {
    // 전체 컬렉션 뷰 레이아웃 생성
    static func makeCompositionalLayout(with datasource: UICollectionViewDiffableDataSource<HomeSection, HomeItem>) -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        // 섹션 사이 간격 설정
        config.interSectionSpacing = 25
        
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, _ ) -> NSCollectionLayoutSection? in
            guard let homeSection = datasource.sectionIdentifier(for: sectionIndex) else { return nil }
            
            switch homeSection {
            case .myPetList:
                return makeMyPetListSection()
            case .monthlyStrollStats:
                return makeMonthlyStrollStatsSection()
            case .strollHistory(_):
                return makeStrollHistorySection()
            case .hotPost(_):
                return makeHotPostSection()
            }
        }
        // 레이아웃에 configuration 적용
        layout.configuration = config
        // 레이아웃에 데코레이션 뷰 적용
        layout.register(DecorationView.self, forDecorationViewOfKind: DecorationView.ID)
        return layout
    }
    
    // 내 강아지 목록 섹션 레이아웃 생성
    static func makeMyPetListSection() -> NSCollectionLayoutSection {
        // 아이템 설정
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // 그룹 설정
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(90),
            heightDimension: .absolute(120)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            repeatingSubitem: item,
            count: 1
        )
        
        // 섹션 설정
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 20
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        
        // 데코레이션 뷰 추가
        let backgroundDecoration = NSCollectionLayoutDecorationItem.background(elementKind: DecorationView.ID)
        section.decorationItems = [backgroundDecoration]
        
        return section
    }
    
    // 최근 한 달 산책 통계 섹션 레이아웃 생성
    static func makeMonthlyStrollStatsSection() -> NSCollectionLayoutSection {
        // 아이템 설정
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // 그룹 설정
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(130)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // 섹션 설정
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20)
        section.orthogonalScrollingBehavior = .none
        
        return section
    }
    
    // 최근 산책기록 섹션 레이아웃 생성
    static func makeStrollHistorySection() -> NSCollectionLayoutSection {
        // 아이템 설정
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        // item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0)
        // 그룹 설정
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(220),
            heightDimension: .absolute(220)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            repeatingSubitem: item,
            count: 1
        )
        
        // 섹션 설정
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 15
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 20, trailing: 20)
        section.orthogonalScrollingBehavior = .continuous
        
        // 헤더 설정
        let headerItem = makeHeaderItem()
        section.boundarySupplementaryItems = [headerItem]
        
        return section
    }
    
    // 실시간 인기글 섹션 레이아웃 생성
    static func makeHotPostSection() -> NSCollectionLayoutSection {
        // 아이템 설정
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0 / 3)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        // 그룹 설정
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(255)
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            repeatingSubitem: item,
            count: 3
        )
        
        // 그룹 내부 아이템 간의 간격 설정으로 그룹의 사이즈에 반영됨
        group.interItemSpacing = .fixed(10)
        
        // 섹션 설정
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 20, trailing: 20)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        // 헤더 설정
        let headerItem = makeHeaderItem()
        section.boundarySupplementaryItems = [headerItem]
        
        return section
    }
}

extension HomeLayoutProvider {
    // 헤더 아이템 생성
     static func makeHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
         let headerSize = NSCollectionLayoutSize(
             widthDimension: .fractionalWidth(1.0),
             heightDimension: .absolute(40)
         )
         
         let headerItem = NSCollectionLayoutBoundarySupplementaryItem(
             layoutSize: headerSize,
             elementKind: UICollectionView.elementKindSectionHeader,
             alignment: .top
         )
         
         headerItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
         return headerItem
     }
}
