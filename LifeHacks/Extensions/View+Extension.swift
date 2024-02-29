//
//  View+Extension.swift
//  LifeHacks
//
//  Created by Shireesh Marla on 12/02/2024.
//

import Foundation
import SwiftUI

extension View {
    func styled(color: Color? = nil, isFilled: Bool =  true, isRounded: Bool = true) -> some View {
        modifier(Style(color: color, isFilled: isFilled, isRounded: isRounded))
    }
}

extension View {
    func visible(_ isVisible: Bool) -> some View {
        opacity(isVisible ? 1.0 : 0.0)
    }
}

extension View {
    func loading(_ isLoading: Bool) -> some View {
        overlay {
            if isLoading {
                ProgressView("Loading...")
                    .padding()
                    .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 8.0))
            }
        }
    }
    
    func errorAlert(isPresented: Binding<Bool>) -> some View {
        alert(isPresented: isPresented){
            Alert(title: Text("There was an error"), message: Text("Please try again later"))
        }
    }
}
