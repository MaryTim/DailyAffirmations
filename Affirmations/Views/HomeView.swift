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
    
    @Query var favAffrimations: [Affirmation]
    
    @State var backDegree = 0.0
    @State var frontDegree = -90.0
    @State var isFlipped = false
    let durationAndDelay : CGFloat = 0.5

    @State private var isFavorite: Bool = false
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
               // .shadow(radius: 10)
                .onTapGesture {
                    self.flipCard()
                    if isFlipped {
                        Task {
                            animationAmount = 1.0
                            do {
                                affirmationText = try await repository.fetchAffirmation().affirmation
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
                            let affirmation = Affirmation(text: affirmationText, isSelected: true)
                            modelContext.insert(affirmation)
                        } else {
                            if let first = favAffrimations.first(where: { $0.text == affirmationText }) {
                                modelContext.delete(first)
                            }
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
                    .opacity(affirmationText.isEmpty ? 0 : 1)
                }
            }
            .padding(40)
            .onAppear(perform: {
                self.shareIsPressed = false
                self.isFavorite = favAffrimations.contains { $0.text == affirmationText }
            })
        }
        .toolbar {
            Button {
                navigationPath.append(Route.favourites)
            } label: {
                Image(systemName: "list.bullet.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.brown)
            }
        }
    }
}
