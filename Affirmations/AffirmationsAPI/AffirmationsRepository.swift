//
//  AffirmationsRepository.swift
//  Affirmations
//
//  Created by Maria Budkevich on 05/01/2024.
//

import Foundation

protocol AffirmationsRepository {
    func fetchAffirmation() async throws -> AffirmationResponse
}
