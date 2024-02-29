//
//  SettingsView.swift
//  LifeHacks
//
//  Created by Shireesh Marla on 20/02/2024.
//

import SwiftUI

struct SettingsView: View {
//    @State var selectedThemeId: String? = Theme.default.id
    @EnvironmentObject private var settingsController: SettingsController
    
    var body: some View {
        List(selection: $settingsController.selectedThemeID) {
            Section(header: Text("App THEME")){
                ForEach(Theme.allThemes){ theme in
                    Row(theme: theme, isSelected: theme.id == settingsController.selectedThemeID)
                        .listRowInsets(.init(
                            top: 16.0,
                            leading: 16.0,
                            bottom: 16.0,
                            trailing: 16.0))
                        .listRowBackground(Color(uiColor: .systemBackground))
                }
            }
        }
        .navigationTitle(Text("Settings"))
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
    .environmentObject(SettingsController())
}

extension SettingsView {
    struct Row: View {
        let theme: Theme
        let isSelected: Bool
        
        var body: some View {
            LabeledContent {
                Placeholder(imageName: "sun.max.fill")
                    .styled(color: theme.accentColor)
                Placeholder(imageName: "moon.fill")
                    .styled(color: theme.secondaryColor)
                Placeholder(imageName: "leaf")
                    .styled(color: theme.secondaryColor, isFilled: false)
            } label: {
                HStack {
                    Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                        .font(.title)
                        .foregroundColor(isSelected ? theme.accentColor : .secondary )
                    Text(theme.name)
                }
            }
            .font(.headline)
            .foregroundColor(.primary)
        }
    }
}

extension SettingsView.Row {
    struct Placeholder: View {
        let imageName: String
        
        var body: some View {
            Image(systemName: imageName)
                .frame(width: 42.0, height: 42.0)
        }
    }
}
