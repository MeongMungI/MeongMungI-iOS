//
//  APIService.swift
//  MeongMungI
//
//  Created by 7aeHoon on 7/3/25.
//

import Foundation

import Alamofire
import RxSwift

protocol APIServiceProtocol {
    func request<T: Codable>(_ endpoint: Endpoint) -> Single<T>
}

final class APIService: APIServiceProtocol {
    private let baseURL = "여기에 주소를 입력 ..."
    
    func request<T: Codable>(_ endpoint: Endpoint) -> Single<T> {
        return Single.create { single in
            let url = self.baseURL + endpoint.path
            let req = AF
                .request(
                    url,
                    method: endpoint.method,
                    parameters: endpoint.parameters,
                    encoding: JSONEncoding.default
                )
                .validate()
                .responseDecodable(of: T.self) { res in
                    switch res.result {
                    case .success(let data):
                        single(.success(data))
                    case .failure(let error):
                        single(.failure(error))
                    }
                }
            return Disposables.create { req.cancel() }
        }
    }
}
