//
//  QuestionsController.swift
//  LifeHacks
//
//  Created by Shireesh Marla on 26/02/2024.
//

import Foundation

final class QuestionsController: ObservableObject {
    @Published var questions: [Question] {
        didSet { persistenceContoller.save(questions: questions) }
    }
    
    private let persistenceContoller: PersistenceController
    
    subscript(id: Int) -> Question {
        get { questions[index(for: id)] }
        set { questions[index(for: id)] = newValue }
    }
    
    init(persistenceContoller: PersistenceController) {
        self.questions = persistenceContoller.fetchQuestions() ?? []
        self.persistenceContoller = persistenceContoller
    }
    
}

private extension QuestionsController {
    func index(for id: Int) -> Int {
        questions.firstIndex(where: { $0.id == id })!
    }
}
