//
//  AffirmationsApp.swift
//  Affirmations
//
//  Created by Maria Budkevich on 05/01/2024.
//

import SwiftUI
import SwiftData

@main
struct AffirmationsApp: App {
    
    @State private var navigationPath = [Route]()
    private let modelContainer: ModelContainer
    
    init() {
        do {
            modelContainer = try ModelContainer(for: Affirmation.self)
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigationPath) {
                HomeView(navigationPath: $navigationPath)
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .favourites:
                            FavouriteAffirmationsView()
                        }
                    }
                
            }
            .accentColor(.brown)
            .modelContainer(modelContainer)
        }
    }
}
