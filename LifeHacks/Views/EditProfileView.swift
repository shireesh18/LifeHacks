//
//  editProfileView.swift
//  LifeHacks
//
//  Created by Shireesh Marla on 16/02/2024.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
//    let user: User
    let onEditingFinished: () -> Void
    
//    @State private var name: String
//    @State private var aboutMe: String?
//    @State private var photosItem: PhotosPickerItem?
    @State private var isDiscarding: Bool = false
    @StateObject private var model: Model
    @EnvironmentObject private var userController: UserController
    
    init(user: User, onEditingFinished: @escaping () -> Void){
        self.onEditingFinished = onEditingFinished
        self._model = .init(wrappedValue: Model(user: user))
    }
    
    
    var body: some View {
        
    
        Content(
            profileImageURL: model.profileImageURL,
            name: $model.name,
            aboutMe: $model.aboutMe,
            photosIem: $model.photosItem)
        .navigationTitle("Edit Profile")
        .toolbar {
            cancelButton
            saveButton
        }
        .alert("Do you want to discard your edits?", isPresented: $isDiscarding){
            Button("Discard changes", role: .destructive, action: onEditingFinished)
            Button("Continue editing", role: .cancel, action: {})
        }
    }
}


// MARK: - Error Message view -
extension EditProfileView {
    struct ErrorMessage: View {
        let text: String
        
        @Environment(\.theme) private var theme: Theme
        
        init(_ text: String){
            self.text = text
        }
        
        var body: some View {
            Text(text)
                .font(.footnote)
                .bold()
                .foregroundColor(theme.secondaryColor)
        }
    }
}

// MARK: - About me view -

extension EditProfileView {
    struct AboutMe : View {
        @Binding var text: String
        
        var body: some View {
            VStack(alignment: .leading){
                Text("About me:")
                    .font(.callout)
                    .bold()
                TextEditor(text: $text)
                    .frame(height: 200.0)
                EditProfileView.ErrorMessage("The about me cannot be empty")
                    .visible(text.isEmpty)
            }
        }
        
    }
}

// MARK: - Header View -
extension EditProfileView {
    struct Header: View {
        @Binding var name: String
        @Binding var photosItem: PhotosPickerItem?
        var profileImageURL: URL?
        
        var body: some View {
            HStack(alignment: .top){
                AsyncProfileImage(url: profileImageURL, borderColor: .gray)
                .frame(width: 62.0, height: 62.0)
                .overlay {
                    PhotosPicker("Edit", selection: $photosItem)
                        .bold()
                        .foregroundColor(.white)
                }
                VStack(alignment: .leading){
                    TextField("Name", text: $name)
                    Divider()
                    EditProfileView.ErrorMessage("The name cannot be empty")
                        .visible(name.isEmpty)
                }
                .padding(.leading, 16.0)
            }
        }
    }
}


//#Preview {
//    EditProfileView(user: .preview1)
//}


struct EditProfileView_Previews: PreviewProvider {
    struct PreviewContainer: View {
        @State private var name: String = User.preview.name
        @State private var aboutMe: String = User.preview.aboutMe ?? ""
        
        var body: some View {
            VStack {
//                EditProfileView.Header(
//                    name: $name,
//                    photosItem: .constant(nil),
//                    profileImageURL: User.preview.profileImageURL)
                EditProfileView.Content(profileImageURL: User.preview.profileImageURL, name: $name, aboutMe: $aboutMe, photosIem: .constant(nil))
                EditProfileView.AboutMe(text: $aboutMe)
            }
        }
    }
    
    static var previews: some View {
        Group{
            NavigationStack {
                EditProfileView(user: .preview, onEditingFinished: {})
            }
            PreviewContainer()
                .previewDisplayName("Interactive views")
        }
    }
}

private extension EditProfileView {
    
    var cancelButton: some ToolbarContent {
        ToolbarItem(placement: .cancellationAction){
            Button("Cancel"){
                if model.isContentEdited {
                    isDiscarding = true
                } else {
                    onEditingFinished()
                }
            }
        }
    }
    
    var saveButton: some ToolbarContent {
        ToolbarItem(placement: .confirmationAction){
            Button("Save"){
                try? userController.save(
                    name: model.name,
                    aboutMe: model.aboutMe,
                    profilePicture: model.profileImageData)
                onEditingFinished()
            }
        }
    }
}

extension EditProfileView {
    struct Content: View {
        let profileImageURL: URL?
        
        @Binding var name: String
        @Binding var aboutMe: String
        @Binding var photosIem: PhotosPickerItem?
        
        var body: some View {
            ScrollView {
                EditProfileView.Header(
                    name: $name,
                    photosItem: $photosIem,
                    profileImageURL: profileImageURL
                )
                .animation(.default, value: name)
                EditProfileView.AboutMe(text: $aboutMe)
                    .animation(.default, value: aboutMe)
            }
            .padding(20.0)
        }
    }
}
