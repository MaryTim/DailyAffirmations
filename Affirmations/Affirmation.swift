//
//  Affirmation.swift
//  Affirmations
//
//  Created by Maria Budkevich on 07/01/2024.
//

import Foundation
import SwiftData

@Model
class Affirmation {
   
    @Attribute(.unique) var text: String
    var id: UUID
    var isSelected: Bool
    
    init(text: String = "", id: UUID = UUID(), isSelected: Bool = false) {
        self.text = text
        self.id = id
        self.isSelected = isSelected
    }
}
