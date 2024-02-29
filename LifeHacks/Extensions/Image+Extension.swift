//
//  Image+Extension.swift
//  LifeHacks
//
//  Created by Shireesh Marla on 12/02/2024.
//

import SwiftUI

extension Image {
    
    func circular(borderColor: Color = .white) -> some View {
        self
            .resizable()
            .clipShape(Circle())
            .overlay(Circle()
                .stroke(borderColor, lineWidth: 2)
            )
            
    }
    
}
