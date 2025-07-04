//
//  PostEndpoint.swift
//  MeongMungI
//
//  Created by 7aeHoon on 7/3/25.
//

import Foundation

import Alamofire

enum PostEndpoint: Endpoint {
    case list // 게시글 조회
    case create(parameters: Parameters) // 게시글 생성
    case update(parameters: Parameters) // 게시글 수정
    case delete // 게시글 삭제
    
    var path: String {
        switch self {
        case .list:               
            return "/posts"
        case .create:             
            return "/posts"
        case .update:
            return "/posts"
        case .delete:
            return "/posts"
        }
    }
    
    var method: HTTPMethod  {
        switch self {
        case .list:
            return .get
        case .create:
            return .post
        case .update:
            return .put
        case .delete:
            return .delete
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .create(let params):
            return params
        case .update(let params):
            return params
        default:
            return nil
        }
    }
}
