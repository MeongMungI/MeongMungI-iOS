//
//  PostRepository.swift
//  MeongMungI
//
//  Created by 7aeHoon on 7/3/25.
//

import Foundation

import RxSwift

final class PostRepository: PostRepositoryProtocol {
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func createPost() {
    }
    
    func fetchList() -> Single<[PostResponseDTO]> {
        return apiService.request(PostEndpoint.list)
    }
    
    func updatePost() {
        print()
    }
    
    func deletePost() {
        print()
    }
}
