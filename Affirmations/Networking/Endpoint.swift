//
//  File.swift
//  
//
//  Created by Maria Budkevich on 17/11/2023.
//

import Foundation

public protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var queryItems: [String : String?]? { get }
    var httpMethod: HttpMethod { get }
    var headerFields: [String : String]? { get }
    var body: Data? { get }
}

extension Endpoint {
    func makeUrl() -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = queryItems?.map({
            URLQueryItem(name: $0, value: $1)
        })
        guard let url = urlComponents.url else {
            fatalError()
        }
        return url
    }
    
    func makeUrlRequest() -> URLRequest {
        let url = makeUrl()
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = headerFields
        urlRequest.httpBody = body
        return urlRequest
    }
}
