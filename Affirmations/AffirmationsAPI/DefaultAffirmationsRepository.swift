//
//  DefaultAffirmationsRepository.swift
//  Affirmations
//
//  Created by Andrew McGee on 12/01/2024.
//

import Foundation

struct DefaultAffirmationsRepository: AffirmationsRepository {
    
    let httpService: HTTPService
    
    init(httpService: HTTPService = DefaultHTTPService()) {
        self.httpService = httpService
    }
    
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
