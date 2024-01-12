//
//  AffirmationRepositoryError.swift
//  Affirmations
//
//  Created by Andrew McGee on 12/01/2024.
//

import Foundation

enum AffirmationRepositoryError: Error {
    case fetchFailure
    case decodeFailure
}
