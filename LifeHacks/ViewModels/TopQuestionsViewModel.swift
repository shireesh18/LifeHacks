//
//  TopQuestionsViewModel.swift
//  LifeHacks
//
//  Created by Shireesh Marla on 27/02/2024.
//

import Foundation

extension TopQuestionsView {
    @MainActor final class Model: ObservableObject {
        @Published var fetchedQuestions: [Question] = []
        @Published var isLoading = false
        @Published var showError = false
        
        func fetchTopQuestions() async {
            isLoading = true
            defer { isLoading = false }
            let url = URL.apiRequestURL(path: "/questions", parameters: [
                "sort": "votes",
                "order": "desc",
                "pagesize": "10",
                "filter": "**k8ThRQPg_hBG)oELYUvGv"
            ])
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let wrapper = try JSONDecoder.apiDecoder.decode(Question.Wrapper.self, from: data)
                fetchedQuestions = wrapper.items
            } catch {
                showError = true
            }
        }
    }
}
