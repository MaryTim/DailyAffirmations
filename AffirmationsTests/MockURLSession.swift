//
//  File.swift
//  
//
//  Created by Maria Budkevich on 22/12/2023.
//

import Foundation
@testable import Affirmations

struct MockURLSession: URLSessionProtocol {
    
    let shouldThrowError: Bool
    
    func data(for request: URLRequest, delegate: (URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        if shouldThrowError {
            throw MockError.mockError
        } else {
            return (Data(), URLResponse())
        }
    }
}
