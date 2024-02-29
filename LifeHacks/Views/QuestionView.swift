//
//  QuestionView.swift
//  LifeHacks
//
//  Created by Shireesh Marla on 06/02/2024.
//

import SwiftUI

struct QuestionView: View {
    
    let question: Question
    
    @EnvironmentObject private var questionsController: QuestionsController
    @StateObject private var model: Model
    
    init(question: Question) {
        self.question = question
        self._model = .init(wrappedValue: Model(question: question))
    }
    
    var body: some View{
        Content(question: $questionsController[question.id])
        .navigationTitle("Question")
        .loading(model.isLoading)
        .errorAlert(isPresented: $model.showError)
        .task {
            await model.loadDetails()
        }
        .navigationDestination(for: User.self){ user in
            ProfileView(user: user)
        }
        .onChange(of: model.question) { _, newValue in
            questionsController[question.id] = newValue
        }
    }

}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationStack {
                QuestionView.Content(question: .constant(.preview))
                    .navigationTitle("Question")
                    .environmentObject(QuestionsController(persistenceContoller: PersistenceController()))
            }
            HStack(spacing:16){
                QuestionView.Voting.VoteButton(buttonType: .up, highlighted: true, action: {})
                QuestionView.Voting.VoteButton(buttonType: .up, highlighted: false, action: {})
                QuestionView.Voting.VoteButton(buttonType: .down, highlighted: true, action: {})
                QuestionView.Voting.VoteButton(buttonType: .down, highlighted: false, action: {})
            }
            .previewDisplayName("Vote Button")
            .previewLayout(.sizeThatFits)
            QuestionView.Content(question: .constant(.preview))
                .previewDevice(.init(rawValue: "iphone SE (3rd generation)"))
                .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
                .dynamicTypeSize(.xxxLarge)
                .previewDisplayName("Accessibility")
        }
    }
}



// MARK: - extension QuestionView.Voting.Vote -
extension QuestionView.Voting.Vote {
    init?(vote: LifeHacks.Vote?){
        switch vote {
        case .up: self = .up
        case .down: self = .down
        case .none: return nil
        }
    }
}

// MARK: - Question Body -
extension QuestionView {
    struct MarkdownBody: View {
        let text: String
        
        var body: some View {
            let markdown = try! AttributedString(
                markdown: text,
                options: .init(interpretedSyntax: .inlineOnlyPreservingWhitespace)
            )
            Text(markdown)
                .font(.subheadline)
        }
    }
}

// MARK: - Owner view -

extension QuestionView {
    
    struct Owner: View {
        
        let name: String
        let reputation: Int
        let profileImageURL: URL?
        
        var body: some View {
            HStack {
                AsyncProfileImage(url: profileImageURL)
                .frame(width: 48.0, height: 48.0)
                VStack(alignment: .leading, spacing: 4.0){
                    Text(name)
                        .font(.headline)
                    Text("\(reputation.formatted()) reputation")
                        .font(.caption)
                }
            }
            .padding(16)
            .styled(color: .accentColor)
        }
    }
}

extension QuestionView.Owner {
    init(user: User){
        name = user.name
        reputation = user.reputation
        profileImageURL = user.profileImageURL
    }
}

extension QuestionView {
    struct OwnerLink: View {
        let user: User?
        
        var body: some View {
            if let user {
                NavigationLink(value: user) {
                    QuestionView.Owner(user: user)
                        .styled()
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)
                }
            }
        }
    }
}

extension QuestionView {
    struct Content: View {
        @Binding var question: Question
        
        var body: some View {
            ScrollView {
                LazyVStack {
                    QuestionView.QuestionDetails(question: $question)
                        .padding(.horizontal, 20.0)
                        .padding(.bottom)
                    Divider()
                        .padding(.leading, 20.0)
                    ForEach($question.answers) { $answer in
                        QuestionView.AnswerDetails(answer: $answer)
                            .padding(.horizontal, 20.0)
                            .padding(.vertical, 24.0)
                            .id(answer.id)
                        Divider()
                            .padding(.leading, 20.0)
                    }
                }
            }
            .padding(.top)
        }
    }
}
