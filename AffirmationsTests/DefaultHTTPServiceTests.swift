//
//  Temp.swift
//  
//
//  Created by Maria Budkevich on 22/12/2023.
//

import XCTest
@testable import Affirmations

final class DefaultHTTPServiceTests: XCTestCase {

    var sut: DefaultHTTPService!
    
    override func setUp() {
        sut = DefaultHTTPService(urlSession: MockURLSession(shouldThrowError: false))
    }

    override func tearDown() {
        sut = nil
    }
    
    func testFetchDataReturnsData() async throws {
        var expectedResult: Data?
        do {
            expectedResult = try await sut.fetchData(for: MockEndpoint())
        } catch {
            XCTFail()
        }
        XCTAssertNotNil(expectedResult)
    }
    
    func testFetchDataThrowsError() async throws {
        sut = DefaultHTTPService(urlSession: MockURLSession(shouldThrowError: true))
        var expectedError: MockError?
        do {
            let _ = try await sut.fetchData(for: MockEndpoint())
        } catch {
            expectedError = error as? MockError
        }
        XCTAssertNotNil(expectedError)
    }
}
