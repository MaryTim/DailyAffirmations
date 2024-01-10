//
//  ContentView.swift
//  Affirmations
//
//  Created by Maria Budkevich on 05/01/2024.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    let repository: AffirmationsRepository
    @Binding var navigationPath: [Route]
    
    @State var affirmationText: String = ""
    @Environment (\.modelContext) var modelContext

    var affirmation: Affirmation = Affirmation()
    
    @State var backDegree = 0.0
    @State var frontDegree = -90.0
    @State var isFlipped = false
    let durationAndDelay : CGFloat = 0.5
    
    
    
    @State private var isFavorite: Bool = false
    @State private var goToFavourites: Bool = false
    @State private var shareIsPressed: Bool = false
    @State private var animationAmount = 0.0
    
    func flipCard() {
        self.isFlipped.toggle()
        if isFlipped {
            withAnimation(.linear(duration: durationAndDelay)) {
                self.backDegree = 90
            }
            withAnimation(.linear(duration: durationAndDelay).delay (durationAndDelay)) {
                self.frontDegree = 0
            }
        } else {
            withAnimation(.linear(duration: durationAndDelay)) {
                self.frontDegree = -90
            }
            withAnimation(.linear(duration: durationAndDelay).delay (durationAndDelay)) {
                self.backDegree = 0
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color("backgroundColor").opacity(0.4)
                .ignoresSafeArea()
            VStack(spacing: 50) {
                ZStack {
                    CardFront(affirmationText: $affirmationText,
                              degree: $frontDegree,
                              isFlipped: $isFlipped,
                              animationAmount: $animationAmount)
                    CardBack(degree: $backDegree)
                }
                .onTapGesture {
                    self.flipCard()
                    if isFlipped {
                        Task {
                            animationAmount = 1.0
                            do {
                                affirmationText = try await repository.fetchAffirmation().affirmation
                                affirmation.text = affirmationText
                            } catch {
                                affirmationText = "error"
                            }
                        }
                    } else {
                        affirmationText = ""
                        animationAmount = 0.0
                        isFavorite = false
                    }
                }
                
                HStack(alignment: .center, spacing: 60) {
                    
                    Button {
                        withAnimation {
                            self.isFavorite.toggle()
                        }
                        if isFavorite {
                          //  affirmation.isSelected = true
                            modelContext.insert(affirmation)
                        } else {
                           // affirmation.isSelected = false
                            modelContext.delete(affirmation)

                        }
                    } label: {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.brown)
                        
                    }
                    .disabled(affirmationText.isEmpty)
                    .contentTransition(.symbolEffect(.replace))

                    ShareLink(item: affirmationText) {
                        // later add a link to the app
                        Image(systemName: shareIsPressed ? "arrow.up.square.fill" : "arrow.up.square")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.brown)
                    }
                    .contentTransition(.symbolEffect(.replace))
                    .onTapGesture {
                        shareIsPressed = true
                    }
                    .disabled(affirmationText.isEmpty)
                    
                    Button {
                        withAnimation {
                            self.goToFavourites = true
                        }
                        navigationPath.append(Route.favourites)
                    } label: {
                        Image(systemName: goToFavourites ? "heart.circle.fill" : "heart.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.brown)
                    }
                    .contentTransition(.symbolEffect(.replace))
                }
            }
            .padding(40)
            .onAppear(perform: {
                self.goToFavourites = false
                self.shareIsPressed = false
               // self.isFavorite = affirmation.isSelected
            })
        }
    }
}
