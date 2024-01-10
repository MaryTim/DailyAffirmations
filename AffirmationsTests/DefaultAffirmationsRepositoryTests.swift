//
//  DefaultPaintingsRepositoryTests.swift
//  ArtsInfoTests
//
//  Created by Maria Budkevich on 06/12/2023.
//

import XCTest
@testable import Affirmations

final class DefaultAffirmationsRepositoryTests: XCTestCase {
    
    var sut: DefaultAffirmationsRepository!
    
    override func setUp() {
        sut = DefaultAffirmationsRepository(httpService: MockHTTPService())
    }

    override func tearDown() {
        sut = nil
    }
    
    func testFetchAffirmationReturnsValue() async throws {
        let model = try await sut.fetchAffirmation()
        XCTAssertEqual(model, .stub, "items didn't match")
    }
    
    func testFetchAffirmationThrowsFetchFailure() async throws {
        sut = DefaultAffirmationsRepository(httpService: MockFetchingFailureHTTPService())
        let expectedError = AffirmationRepositoryError.fetchFailure
        do {
            _ = try await sut.fetchAffirmation()
            XCTFail("we expected error to be thrown")
        } catch {
            XCTAssertEqual(expectedError, error as? AffirmationRepositoryError, "errors are of differnet type")
        }
    }
    
    func testFetchAffirmationThrowsDecodeFailure() async {
        sut = DefaultAffirmationsRepository(httpService: MockDecodingFailureHTTPService())
        let expectedFailure = AffirmationRepositoryError.decodeFailure
        do {
            _ = try await sut.fetchAffirmation()
            XCTFail("we expected error to be thrown")
        } catch {
            XCTAssertEqual(expectedFailure, error as? AffirmationRepositoryError, "errors are of differnet type")
        }
    }
}
