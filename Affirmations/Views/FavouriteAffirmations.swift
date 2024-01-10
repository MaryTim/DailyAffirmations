//
//  FavouriteAffirmations.swift
//  Affirmations
//
//  Created by Maria Budkevich on 06/01/2024.
//

import SwiftUI
import SwiftData

struct FavouriteAffirmations: View {
    
    private let text: String = "You don't have any favourites yet."
    @Environment (\.modelContext) var modelContext
    @Query var favAffrimations: [Affirmation]
    
    var body: some View {
        ZStack {
            if favAffrimations.isEmpty {
                Text(text)
                    .foregroundColor(.brown)
                    .font(.custom("Merienda-SemiBold", size: 18))
            } else {
                List {
                    ForEach(favAffrimations) { affirmation in
                        FavoutitesAffirmationsCell(affirmationText: affirmation.text)
                            .frame(maxWidth: .infinity)
                            .listRowSeparator(.hidden)
                    }
                    .onDelete(perform: removeFromFavourites)
                }
                .frame(maxWidth: .infinity)
                .edgesIgnoringSafeArea(.horizontal)
                .listStyle(.grouped)
                .scrollContentBackground(.hidden)
                .background(Color.listBackground)
            }
        }
    }
    
    func removeFromFavourites(_ indexSet: IndexSet) {
        for index in indexSet {
            let affirmation = favAffrimations[index]
            affirmation.isSelected = false
            modelContext.delete(affirmation)
        }
    }
}
