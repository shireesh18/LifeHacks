//
//  VotingView.swift
//  LifeHacks
//
//  Created by Shireesh Marla on 20/02/2024.
//

import Foundation
import SwiftUI

// MARK: - Voting View -

extension QuestionView {
    struct Voting: View {
        let score: Int
        let vote: Vote?
        let upvote: () -> Void
        let downvote: () -> Void
        let unvote: () -> Void
        
        @Environment(\.dynamicTypeSize) private var dynamicTypeSize
        
        enum Vote {
            case up, down
        }
        
        var body: some View {
                if dynamicTypeSize.isAccessibilitySize {
                    HStack { content }
                } else {
                    VStack(spacing: 8.0) { content }
                        .frame(minWidth: 56.0)
                }
        }
        
        private func cast(vote: Vote){
            switch (self.vote, vote){
            case (nil, .up), (.down, .up): upvote()
            case (nil, .down), (.up, .down): downvote()
            default: unvote()
            }
        }
    }
}

// MARK: - Vote Button -
extension QuestionView.Voting {
    struct VoteButton: View {
        let buttonType: ButtonType
        let highlighted: Bool
        let action: () -> Void
        
        var body: some View {
            Button(action: action){
                buttonType.image(higlighted: highlighted)
                    .resizable()
                    .frame(width:32, height:32)
            }
        }
    }
}

// MARK: - Vote Button Type -
extension QuestionView.Voting.VoteButton {
    enum ButtonType: String {
        case up = "arrowtriangle.up"
        case down = "arrowtriangle.down"
        
        func image(higlighted: Bool) -> Image {
            let imageName = rawValue + (higlighted ? ".fill" : "")
            return (Image(systemName: imageName))
        }
    }
}

struct QuestionView_Voting_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing:16){
            QuestionView.Voting.VoteButton(buttonType: .up, highlighted: true, action: {})
            QuestionView.Voting.VoteButton(buttonType: .up, highlighted: false, action: {})
            QuestionView.Voting.VoteButton(buttonType: .down, highlighted: true, action: {})
            QuestionView.Voting.VoteButton(buttonType: .down, highlighted: false, action: {})
        }
        .previewLayout(.sizeThatFits)
    }
}

private extension QuestionView.Voting {
    var content: some View {
        Group {
            VoteButton(buttonType: .up, highlighted: vote == .up){
                cast(vote: .up)
            }
            Text("\(score)")
                .font(.title)
                .foregroundColor(.secondary)
            VoteButton(buttonType: .down, highlighted: vote == .down){
                cast(vote: .down)
            }
        }
    }
}
