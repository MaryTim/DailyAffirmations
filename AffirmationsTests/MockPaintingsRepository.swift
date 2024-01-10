//
//  MockPaintingsRepository.swift
//  ArtsInfoTests
//
//  Created by Maria Budkevich on 24/11/2023.
//

import Foundation
@testable import Affirmations

struct MockAffirmationsRepository: AffirmationsRepository {
    let shouldFail: Bool
    
    func fetchAffirmation() async throws -> AffirmationResponse {
        if shouldFail {
            throw MockError.mockError
        } else {
            return AffirmationResponse(affirmation: "affirmation")
        }
    }
}


