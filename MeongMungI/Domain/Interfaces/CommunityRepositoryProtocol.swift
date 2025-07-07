//
//  PostRepositoryProtocol.swift
//  MeongMungI
//
//  Created by 7aeHoon on 7/3/25.
//

import Foundation

import RxSwift

// MARK: - 게시글 프로토콜(인터페이스)
protocol CommunityRepositoryProtocol {
    // MARK: - 게시글 생성
    func createPost()
    // MARK: - 게시글 조회
    func fetchList() -> Single<[PostDTO]>
    // MARK: - 게시글 수정
    func updatePost()
    // MARK: - 게시글 삭제
    func deletePost()
}
