//
//  QuestionView.QuestionDetails.swift
//  LifeHacks
//
//  Created by Shireesh Marla on 20/02/2024.
//

import Foundation
import SwiftUI

extension QuestionView {
    struct QuestionDetails: View {
        @Binding var question: Question
        @Environment(\.dynamicTypeSize) private var dynamicTypeSize
        
        var body: some View {
            
            VStack(alignment: .leading, spacing: 24.0) {
                if dynamicTypeSize.isAccessibilitySize {
                    VStack(alignment: .leading){ header }
                } else {
                    HStack(alignment:.top, spacing: 16.0){ header }
                }
                QuestionView.MarkdownBody(text: question.body)
                QuestionView.OwnerLink(user: question.owner)
                    .role(.primary)
            }
            .padding(.horizontal, 20.0)
            
            // TODO:   - to be coded -
    //        #warning("finish this code")
        }
    }
}

extension QuestionView.QuestionDetails.Info {
    init(question: Question){
        title = question.title
        viewCount = question.viewCount
        date = question.creationDate
    }
}

extension QuestionView.QuestionDetails {
    
    struct Info: View {
        let title: String
        let viewCount: Int
        let date: Date
        
        var body: some View {
            VStack(alignment: .leading, spacing: 8.0){
                Text(title)
                    .font(.headline)
                Group {
                    Text(date: date)
                    Text(viewCount: viewCount)
                }
                .font(.caption)
                .foregroundColor(.secondary)
            }
        }
    }
    
}

struct QuestionView_QuestionDetails_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView.QuestionDetails(question: .constant(.preview))
            .padding(.horizontal, 20.0)
    }
}

private extension QuestionView.QuestionDetails {
    var header: some View {
        Group {
            QuestionView.Voting(
                score: question.score,
                vote: .init(vote: question.vote),
                upvote: { question.upvote() },
                downvote: { question.downvote() },
                unvote: { question.unvote() })
            Info(question: question)
        }
    }
}
