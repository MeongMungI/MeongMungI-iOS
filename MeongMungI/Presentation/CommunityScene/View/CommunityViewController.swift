//
//  CommunityViewController.swift
//  MeongMungI
//
//  Created by 7aeHoon on 3/18/25.
//

import UIKit

import Pageboy
import RxSwift
import RxCocoa
import Tabman

/// 사용자에게 커뮤니티 기능을 제공하는 뷰 컨트롤러
public final class CommunityViewController: TabmanViewController {
    private let communityView = CommunityView()
    /// 상단 탭바에 들어갈 페이지
    private var pages = [UIViewController]()
    private let disposeBag = DisposeBag()
    
    // MARK: - View
    
    public override func loadView() {
        self.view = communityView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupNavi()
        setupPages()
        setupTMBarButton()
        setupDelegate()
        configureBackBarButtonItem()
        bindUI()
        // 페이지 간 스와이프 제거
        self.isScrollEnabled = false
    }
    
    // MARK: - 네비게이션 관련 설정
    private func setupNavi() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: communityView.titleLabel)
        self.navigationItem.rightBarButtonItem =  UIBarButtonItem(customView: communityView.searchButton)
    }
    
    // MARK: - Delegate 설정
    private func setupDelegate() {
        self.dataSource = self
    }
    
    // MARK: - UI 바인드 설정
    private func bindUI() {
        communityView.floatingButton.rx.tap
            .withUnretained(self)
            .subscribe(
                onNext: {
                    owner, _ in
                    let postEditorViewController = PostEditorViewController()
                    postEditorViewController.hidesBottomBarWhenPushed = true
                    owner.navigationController?.pushViewController(postEditorViewController, animated: true)
                }
            )
            .disposed(by: disposeBag)
    }
}

// MARK: - PageboyViewControllerDataSource 확장

extension CommunityViewController: PageboyViewControllerDataSource {
    // 페이지 수
    public func numberOfViewControllers(
        in pageboyViewController: Pageboy.PageboyViewController
    ) -> Int {
        return pages.count
    }
    
    // index에 따른 페이지 설정
    public func viewController(
        for pageboyViewController: Pageboy.PageboyViewController,
        at index: Pageboy.PageboyViewController.PageIndex
    ) -> UIViewController? {
        return pages[index]
    }
    
    // 기본 페이지 설정
    public func defaultPage(
        for pageboyViewController: Pageboy.PageboyViewController)
    -> Pageboy.PageboyViewController.Page? {
        return nil
    }
}

// MARK: - TMBarDataSource 확장

extension CommunityViewController: TMBarDataSource {
    /// 바 아이템의 타이틀 설정
    public func barItem(
        for bar: any Tabman.TMBar,
        at index: Int) -> any Tabman.TMBarItemable {
            let boardType = Post.BoardType.allCases[index]
            let boardTitle = boardType.rawValue
            return  TMBarItem(title: boardTitle)
    }
    
    /// 게시판 타입에 따른 페이지에 사용할 뷰 컨트롤러 설정
    private func setupPages() {
        pages = Post.BoardType
            .allCases
            .map {
                let postListViewContoller = PostListViewController(boardType: $0)
                return postListViewContoller
            }
    }
    
    /// 바 버튼 커스텀
    private func setupTMBarButton() {
        let bar = TMBar.ButtonBar()
        // 바의 정렬 상태
        bar.layout.alignment = .leading
        // 탭바 버튼 간격
        bar.layout.interButtonSpacing = 40
        // 탭바 여백 설정
        bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 5.0, right: 20.0)
//        bar.layout.contentMode = .fit
        bar.layout.transitionStyle = .snap
        // 블러 효과 제거
        bar.backgroundView.style = .clear
        // 색상
        bar.backgroundColor = .white
        // 두께
        bar.indicator.weight = .custom(value: 3)
        // 색상
        bar.indicator.tintColor = .primaryTextColor
        // 가장자리에서 인디케이터의 바운스 효과
        bar.indicator.overscrollBehavior = .bounce
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
        addBar(bar, dataSource: self, at: .top)
    }
}
