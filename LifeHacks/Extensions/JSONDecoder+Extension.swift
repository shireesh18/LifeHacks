//
//  JSONDecoder+Extension.swift
//  LifeHacks
//
//  Created by Shireesh Marla on 27/02/2024.
//

import Foundation

extension JSONDecoder {
    static var apiDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }
}
