//
//  Style.swift
//  LifeHacks
//
//  Created by Shireesh Marla on 12/02/2024.
//

import Foundation
import SwiftUI

struct Style: ViewModifier {
    let color: Color?
    var isFilled = true
    var isRounded = true
    
    @Environment(\.theme) private var theme: Theme
    @Environment(\.role) private var role: Role
    
    var appliedColor: Color {
        if let color {
            return color
        }
        return role == .primary ? theme.accentColor : theme.secondaryColor
    }
    
    func body(content: Content) -> some View {
        let radius = isRounded ? 10.0 : 0.0
        if isFilled {
            content
                .background(appliedColor)
                .cornerRadius(radius)
                .foregroundColor(.white)
        } else {
            content
                .background(
                RoundedRectangle(cornerRadius: radius)
                    .strokeBorder(appliedColor, lineWidth: 2.0)
                )
        }
    }
}

extension Style {
    enum Role {
        case primary, secondary
    }
    
    struct RoleKey: EnvironmentKey {
        static let defaultValue = Role.primary
    }
}

extension EnvironmentValues {
    var role: Style.Role {
        get { self[Style.RoleKey.self] }
        set { self[Style.RoleKey.self] = newValue }
    }
}

extension View {
    func role(_ role: Style.Role) -> some View {
        environment(\.role, role)
    }
}
