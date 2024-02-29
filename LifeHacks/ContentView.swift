//
//  ContentView.swift
//  LifeHacks
//
//  Created by Shireesh Marla on 06/02/2024.
//

import SwiftUI

struct ContentView: View {
//    @State private var user: User = .preview
    @EnvironmentObject private var userController: UserController
    
    var body: some View {
        VStack {
            TabView {
                NavigationStack {
                    TopQuestionsView()
                }
                .tabItem { Label("Top Questions", systemImage: "list.number") }
              
                NavigationStack {
                    ProfileView(user: userController.mainUser)
                }
                .tabItem { Label("Profile", systemImage: "person.circle") }
                NavigationStack {
                    SettingsView()
                }
                .tabItem { Label("Settings", systemImage: "gear") }
            }
          
        }
    }
}

#Preview {
    ContentView()
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .theme(.vibrant)
            .tint(Theme.vibrant.accentColor)
    }
}
