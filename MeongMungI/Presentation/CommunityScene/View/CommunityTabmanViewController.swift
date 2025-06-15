//
//  CommunityViewController.swift
//  MeongMungI
//
//  Created by 7aeHoon on 3/18/25.
//

import UIKit
import Pageboy
import Tabman
import RxSwift
import RxCocoa
import ReactorKit

// MARK: - 사용자에게 커뮤니티 기능을 제공하는 뷰 컨트롤러
public final class CommunityTabmanViewController: TabmanViewController {

    // 커뮤니티 커스텀 뷰
    private let communityView = CommunityView()
    
    private var pages = [UIViewController]()
    
    // MARK: - loadView
    public override func loadView() {
        self.view = communityView
    }
    
    // MARK: - viewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupNavi()
        setupPages()
        setupTMBarButton()
        setupDelegate()
        // 페이지 간 스와이프 제거
        self.isScrollEnabled = false
    }
    
    // MARK: - 네비게이션 관련 설정
    private func setupNavi() {
        // 네비게이션 왼쪽 바 버튼 아이템 설정
        self.navigationItem.leftBarButtonItem = communityView.leftBarButtonItem
    }
    
    // MARK: - 페이지에 사용할 뷰 컨트롤러 설정
    private func setupPages() {
        let allPostsViewController = AllPostsViewController()
        let freePostsViewController = FreePostsViewController()
        let trendingPostsViewController = TrendingPostsViewController()
        let strollPostsViewController = StrollPostsViewController()
        let infoSharePostsViewController = InfoSharePostsViewController()
        
        pages.append(allPostsViewController)
        pages.append(freePostsViewController)
        pages.append(trendingPostsViewController)
        pages.append(strollPostsViewController)
        pages.append(infoSharePostsViewController)
    }
    
    // MARK: - setupTMBarButton
    private func setupTMBarButton() {
        let bar = TMBar.ButtonBar()
        // 바의 정렬 상태
        bar.layout.alignment = .centerDistributed
        bar.layout.contentMode = .fit
        bar.layout.transitionStyle = .snap
        
        // MARK: - 배경 설정
        // 블러 효과 제거
        bar.backgroundView.style = .clear
        // 색상
        bar.backgroundColor = .white
        
        // MARK: - 버튼 설정
        bar.buttons.customize { bt in
            // 선택되지 않은 버튼 색상
            bt.tintColor = .tertiaryTextColor
            // 선택되지 않은 버튼 폰트
            bt.font = .pretendard(size: 15, family: .semiBold)
            // 선택된 버튼 색상
            bt.selectedTintColor = .primaryTextColor
            // 선택된 버튼 폰트
            bt.selectedFont = .pretendard(size: 15, family: .semiBold)
        }
        
        // MARK: - 인디케이터 설정
        // 두께
        bar.indicator.weight = .custom(value: 3)
        // 색상
        bar.indicator.tintColor = .primaryTextColor
        // 가장자리에서 인디케이터의 바운스 효과
        bar.indicator.overscrollBehavior = .bounce
        
        addBar(bar, dataSource: self, at: .top)
    }
    
    // MARK: - Delegate 설정
    private func setupDelegate() {
        self.dataSource = self
    }

}

// MARK: - PageboyViewControllerDataSource 확장
extension CommunityTabmanViewController: PageboyViewControllerDataSource {
    // 페이지 수
    public func numberOfViewControllers(in pageboyViewController: Pageboy.PageboyViewController) -> Int {
        return pages.count
    }
    
    // index에 따른 페이지 설정
    public func viewController(for pageboyViewController: Pageboy.PageboyViewController, at index: Pageboy.PageboyViewController.PageIndex) -> UIViewController? {
        return pages[index]
    }
    
    // 기본 페이지 설정
    public func defaultPage(for pageboyViewController: Pageboy.PageboyViewController) -> Pageboy.PageboyViewController.Page? {
        return nil
    }
}

// MARK: - TMBarDataSource 확장
extension CommunityTabmanViewController: TMBarDataSource {
    public func barItem(for bar: any Tabman.TMBar, at index: Int) -> any Tabman.TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "전체")
        case 1:
            return TMBarItem(title: "자유")
        case 2:
            return TMBarItem(title: "인기")
        case 3:
            return TMBarItem(title: "산책인증")
        case 4:
            return TMBarItem(title: "정보공유")
        default:
            return TMBarItem(title: "")
        }
    }
}
