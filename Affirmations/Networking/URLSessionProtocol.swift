//
//  File.swift
//  
//
//  Created by Maria Budkevich on 22/12/2023.
//

import Foundation

public protocol URLSessionProtocol {
    func data(for request: URLRequest, delegate: (URLSessionTaskDelegate)?) async throws -> (Data, URLResponse)
}
