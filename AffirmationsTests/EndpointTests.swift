//
//  EndpointTests.swift
//  
//
//  Created by Maria Budkevich on 22/12/2023.
//

import XCTest
@testable import Affirmations

final class EndpointTests: XCTestCase {

    var sut: Endpoint!
    
    override func setUp() {
        sut = MockEndpoint()
    }

    override func tearDown() {
        sut = nil
    }
    
    func testMakeUrlReturnsCorrectUrl() {
        let expectedURL = URL(string: "https://www.wikiart.org/en/api/2/MostViewedPaintings?key=value")!
        let result = sut.makeUrl()
        XCTAssertEqual(expectedURL, result)
    }
    
    func testMakeURLRequestReturnsURLRequest() {
        let result = sut.makeUrlRequest()
        XCTAssertEqual(result.httpMethod, "GET")
        XCTAssertEqual(result.url, URL(string: "https://www.wikiart.org/en/api/2/MostViewedPaintings?key=value")!)
        XCTAssertEqual(result.httpBody, "testString".data(using: .utf8))
        XCTAssertEqual(result.allHTTPHeaderFields, ["key": "value", "key1": "value1"])
    }
    
}
