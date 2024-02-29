//
//  UserController.swift
//  LifeHacks
//
//  Created by Shireesh Marla on 26/02/2024.
//

import Foundation

 class UserController: ObservableObject {
    @Published private(set) var mainUser: User
    
    private let persistenceController: PersistenceController!
    
    init(mainUser: User, persistenceController: PersistenceController) {
        self.mainUser = mainUser
        self.persistenceController = persistenceController
    }
    
    private init(mainUser: User) {
        self.mainUser = mainUser
        self.persistenceController = nil
    }
    
    func save(name: String, aboutMe: String, profilePicture: Data?) throws {
        mainUser.name = name
        mainUser.aboutMe = aboutMe
        if let profilePicture {
            mainUser.profileImageURL = try persistenceController.saveProfileImageData(data: profilePicture)
        }
        persistenceController.save(user: mainUser)
    }
}

extension UserController {
    class Preview: UserController {
        override init(mainUser: User) {
            super.init(mainUser: mainUser)
        }
        
        override func save(name: String, aboutMe: String, profilePicture: Data?) throws {
            mainUser.name = name
            mainUser.aboutMe = aboutMe
        }
    }
}
