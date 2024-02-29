//
//  Test.swift
//  LifeHacks
//
//  Created by Shireesh Marla on 28/02/2024.
//

import Foundation

class TimeTracker {
    var elapsedSeconds: Int = 0
    var timer: Timer?
    
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let `self` = self else { return }
            self.elapsedSeconds += 1
        }
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
    }
}
