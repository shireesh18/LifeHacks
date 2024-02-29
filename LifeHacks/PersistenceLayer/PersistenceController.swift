//
//  PersistenceController.swift
//  LifeHacks
//
//  Created by Shireesh Marla on 26/02/2024.
//

import Foundation

final class PersistenceController {
    func save(questions: [Question]) {
        guard let data = try? JSONEncoder().encode(questions) else { return }
        try? data.write(to: .jsonFileURLNamed(.questions))
    }
    
    func fetchQuestions() -> [Question]? {
        guard let data = try? Data(contentsOf: .jsonFileURLNamed(.questions)) else { return nil }
        return try? JSONDecoder().decode([Question].self, from: data)
    }
    
    func save(user: User) {
        guard let data = try? JSONEncoder().encode(user) else { return }
        try? data.write(to: .jsonFileURLNamed(.user))
    }
    
    func fetchUser() -> User? {
        guard let data = try? Data(contentsOf: .jsonFileURLNamed(.user)) else { return nil }
        return try? JSONDecoder().decode(User.self, from: data)
    }
    
    func saveProfileImageData(data: Data) throws -> URL {
        let url = URL.fileURL(name: .profilePicture, extension: "jpeg")
        try data.write(to: url)
        return url
    }
        
}

private extension String {
    static var questions: String { "Questions"}
    static var user: String { "User" }
    static var profilePicture: String { "ProfilePicture" }
}

private extension URL {
    
    static func jsonFileURLNamed(_ name: String) -> URL {
        fileURL(name: name, extension: "json")
    }
    
    static func fileURL(name: String, extension: String) -> URL {
        URL.documentsDirectory
            .appendingPathComponent(name)
            .appendingPathExtension(`extension`)
    }
    
}
