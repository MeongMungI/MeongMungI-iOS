//
//  Endpoint.swift
//  MeongMungI
//
//  Created by 7aeHoon on 7/3/25.
//

import Foundation

import Alamofire

protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
}
