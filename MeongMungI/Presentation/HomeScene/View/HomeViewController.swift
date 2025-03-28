//
//  HomeViewController.swift
//  MeongMungI
//
//  Created by 7aeHoon on 3/18/25.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

// MARK: - 홈 뷰컨트롤러
public final class HomeViewController: UIViewController {
    // 홈 화면을 관리하는 코디네이터
    weak var coordinator: HomeCoordinator?
    private let homeView = HomeView()
    // 스냅샷과 데이터 소스
    private var snapshot = NSDiffableDataSourceSnapshot<HomeSection, HomeItem>()
    private var datasource: UICollectionViewDiffableDataSource<HomeSection, HomeItem>!
    private let disposeBag = DisposeBag()
    
    // loadView
    public override func loadView() {
        self.view = homeView
    }
    
    // viewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBarButtonItem()
        configureCollectionView()
    }
    
    // 네비게이션 바 버튼 아이템 설정
    private func configureNavBarButtonItem() {
        self.navigationItem.leftBarButtonItem = homeView.leftBarButtonItem
        self.navigationItem.rightBarButtonItem = homeView.rightBarButtonItem
    }
    
    // HomeLayoutProvider를 통해 컬렉션 뷰로 레이아웃 전달
    private func configureCollectionView() {
        setupDiffableDatasource()
        // 데이터 소스 초기화 후 컬렉션 뷰에 전달
        homeView.collectionView.collectionViewLayout = HomeLayoutProvider.makeCompositionalLayout(with: datasource)
        setupHeaderView()
        applySnapshot()
    }

    // DiffableDatasource 설정
    private func setupDiffableDatasource() {
        datasource = UICollectionViewDiffableDataSource<HomeSection, HomeItem>(collectionView: homeView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .strollHistory(id: let id, image: let image):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StrollHistoryCell.ID, for: indexPath) as? StrollHistoryCell
                cell?.configure(id: id, image: image)
                return cell
            case .myPetList(let pet):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PetProfileCell.ID, for: indexPath) as? PetProfileCell
                cell?.configure(pet: pet)
                return cell
            }
        })
    }
    
    // HeaderView 설정
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
                        print("전체보기 버튼 클릭됨")
                    })
                    .disposed(by: headerView.disposeBag) // 주의! 뷰 컨트롤러의 disposeBag이 아닌 헤더의 disposeBag에 append
            default:
                break
            }
            return headerView
        }
    }
    
    // 컬렉션 뷰에 스냅샷 적용
    private func applySnapshot() {
        let items: [HomeItem] = [
            .strollHistory(id: 0, image: .cat1),
            .strollHistory(id: 1, image: .cat2),
            .strollHistory(id: 2, image: .cat3),
            .strollHistory(id: 3, image: .cat5)
        ]
        
        let pets = [
            Pet(image: .cat5, name: "슬기", breed: "랙돌", birth: "2021-09-06"),
            Pet(image: .cat1, name: "유미", breed: "페르시안 친칠라", birth: "2019-12-07"),
            Pet(image: .cat2, name: "나비", breed: "페르시안 친칠라", birth: "2019-12-08"),
            Pet(image: .cat3, name: "수현", breed: "페르시안 친칠라", birth: "2019-12-09"),
            Pet(image: .cat8, name: "말왕", breed: "페르시안 친칠라", birth: "2019-12-10"),
            Pet(image: .cat4, name: "보리", breed: "페르시안 친칠라", birth: "2019-12-10"),
            Pet(image: .cat9, name: "춘배", breed: "페르시안 친칠라", birth: "2019-12-11"),
            Pet(image: .cat6, name: "하루", breed: "페르시안 친칠라", birth: "2019-12-12"),
        ]
        
        let petItems = pets.map { HomeItem.myPetList($0) }
        
        let strollHistorySection = HomeSection.strollHistory("최근 산책기록 🐕")
        let petProfileSection = HomeSection.myPetList
        
        // 섹션 등록
        snapshot.appendSections([petProfileSection, strollHistorySection])
        
        // 아이템 등록
        snapshot.appendItems(petItems, toSection: petProfileSection)
        snapshot.appendItems(items, toSection: strollHistorySection)
        
        
        datasource.apply(snapshot, animatingDifferences: false)
    }
    
}
