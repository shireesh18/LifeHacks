//
//  AsyncProfileImageView.swift
//  LifeHacks
//
//  Created by Shireesh Marla on 21/02/2024.
//

import Foundation
import SwiftUI

struct AsyncProfileImage: View {
    let url: URL?
    var borderColor: Color = .white
    
    var body: some View {
        AsyncImage(url: url) { image in
            image.circular(borderColor: borderColor)
        } placeholder: {
            ProgressView()
        }
    }
}
