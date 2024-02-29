//
//  EditProfileViewModel.swift
//  LifeHacks
//
//  Created by Shireesh Marla on 27/02/2024.
//

import SwiftUI
import  PhotosUI

extension EditProfileView {
    @MainActor final class Model: ObservableObject {
        @Published var name: String
        @Published var aboutMe: String
        @Published var profileImageData: Data?
        
        @Published var photosItem: PhotosPickerItem? {
            didSet {
                Task {
                    guard let photosItem else { return }
                    profileImageData = try? await photosItem.loadTransferable(type: Data.self)
                }
            }
        }
        
        let user: User
        
        var isContentEdited: Bool {
            photosItem != nil
            || name != user.name
            || aboutMe != user.aboutMe
        }
        
        var profileImageURL: URL? {
            guard let profileImageData else { return user.profileImageURL }
            let dataString = profileImageData.base64EncodedString()
            return URL(string: "data:image/png;base64," + dataString)
        }
        
        init(user: User){
            self.user = user
            self.name = user.name
            self.aboutMe = user.aboutMe ?? ""
        }
    }
}
