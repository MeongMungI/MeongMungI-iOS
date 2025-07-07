//
//  AllPostsViewController.swift
//  MeongMungI
//
//  Created by 7aeHoon on 6/15/25.
//

import UIKit
import RxSwift
import RxCocoa

// MARK: - 게시판 타입에 따른 게시글 리스트를 보여주기 위한 뷰 컨트롤러
public final class PostListViewController: UIViewController {
    // 게시판 타입
    private let boardType: Post.BoardType
    private let postListView = PostListView()
    private let disposeBag = DisposeBag()
    private let posts: [Post] = [
        
        // 10분 전
        Post(
            id: "5",
            boardType: .all,
            title: "📸 반려견 사진 한 장씩 올려요!",
            content: "우리 집 댕댕이 자랑합니다 :)",
            authorID: "photoLover",
            authorNickName: "해피가족",
            createdAt: Date(),
            likesCount: 73,
            commentsCount: 44,
            imageURLs: ["cat3"]
        ),
        
        // 3시간 전
        Post(
            id: "8",
            boardType: .all,
            title: "비 오는 날 산책 대신 실내 놀이 추천 ☔️",
            content: "노즈워크 매트랑 지능형 장난감이 좋더라고요. 다른 추천 있으신가요?",
            authorID: "rainyday",
            authorNickName: "비오는날",
            createdAt: Date(timeIntervalSinceNow: -60 * 60 * 3),
            likesCount: 36,
            commentsCount: 18,
            imageURLs: []
        ),
        
        // 6시간 전
        Post(
            id: "2",
            boardType: .question,
            title: "강아지가 사료를 안 먹어요 😢",
            content: "사료를 바꿔도 거부하네요. 같은 경험 있으신 분 계신가요?",
            authorID: "puppyParent01",
            authorNickName: "콩이맘",
            createdAt: Date(timeIntervalSinceNow: -60 * 60 * 6),
            likesCount: 17,
            commentsCount: 12,
            imageURLs: ["cat1"]
        ),
        
        // 12시간 전
        Post(
            id: "6",
            boardType: .walking,
            title: "부산 해운대 새벽 산책 후기 🏖️",
            content: "새벽 5시에 가면 사람도 적고 시원해요! 모래 조심만 하면 굿!",
            authorID: "busanWalker",
            authorNickName: "해운대친구",
            createdAt: Date(timeIntervalSinceNow: -60 * 60 * 12),
            likesCount: 33,
            commentsCount: 9,
            imageURLs: ["cat4"]
        ),
        
        // 20시간 전
        Post(
            id: "10",
            boardType: .question,
            title: "강아지 샴푸 추천해주세요 🛁",
            content: "피부가 약한 편이라 순한 제품 찾고 있어요!",
            authorID: "sensitiveSkin",
            authorNickName: "솜사탕집사",
            createdAt: Date(timeIntervalSinceNow: -60 * 60 * 20),
            likesCount: 0,
            commentsCount: 14,
            imageURLs: []
        ),
        
        // 1일 전
        Post(
            id: "3",
            boardType: .walking,
            title: "오늘 한강 산책 코스 추천해요 🚶‍♀️",
            content: "뚝섬 → 서울숲 코스, 강아지들이 정말 좋아해요!",
            authorID: "dailystroll",
            authorNickName: "산책러",
            createdAt: Date(timeIntervalSinceNow: -60 * 60 * 24),
            likesCount: 58,
            commentsCount: 21,
            imageURLs: ["cat2"]
        ),
        
        // 30시간 전
        Post(
            id: "9",
            boardType: .walking,
            title: "양재천 야간 산책로",
            content: "조명이 예뻐서 밤에도 안전하게 산책할 수 있어요.",
            authorID: "nightwalker",
            authorNickName: "밤산책러",
            createdAt: Date(timeIntervalSinceNow: -60 * 60 * 30),
            likesCount: 14,
            commentsCount: 0,
            imageURLs: ["yangjae_night1"]
        ),
        
        // 33시간 전
        Post(
            id: "4",
            boardType: .question,
            title: "배변패드 냄새 제거 팁 있을까요?",
            content: "환기해도 약간 냄새가 남아요. 실내 탈취 방법 공유 부탁드려요.",
            authorID: "sniffsniff",
            authorNickName: "복돌이아빠",
            createdAt: Date(timeIntervalSinceNow: -60 * 60 * 33),
            likesCount: 11,
            commentsCount: 6,
            imageURLs: []
        ),
        
        // 2일 전
        Post(
            id: "7",
            boardType: .question,
            title: "중성화 수술 후 밥 양 조절 어떻게 하세요?",
            content: "수술했더니 살이 금방 오르네요. 급식량 팁 부탁드려요.",
            authorID: "carefulDad",
            authorNickName: "초코아빠",
            createdAt: Date(timeIntervalSinceNow: -60 * 60 * 48),
            likesCount: 24,
            commentsCount: 13,
            imageURLs: []
        ),
        
        Post(
            id: "11",
            boardType: .all,
            title: "작년 여름 추억 사진 🌞",
            content: "2024년 7월 1일에 찍은 한강 썸머 피크닉! 지금 보니 또 가고 싶네요.",
            authorID: "nostalgia",
            authorNickName: "추억회상러",
            createdAt: Calendar.current.date(from: DateComponents(year: 2024, month: 7, day: 1)) ?? .distantPast,
            likesCount: 52,
            commentsCount: 27,
            imageURLs: ["summer2024_1", "summer2024_2"]
        )
    ]

    private lazy var postsBehaviorRelay = BehaviorRelay<[Post]>(value: posts)
    
    // MARK: - init
    
    init(boardType: Post.BoardType) {
        self.boardType = boardType
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View
    
    public override func loadView() {
        self.view = postListView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        bindTableView()
    }
    
    // MARK: - Actions
    
    private func bindTableView() {
        postsBehaviorRelay
            .asDriver(onErrorDriveWith: .empty())
            .drive(postListView.tableView.rx.items(
                cellIdentifier: PostListTableViewCell.ID,
                cellType:  PostListTableViewCell.self)
            ) { row, element, cell in
                cell.configure(with: element)
            }
            .disposed(by: disposeBag)
    }
    
    private func tapped() {
        
    }


}
