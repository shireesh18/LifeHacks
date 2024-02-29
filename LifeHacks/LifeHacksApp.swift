//
//  LifeHacksApp.swift
//  LifeHacks
//
//  Created by Shireesh Marla on 06/02/2024.
//

import SwiftUI

@main
struct LifeHacksApp: App {
//    @State private var theme: Theme = .vibrant
    @StateObject private var settingsContoller = SettingsController()
    @StateObject private var userController: UserController
    @StateObject private var questionsContoller: QuestionsController
    
    init() {
        let persistenceContoller = PersistenceController()
        self._userController = .init(wrappedValue: UserController(mainUser: .preview, persistenceController: persistenceContoller))
        self._questionsContoller = .init(wrappedValue: QuestionsController(persistenceContoller: persistenceContoller))
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .theme(settingsContoller.theme)
                .tint(settingsContoller.theme.accentColor)
                .environmentObject(settingsContoller)
                .environmentObject(questionsContoller)
                .environmentObject(userController)
        }
    }
}

