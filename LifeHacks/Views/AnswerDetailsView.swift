//
//  AnswerDetailsView.swift
//  LifeHacks
//
//  Created by Shireesh Marla on 20/02/2024.
//

import Foundation
import SwiftUI

extension QuestionView {
    struct AnswerDetails: View {
        @Binding var answer: Answer
        
        var body: some View {
            HStack(alignment:. top, spacing: 16.0){
                VStack(spacing: 16.0){
                    QuestionView.Voting(
                        score: answer.score,
                        vote: .init(vote: answer.vote),
                        upvote: {answer.upvote()},
                        downvote: {answer.downvote()},
                        unvote: {answer.unvote()})
                    if answer.isAccepted {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.pizazz)
                    }
                }
                VStack(alignment: .leading, spacing: 8.0){
                    QuestionView.MarkdownBody(text: answer.body)
                    Text(date: answer.creationDate, prefix: "Answered on")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    QuestionView.OwnerLink(user: answer.owner)
                        .role(.secondary)
                }
            }
        }
    }
}

struct QuestionView_Answer_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView.AnswerDetails(answer: .constant(.preview))
            .padding(.horizontal, 20.0)
    }
}
