//
//  File.swift
//  
//
//  Created by Maria Budkevich on 22/12/2023.
//

import Foundation
@testable import Affirmations

struct MockEndpoint: Endpoint {
    var scheme = "https"
    var host = "www.wikiart.org"
    var path = "/en/api/2/MostViewedPaintings"
    var queryItems: [String : String?]? = ["key": "value"]
    var httpMethod: HttpMethod = .get
    var headerFields: [String : String]? = ["key": "value", "key1": "value1"]
    var body: Data? = "testString".data(using: .utf8)
}
