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
    // 홈 커스텀 뷰
    private let homeView = HomeView()
    
    // 홈 화면을 관리하는 코디네이터
    weak var coordinator: HomeCoordinator?
    
    // 컬렉션 뷰 스냅샷 생성
    private var snapshot = NSDiffableDataSourceSnapshot<HomeSection, HomeSectionItem>()
    
    private let disposeBag = DisposeBag()
    
    // loadView
    public override func loadView() {
        self.view = homeView
    }
    
    // viewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBarButtonItem()
        applySnapshot()
    }
    
    // 네비게이션 바 버튼 아이템 설정
    private func configureNavBarButtonItem() {
        self.navigationItem.leftBarButtonItem = homeView.leftBarButtonItem
        self.navigationItem.rightBarButtonItem = homeView.rightBarButtonItem
    }
    
    // 컬렉션 뷰에 스냅샷 적용
    private func applySnapshot() {
        let items: [HomeSectionItem] = [.strollHistory(id: 0, image: .cat1), .strollHistory(id: 1, image: .cat2), .strollHistory(id: 2, image: .cat3)]
        
        let strollHistorySections = HomeSection.strollHistory("최근 산책기록")
        
        // 스냅샷에 지난 산책기록 섹션 등록
        snapshot.appendSections([strollHistorySections])
        
        // 지난 산책기록 섹션에 아이템 적용
        snapshot.appendItems(items, toSection: strollHistorySections)
        
        homeView.diffableDataSource.apply(snapshot, animatingDifferences: false)
    }
    

}
