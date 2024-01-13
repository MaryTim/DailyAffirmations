//
//  ContentView.swift
//  Affirmations
//
//  Created by Maria Budkevich on 05/01/2024.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    private let repository: AffirmationsRepository
    @Binding private var navigationPath: [Route]
    
    @Environment(\.modelContext) private var modelContext
    
    @Query private var favoriteAffrimations: [Affirmation]
    
    @State private var affirmationText: String = ""
    @State private var backDegree = 0.0
    @State private var frontDegree = -90.0
    @State private var isFlipped = false
    @State private var isFavorite: Bool = false
    @State private var shareIsPressed: Bool = false
    @State private var isShowingError: Bool = false
    @State private var animationAmount = 0.0
    
    private let durationAndDelay : CGFloat = 0.5
    
    init(
        repository: AffirmationsRepository = DefaultAffirmationsRepository(),
        navigationPath: Binding<[Route]>
    ) {
        self.repository = repository
        self._navigationPath = navigationPath
    }
    
    var body: some View {
        ZStack {
            Color.screenBackground
                .opacity(0.5)
                .ignoresSafeArea()
            
            VStack(spacing: 50) {
                cardSection
                buttonSection
            }
            .padding(40)
            .onAppear(perform: {
                self.shareIsPressed = false
                self.isFavorite = favoriteAffrimations.contains { $0.text == affirmationText }
            })
        }
        .toolbar {
            Button {
                navigationPath.append(Route.favourites)
            } label: {
                Image(systemName: Asset.Image.bulletList)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.brown)
            }
        }
    }
    
    var cardSection: some View {
        ZStack {
            CardFront(affirmationText: $affirmationText,
                      degree: $frontDegree,
                      isFlipped: $isFlipped,
                      animationAmount: $animationAmount)
            
            CardBack(degree: $backDegree)
        }
        .onTapGesture {
            flipCard()
            if isFlipped {
                Task {
                    animationAmount = 1.0
                    do {
                        affirmationText = try await repository.fetchAffirmation().affirmation
                    } catch {
                        isShowingError = true
                    }
                }
            } else {
                affirmationText = ""
                animationAmount = 0.0
                isFavorite = false
            }
        }
        .alert("Something went wrong...", isPresented: $isShowingError) {
            Button {
                Task {
                    do {
                        affirmationText = try await repository.fetchAffirmation().affirmation
                    } catch {
                        isShowingError = true
                    }
                }
            } label: {
                Text("Try again")
            }
        }
    }
    
    var buttonSection: some View {
        HStack(alignment: .center, spacing: 60) {
            Button {
                updateFavorites()
            } label: {
                Image(systemName: isFavorite ? Asset.Image.heartFill : Asset.Image.heart)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.brown)
                
            }
            .opacity(affirmationText.isEmpty ? 0 : 1).animation(.linear(duration: 0.3))
            .contentTransition(.symbolEffect(.replace))
            
            ShareLink(item: affirmationText) {
                // later add a link to the app
                Image(systemName: shareIsPressed ? Asset.Image.arrowUpFill : Asset.Image.arrowUp)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.brown)
            }
            .contentTransition(.symbolEffect(.replace))
            .onTapGesture {
                shareIsPressed = true
            }
            .opacity(affirmationText.isEmpty ? 0 : 1).animation(.linear(duration: 0.3))
        }
    }
}

extension HomeView {
    private func flipCard() {
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
    
    private func updateFavorites() {
        withAnimation {
            self.isFavorite.toggle()
        }
        
        if isFavorite {
            if let first = favoriteAffrimations.first(where: { $0.text == affirmationText }) { } else {
                let affirmation = Affirmation(text: affirmationText, isSelected: true)
                modelContext.insert(affirmation)
            }
        } else {
            if let first = favoriteAffrimations.first(where: { $0.text == affirmationText }) {
                modelContext.delete(first)
            }
        }
    }
}
