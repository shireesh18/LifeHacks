//
//  Text+Extension.swift
//  LifeHacks
//
//  Created by Shireesh Marla on 19/02/2024.
//

import SwiftUI

extension Text {
    
    init(viewCount: Int){
        self.init("Viewed \(viewCount.formatted()) times")
    }
    
    init(date: Date, prefix: String = "Asked on"){
        self.init(prefix + " " + date.formatted(date: .long, time: .omitted))
    }
    
}
