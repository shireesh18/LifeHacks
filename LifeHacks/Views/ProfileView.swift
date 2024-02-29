//
//  ProfileView.swift
//  LifeHacks
//
//  Created by Shireesh Marla on 21/02/2024.
//

import SwiftUI

struct ProfileView: View {
    let user: User
    
    @State private var isEditing = false
    @StateObject private var model: Model
    @EnvironmentObject private var userController: UserController
    
    init(user: User){
        self.user = user
        self._model = .init(wrappedValue: Model(user: user))
    }
    
    var body: some View {
        Content(user: displayedUser)
        .navigationTitle(Text("Profile"))
        .role(isMainUser ? .primary : .secondary)
        .loading(model.isLoading)
        .errorAlert(isPresented: $model.showError)
        .task {
            guard !isMainUser else { return }
            await model.loadAboutMe()
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                if isMainUser {
                    Button(action: {isEditing = true}){
                        Text("Edit")
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $isEditing){
            NavigationStack {
                EditProfileView(user: user, onEditingFinished: { isEditing = false })
            }
        }
    }
}

private extension ProfileView {
    var isMainUser: Bool {
        user.id == userController.mainUser.id
    }
    
    var displayedUser: User {
        isMainUser ? userController.mainUser : model.user
    }
}

extension ProfileView {
    struct Header: View {
        let name: String
        let reputation: Int
        let profileImageURL: URL?
//        let isMainUser: Bool
        
        var body: some View {
            VStack(spacing: 4.0) {
                AsyncProfileImage(url: profileImageURL)
                    .frame(width:144, height: 144)
                Text(name)
                    .font(.title)
                    .bold()
                    .padding(.top, 12.0)
                Text("\(reputation.formatted()) reputation")
                    .font(.headline)
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .padding([.top, .bottom], 24)
            .styled(isRounded: false)
        }
    }
}



extension ProfileView.Header {
    init(user: User){
        self.init(
            name: user.name,
            reputation: user.reputation,
            profileImageURL: user.profileImageURL
        )
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View{
        Group {
            let model = ProfileView.Model.Preview(user: .preview)
            let userController = UserController.Preview(mainUser: .preview) as UserController
            NavigationStack {
                ProfileView(user: .preview, model: model)
                    .environmentObject(userController)
            }
            VStack {
                ProfileView.Header(user: .preview)
                ProfileView.Header(user: .preview)
                    .role(.secondary)
            }
        }
    }
}

extension ProfileView {
    struct Content: View {
        let user: User
        
        var body: some View {
            ScrollView {
                ProfileView.Header(user: user)
                Text(user.aboutMe ?? "")
                    .padding(.top, 16.0)
                    .padding(.horizontal, 20.0)
            }
        }
    }
}

fileprivate extension ProfileView {
    init(user: User, model: Model){
        self.user = user
        self._model = .init(wrappedValue: model)
    }
}
