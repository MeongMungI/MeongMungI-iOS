//
//  BoardSelectionViewController.swift
//  MeongMungI
//
//  Created by 7aeHoon on 6/19/25.
//

import UIKit
import RxSwift
import RxCocoa

// MARK: - 사용자가 커뮤니티의 게시판 유형을 선택하기 위한 뷰 컨트롤러
public final class BoardSelectionViewController: UIViewController {
    private let boardSelectionView = BoardSelectionView()
    private let disposeBag = DisposeBag()
    // 선택된 게시판 타입을 이전 화면에 전달하기 위한 클로저
    public var didSelectBoard: ((String) -> Void)?
    private lazy var boardsBehaviorRelay = BehaviorRelay<[(title: String, desc: String)]>(value: allBoards)
    // 모든 게시판 종류
    private let allBoards: [(title: String, desc: String)] = [
        ("💬 자유", "어떤 주제든 편하게 얘기를 나눠보세요"),
        ("🐾 산책인증", "반려동물과의 산책 사진과 후기를 기록해보세요"),
        ("💡 정보공유", "유용한 꿀팁과 정보를 서로 공유하고 배워가세요"),
        ("❓ 질문", "궁금한 점을 자유롭게 물어보고 해결해보세요")

    ]

    // MARK: - loadView
    public override func loadView() {
        self.view = boardSelectionView
    }
    
    // MARK: - viewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()
        bindTableView()
    }
    
    // MARK: - 테이블 뷰 바인딩
    private func bindTableView() {
        // 게시판의 타입 아이템을 테이블 뷰 셀로 바인딩
        boardsBehaviorRelay
            .asDriver(onErrorDriveWith: .empty())
            .drive(boardSelectionView.boardTableView.rx.items(
                cellIdentifier: BoardTableViewCell.ID,
                cellType: BoardTableViewCell.self
            )) { [weak self] row, element, cell in
                guard let self = self else { return }
                cell.configure(title: element.title, desc: element.desc)
                // 마지막 셀일 경우
                let isLastCell = row == (self.boardsBehaviorRelay.value.count - 1)
                cell.setBottomSpacing(isLastCell ? 0 : BoardTableViewCell.bottomInset)
            }
            .disposed(by: disposeBag)
        
        // 게시판이 선택됬을 때 선택된 게시판 타입을 전달하고 이전 화면으로 이동
        boardSelectionView.boardTableView.rx
            .modelSelected((title: String, desc: String).self)
            .withUnretained(self)
            .subscribe(onNext: { owner, board in
                self.didSelectBoard?(board.title)
                self.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }
}
