//
//  CardBack.swift
//  Affirmations
//
//  Created by Maria Budkevich on 06/01/2024.
//

import SwiftUI

struct CardBack: View {
    
    @Binding var degree: Double
    
    var body: some View {
        Image("cardsBack")
            .resizable()
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.brown, lineWidth: 2).opacity(0.7)
            )
            . rotation3DEffect (Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}
