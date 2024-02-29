//
//  QuestionViewModel.swift
//  LifeHacks
//
//  Created by Shireesh Marla on 27/02/2024.
//

import Foundation

extension QuestionView {
    
    @MainActor class Model: ObservableObject {
        @Published var question: Question
        @Published var isLoading = false
        @Published var showError = false
        
        init(question: Question){
            self.question = question
        }
        
        func loadDetails() async {
            isLoading = true
            defer { isLoading = false }
            let url = URL.apiRequestURL(path: "/questions/\(question.id)", parameters: [
                "filter": "-T2M9.3eG9hXfgHaShP_t9UiIkcZIWFCzoC_"
            ])
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let wrapper = try JSONDecoder.apiDecoder.decode(Question.Wrapper.self, from: data)
                question = wrapper.items[0]
            } catch {
                showError = true
            }
        }
    }
}
