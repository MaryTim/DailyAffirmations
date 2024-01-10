//
//  CardFront.swift
//  Affirmations
//
//  Created by Maria Budkevich on 06/01/2024.
//

import SwiftUI

struct CardFront: View {
    
    @Binding var affirmationText: String
    @Binding var degree: Double
    @Binding var isFlipped: Bool
    @Binding var animationAmount: Double

    var body: some View {
        ZStack(alignment: .center) {
            Image("front")
                .resizable()
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.brown, lineWidth: 2).opacity(0.7)
                )
                .rotation3DEffect (Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))


            if isFlipped {
                Text(affirmationText)
                    .font(.custom("Merienda-SemiBold", size: 18))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.brown)
                    .opacity(animationAmount)
                    .scaleEffect(animationAmount)
                    .animation(
                        .easeInOut(duration: 2)
                            .delay(1),
                        value: animationAmount
                    )
                    .padding(.horizontal, 40)
            }
        }
    }
}
