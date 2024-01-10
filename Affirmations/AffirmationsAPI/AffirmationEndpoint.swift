//
//  AffirmationEndpoint.swift
//  Affirmations
//
//  Created by Maria Budkevich on 05/01/2024.
//

import Foundation

enum AffirmationEndpoint: Endpoint {
    
    case affirmation
    
    var scheme: String {
        return "https"
    }
    
    var host: String {
        "www.affirmations.dev"
    }
    
    var path: String {
        switch self {
        case .affirmation:
            return "/"
        }
    }
    
    var queryItems: [String : String?]? {
        switch self {
        case .affirmation:
            nil
        }
    }
    
    var httpMethod: HttpMethod {
        switch self {
        case .affirmation:
            return .get
        }
    }
    
    var headerFields: [String : String]? {
        switch self {
        case .affirmation:
            return ["Accept" : "application/json"]
        }
    }
    
    var body: Data? {
        switch self {
        case .affirmation:
            nil
        }
    }
}
