//
//  HomeViewController.swift
//  MeongMungI
//
//  Created by 7aeHoon on 3/18/25.
//

import UIKit
import RxSwift
import RxCocoa

// MARK: - 홈 뷰컨트롤러
public final class HomeViewController: UIViewController {

    private let homeView = HomeView()
    // 스냅샷과 데이터 소스
    private var snapshot = NSDiffableDataSourceSnapshot<HomeSection, HomeItem>()
    private var datasource: UICollectionViewDiffableDataSource<HomeSection, HomeItem>!
    private let disposeBag = DisposeBag()
    
    // MARK: - loadView
    public override func loadView() {
        self.view = homeView
    }
    
    // MARK: - viewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBarButtonItem()
        configureCollectionView()
    }
    
    // MARK: - 네비게이션 바 버튼 아이템 설정
    private func configureNavBarButtonItem() {
        self.navigationItem.leftBarButtonItem = homeView.leftBarButtonItem
        self.navigationItem.rightBarButtonItem = homeView.rightBarButtonItem
    }
    
    // MARK: - HomeLayoutProvider를 통해 컬렉션 뷰로 레이아웃 전달
    private func configureCollectionView() {
        setupDiffableDatasource()
        // 데이터 소스 초기화 후 컬렉션 뷰에 전달
        let compositonalLayout = HomeLayoutProvider.makeCompositionalLayout(with: datasource)
        homeView.collectionView.setCollectionViewLayout(compositonalLayout, animated: false)
        setupHeaderView()
        applySnapshot()
    }

    // MARK: - DiffableDatasource 설정
    private func setupDiffableDatasource() {
        datasource = UICollectionViewDiffableDataSource<HomeSection, HomeItem>(collectionView: homeView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .myPetList(let pet):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PetProfileCell.ID, for: indexPath) as? PetProfileCell
                cell?.configure(pet: pet)
                return cell
            case .monthlyStrollStats(let monthlyStroll):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MonthlyStrollStatsCell.ID, for: indexPath) as? MonthlyStrollStatsCell
                //cell?.configure(monthlyStroll: monthlyStroll)
                return cell
            case .strollHistory(id: let id, image: let image):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StrollHistoryCell.ID, for: indexPath) as? StrollHistoryCell
                cell?.configure(id: id, image: image)
                return cell
            case .hotPost(let post):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotPostCell.ID, for: indexPath) as? HotPostCell
                cell?.configure(post: post)
                return cell
            case .strollRanking(let strollRanking):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StrollRankingCell.ID, for: indexPath) as? StrollRankingCell
                cell?.configure(strollRanking: strollRanking)
                return cell
            }
        })
    }
    
    // MARK: - HeaderView 설정
    private func setupHeaderView() {
        datasource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath -> UICollectionReusableView? in
            guard let self = self else { return nil }
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.ID, for: indexPath) as! HeaderView
            let section = datasource.sectionIdentifier(for: indexPath.section)
            
            switch section {
            case .strollHistory(let title):
                headerView.configure(title: title)
                headerView.viewAllButtonRelay
                    .subscribe(onNext: {
                        print("최근 산책 전체보기 버튼 클릭됨")
                    })
                    .disposed(by: headerView.disposeBag) // 주의! 뷰 컨트롤러의 disposeBag이 아닌 헤더의 disposeBag에 append
            case .hotPost(let title):
                headerView.configure(title: title)
                headerView.viewAllButtonRelay
                    .subscribe(onNext: {
                        print("실시간 인기글 전체보기 버튼 클릭됨")
                    })
                    .disposed(by: headerView.disposeBag) // 주의! 뷰 컨트롤러의 disposeBag이 아닌 헤더의 disposeBag에 append
            case .strollRanking(let title):
                headerView.configure(title: title)
                headerView.viewAllButtonRelay
                    .subscribe(onNext: {
                        print("산책 랭킹 전체보기 버튼 클릭됨")
                    })
                    .disposed(by: headerView.disposeBag) // 주의! 뷰 컨트롤러의 disposeBag이 아닌 헤더의 disposeBag에 append
            default:
                break
            }
            return headerView
        }
    }
    
    // MARK: - 컬렉션 뷰에 스냅샷 적용
    private func applySnapshot() {
        // 반려동물 아이템
        let pets = [
            Pet(image: .cat5, name: "슬기", breed: "랙돌", birth: "2021-09-06"),
            Pet(image: .cat1, name: "유미", breed: "페르시안 친칠라", birth: "2019-12-07"),
            Pet(image: .cat6, name: "하루", breed: "페르시안 친칠라", birth: "2019-12-12")
        ]
        
        // 최근 산책 기록 아이템
        let items: [HomeItem] = [
            .strollHistory(id: 0, image: .cat1),
            .strollHistory(id: 1, image: .cat2),
            .strollHistory(id: 2, image: .cat3),
            .strollHistory(id: 3, image: .cat5)
        ]
        
        
        let strollRankings: [StrollRanking] = [
            StrollRanking(rank: 1, pet: Pet(image: .cat3, name: "나비", breed: "페르시안 친칠라", birth: ""), TotalDistance: 98.12),
            StrollRanking(rank: 2, pet: Pet(image: .cat5, name: "슬기", breed: "랙돌", birth: ""), TotalDistance: 47.21),
            StrollRanking(rank: 3, pet: Pet(image: .cat1, name: "유미", breed: "랙돌", birth: ""), TotalDistance: 41.9),
            StrollRanking(rank: 4, pet: Pet(image: .cat6, name: "하루", breed: "페르시안 친칠라", birth: ""), TotalDistance: 26.49),
            StrollRanking(rank: 5, pet: Pet(image: .cat2, name: "수현", breed: "페르시안 친칠라", birth: ""), TotalDistance: 13.4),
            StrollRanking(rank: 6, pet: Pet(image: .cat7, name: "코코", breed: "페르시안 친칠라", birth: ""), TotalDistance: 9.1),
        ]
        
        // 아이템 변환
        let petItems = pets.map { HomeItem.myPetList($0) }
        let monthlyStrollItems = [HomeItem.monthlyStrollStats(Stroll(count: 5, distance: 19, duration: 45.16))]
        let strollRankingItems = strollRankings.map { HomeItem.strollRanking($0) }
        
        
        // 섹션
        let petProfileSection = HomeSection.myPetList
        let monthlyStrollSection = HomeSection.monthlyStrollStats
        let strollHistorySection = HomeSection.strollHistory("최근 산책기록 🐕")
        let hotPostSection = HomeSection.hotPost("실시간 인기글 🔥")
        let strollRankingSection = HomeSection.strollRanking("산책 랭킹 🏆")
        
        
        // 섹션 등록
        snapshot.appendSections([petProfileSection, monthlyStrollSection, strollHistorySection, hotPostSection, strollRankingSection])
        
        // 스냅샷에 아이템 등록
        snapshot.appendItems(petItems, toSection: petProfileSection)
        snapshot.appendItems(monthlyStrollItems, toSection: monthlyStrollSection)
        snapshot.appendItems(items, toSection: strollHistorySection)
        snapshot.appendItems(strollRankingItems, toSection: strollRankingSection)
        
        datasource.apply(snapshot, animatingDifferences: false)
    }
    
}
