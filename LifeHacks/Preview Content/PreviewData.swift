//
//  PreviewData.swift
//  LifeHacks
//
//  Created by Shireesh Marla on 07/02/2024.
//

import Foundation
import SwiftUI

extension [Question] {
    static var preview: [Question] {
        let url = Bundle.main.url(forResource: "Questions", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let wrapper = try! JSONDecoder.apiDecoder.decode(Question.Wrapper.self, from: data)
        return wrapper.items
    }
}

extension Question {
    static var preview: Question {
        [Question].preview[0]
    }
    
    static var unanswered: Question {
        Question(
            isAnswered: false,
            id: Question.preview.id,
            viewCount: Question.preview.viewCount,
            answerCount: Question.preview.answerCount,
            title: Question.preview.title,
            body: Question.preview.body,
            creationDate: Question.preview.creationDate,
            owner: Question.preview.owner,
            score: Question.preview.score,
            answers: Question.preview.answers)
    }
}


extension User {
    static var preview: User {
        Question.preview.owner!
    }
}

extension Answer {
    static var preview: Answer {
        Question.preview.answers[0]
    }
}

struct Image_Previews: PreviewProvider {
    static var previews: some View {
        Image("siri")
            .circular(borderColor: .accentColor)
            .frame(width: 200, height: 200)
    }
}

struct Style_Preview: PreviewProvider {
    static var previews: some View {
        let size = 100.0
        Grid {
            GridRow {
                Text("Accent")
                    .frame(width: size, height: size)
                    .styled(color: .accentColor, isRounded: false)
                Text("Pizazz")
                    .frame(width: size, height: size)
                    .styled(color: .pizazz)
                Text("Pizazz")
                    .frame(width: size, height: size)
                    .styled(color: .pizazz, isFilled: false)
            }
            GridRow {
                Text("Electric Violet")
                    .frame(width: size, height: size)
                    .styled(color: .electricViolet, isRounded: false)
                Text("Blaze Orange")
                    .frame(width: size, height: size)
                    .styled(color: .blazeOrange)
                Text("Blaze Orange")
                    .frame(width: size, height: size)
                    .styled(color: .blazeOrange, isFilled: false)
            }
        }
    }
}

extension User {
    static var previews: User {
        User(
            id: 0,
            reputation: 0,
            name: "Shireesh",
            aboutMe: "Shireesh is the new model in the town",
            profileImageURL: Bundle.main.url(forResource: "siri", withExtension: "JPG")!
        )
    }
}
