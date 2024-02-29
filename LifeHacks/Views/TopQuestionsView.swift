//
//  TopQuestionsView.swift
//  LifeHacks
//
//  Created by Shireesh Marla on 19/02/2024.
//

import SwiftUI

struct TopQuestionsView: View {
    @EnvironmentObject private var questionsControler: QuestionsController
    @StateObject private var model = Model()
    
    var body: some View {
        Content(questions: $questionsControler.questions)
            .navigationChrome()
            .loading(model.isLoading)
            .errorAlert(isPresented: $model.showError)
            .navigationDestination(for: Question.self) { question in
                QuestionView(question: question)
            }
            .task {
                guard questionsControler.questions.isEmpty else { return }
                await model.fetchTopQuestions()
            }
            .refreshable { await model.fetchTopQuestions() }
            .onChange(of: model.fetchedQuestions) { _, newValue in
                guard !newValue.isEmpty else { return }
                questionsControler.questions = newValue
            }
    }

}

struct TopQuestionsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationStack {
                TopQuestionsView.Content(questions: .constant(.preview))
                    .environmentObject(QuestionsController(persistenceContoller: PersistenceController()))
            }
        }
    }
}

// MARK: - Row View -
extension TopQuestionsView {
    struct Row: View {
        let title: String
        let score: Int
        let answerCount: Int
        let viewCount: Int
        let date: Date
        let name: String
        let isAnswered: Bool
        
        var body: some View {
            VStack(alignment:.leading, spacing: 8){
                Text(title)
                    .font(.headline)
                HStack(alignment:.center, spacing: 16){
                    Counter(count: score, label: "votes")
                        .styled()
                    Counter(count: answerCount, label: "answers")
                        .styled(isFilled: isAnswered)
                        .role(.secondary)
                    Details(viewCount: viewCount, date: date, name: name)
                }
                .padding(.vertical, 8)
            }
        }
    }
}

// MARK: - Counter View -
extension TopQuestionsView.Row {
    struct Counter: View {
        let count: Int
        let label: String
        
        var body: some View {
            VStack {
                Text("\(count)")
                    .font(.title3)
                .bold()
                Text(label)
                    .font(.caption)
            }
            .frame(width: 67, height: 67)
        }
    }
}

// MARK: - Details View -
extension TopQuestionsView.Row {
    struct Details: View {
        let viewCount: Int
        let date: Date
        let name: String
        
        var body: some View {
            VStack(alignment: .leading, spacing: 4.0) {
                Text(viewCount: viewCount)
                Text(date: date)
                Text(name)
            }
            .font(.caption)
            .foregroundColor(.secondary)
        }
    }
}

extension TopQuestionsView.Row {
    init(question: Question) {
        self.init(
            title: question.title,
            score: question.score,
            answerCount: question.answerCount,
            viewCount: question.viewCount,
            date: question.creationDate,
            name: question.owner?.name ?? "",
            isAnswered: question.isAnswered)
    }
}

struct TopQuestionsView1_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            NavigationStack {
                TopQuestionsView.Content(questions: .constant(.preview))
                    .navigationChrome()
            }
            VStack(alignment: .leading){
                TopQuestionsView.Row(question: .preview)
                TopQuestionsView.Row(question: .unanswered)
            }
            .previewDisplayName("Rows")
        }
      
    }
}

extension TopQuestionsView {
    struct Content: View {
        @Binding var questions: [Question]
        
        var body: some View {
                List{
                    ForEach(questions){ question in
                        NavigationLink(value: question) {
                            TopQuestionsView.Row(question: question)
                        }
                    }
                    .onDelete(perform: deleteItems(atOffsets:))
                    .onMove(perform: move(fromOffsets:toOffset:))
                }
                .listStyle(.plain)
        }
        
        func deleteItems(atOffsets offsets: IndexSet){
            questions.remove(atOffsets: offsets)
        }
        
        func move(fromOffsets source: IndexSet, toOffset destination: Int){
            questions.move(fromOffsets: source, toOffset: destination)
        }
    }
}

extension TopQuestionsView.Content {
    func navigationChrome() -> some View {
        self.navigationTitle("Top Questions")
            .toolbar {
                ToolbarItem(placement: .primaryAction){
                    EditButton()
                }
            }
    }
}


