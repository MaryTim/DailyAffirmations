//
//  MockHTTPService.swift
//  ArtsInfoTests
//
//  Created by Maria Budkevich on 06/12/2023.
//


import Foundation
@testable import Affirmations

struct MockHTTPService: HTTPService {
    
    func fetchData<T>(for endpoint: T) async throws -> Data where T : Endpoint {
        let mockModel = AffirmationResponse.stub
        let encoder = JSONEncoder()
        return try encoder.encode(mockModel)
    }
}

struct MockFetchingFailureHTTPService: HTTPService {
    func fetchData<T>(for endpoint: T) async throws -> Data where T : Endpoint {
        throw MockError.mockError
    }
}

struct MockDecodingFailureHTTPService: HTTPService {
    func fetchData<T>(for endpoint: T) async throws -> Data where T : Endpoint {
        return Data()
    }
}
