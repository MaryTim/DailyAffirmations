//
//  FavouriteAffirmationsView.swift
//  Affirmations
//
//  Created by Maria Budkevich on 06/01/2024.
//

import SwiftUI
import SwiftData

struct FavouriteAffirmationsView: View {
    
    private let text: String = "You don't have any favourites yet."
    @Environment (\.modelContext) private var modelContext
    @Query private var favoriteAffrimations: [Affirmation]
    
    var body: some View {
        ZStack {
            if favoriteAffrimations.isEmpty {
                Text(text)
                    .foregroundColor(.brown)
                    .font(.custom("Merienda-SemiBold", size: 18))
            } else {
                List {
                    ForEach(favoriteAffrimations) { affirmation in
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
}

extension FavouriteAffirmationsView {
    private func removeFromFavourites(_ indexSet: IndexSet) {
        for index in indexSet {
            let affirmation = favoriteAffrimations[index]
            affirmation.isSelected = false
            modelContext.delete(affirmation)
        }
    }
}
