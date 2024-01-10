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

struct DefaultAffirmationsRepository: AffirmationsRepository {
    
    let httpService: HTTPService
    
    func fetchAffirmation() async throws -> AffirmationResponse {
        let data = try await fetchData()
        return try decode(data: data)
    }
}

extension DefaultAffirmationsRepository {
    private func fetchData() async throws -> Data {
        do {
            return try await httpService.fetchData(for: AffirmationEndpoint.affirmation)
        } catch {
            throw AffirmationRepositoryError.fetchFailure
        }
    }
    
    private func decode(data: Data) throws -> AffirmationResponse {
        do {
            let jsonDecoder = JSONDecoder()
            return try jsonDecoder.decode(AffirmationResponse.self, from: data)
        } catch {
            throw AffirmationRepositoryError.decodeFailure
        }
    }
}

enum AffirmationRepositoryError: Error {
    case fetchFailure
    case decodeFailure
}
