//
//  ProfileViewModel.swift
//  LifeHacks
//
//  Created by Shireesh Marla on 27/02/2024.
//

import Foundation

extension ProfileView {
    @MainActor class Model: ObservableObject {
        @Published var user: User
        @Published var isLoading = false
        @Published var showError = false
        
        init(user: User) {
            self.user = user
        }
        
        func loadAboutMe() async {
            isLoading = true
            defer { isLoading =  false }
            let url = URL.apiRequestURL(path: "/users/\(user.id)", parameters: [
                "filter": "!0Z-PEqoVRJE6GxDr1Gdbi.GPf"
            ])
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let wrapper = try JSONDecoder.apiDecoder.decode(User.Wrapper.self, from: data)
                user.aboutMe = wrapper.items[0].aboutMe
            } catch {
                showError = true
            }
        }
    }
}

extension ProfileView.Model {
    class Preview: ProfileView.Model {
        override func loadAboutMe() async {
            user.aboutMe = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
        }
    }
}
