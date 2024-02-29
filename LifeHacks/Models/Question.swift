//
//  Question.swift
//  LifeHacks
//
//  Created by Shireesh Marla on 06/02/2024.
//

import Foundation

// MARK: - Question
struct Question: Hashable, Identifiable, Votable {
    
    static func == (lhs: Question, rhs: Question) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(id)
    }
    
    let isAnswered: Bool
    let id: Int
    let viewCount: Int
    let answerCount: Int
    let title: String
    let body: String
    let creationDate: Date
    let owner: User?
    var score: Int
    var vote: Vote?
    var answers: [Answer]
}

// MARK: Question: Codable
extension Question: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "question_id"
        case viewCount = "view_count"
        case answerCount = "answer_count"
        case isAnswered = "is_answered"
        case creationDate = "creation_date"
        case body = "body_markdown"
        case title, score, owner, answers
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        score = try container.decode(Int.self, forKey: .score)
        viewCount = try container.decode(Int.self, forKey: .viewCount)
        answerCount = try container.decode(Int.self, forKey: .answerCount)
        title = try container.decode(String.self, forKey: .title)
        isAnswered = try container.decode(Bool.self, forKey: .isAnswered)
        creationDate = try container.decode(Date.self, forKey: .creationDate)
        body = try container.decodeIfPresent(String.self, forKey: .body) ?? ""
        answers = try container.decodeIfPresent([Answer].self, forKey: .answers) ?? []
        do {
            owner = try container.decodeIfPresent(User.self, forKey: .owner)
        } catch User.DecodingError.userDoesNotExist {
            owner = nil
        }
    }
}

// MARK: - Question.Wrapper
extension Question {
    struct Wrapper: Decodable {
        let items: [Question]

        enum CodingKeys: String, CodingKey {
            case items
        }
    }
}


