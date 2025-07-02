//
//  Post.swift
//  MeongMungI
//
//  Created by 7aeHoon on 7/1/25.
//

import Foundation

// MARK: - 게시글 엔티티
public struct Post: Hashable, Identifiable {
    public typealias ID = String
    
    // MARK: - 게시글의 게시판 타입
    public enum BoardType: String, CaseIterable {
        case all = "전체"
        case free = "자유"
        case trending = "인기"
        case stroll = "산책인증"
        case info = "정보공유"
        case question = "질문"
    }
    
    public let id: ID // 게시글 아이디
    public let boardType: BoardType // 게시판 타입
    public let title: String // 제목
    public let content: String // 내용
    public let authorID: String // 작성자 아이디
    public let authorNickName: String // 작성자 닉네임
    public let createdAt: Date // 작성일
    public let likesCount: Int // 좋아요 수
    public let commentsCount: Int // 댓글 수
    public let imageURLs: [String] // 이미지
}



