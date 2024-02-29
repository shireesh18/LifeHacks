//
//  SettingsController.swift
//  LifeHacks
//
//  Created by Shireesh Marla on 26/02/2024.
//

import Foundation


final class SettingsController: ObservableObject {
    
    @Published var selectedThemeID: String? = Theme.default.id {
        didSet {
            defaults.set(selectedThemeID, forKey: UserDefaultKeys.themeID)
        }
    }
    
    private var defaults = UserDefaults.standard
    
    var theme: Theme {
        guard let selectedThemeID,
              let theme = Theme.allThemes.first(where: { $0.id == selectedThemeID }) else {
            return Theme.default
        }
        return theme
    }
    
    init() {
        selectedThemeID = defaults.string(forKey: UserDefaultKeys.themeID)
    }
}

private extension SettingsController {
    struct UserDefaultKeys {
        static let themeID = "ThemeID"
    }
}
