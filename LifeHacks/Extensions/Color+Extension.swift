//
//  Color+Extension.swift
//  LifeHacks
//
//  Created by Shireesh Marla on 08/02/2024.
//

import Foundation
import SwiftUI

extension Color {
    static var piz: Color { .init(blazeOrange) }
}


struct Color_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Color.accentColor
            Color.pizazz
            Color.electricViolet
            Color.blazeOrange
            Color.electricViolet
            Color.piz
            Color.cornflowerBlue
        }
    }
}
