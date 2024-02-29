//
//  URL+Extension.swift
//  LifeHacks
//
//  Created by Shireesh Marla on 27/02/2024.
//

import Foundation

extension URL {
    
    func appendingParameters(_ parameters: [String: String]) -> URL {
        var queryItems: [URLQueryItem] = []
        for (key, value) in parameters {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        return appending(queryItems: queryItems)
    }
    
    static func apiRequestURL(path: String, parameters: [String: String]) -> URL {
        URL(string: "https://api.stackexchange.com/2.3")!
            .appendingPathComponent(path)
            .appendingParameters(["site": "lifehacks"])
            .appendingParameters(parameters)
    }
    
    
}
