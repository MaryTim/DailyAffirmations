//
//  FavoutitesAffirmationsCellView.swift
//  Affirmations
//
//  Created by Maria Budkevich on 06/01/2024.
//

import SwiftUI

struct FavoutitesAffirmationsCellView: View {
    
    let affirmationText: String
    
    var body: some View {
        ZStack {
            Color.screenBackground.opacity(0.5)
                
            Text(affirmationText)
                .foregroundColor(.brown)
                .multilineTextAlignment(.leading)
                .font(.custom(Asset.Font.customFont, size: 16))
                
                .padding(.vertical, 20)
                .padding(.horizontal, 15)
                
        }
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.brown, lineWidth: 2).opacity(0.7)
        )
    }
}
