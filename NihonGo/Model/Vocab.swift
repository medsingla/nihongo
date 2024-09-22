//
//  Vocab.swift
//  NihonGo
//
//  Created by Medhansh Singla on 3/28/24.
//

import Foundation

struct Vocab: Codable, Identifiable {
    
    let id = UUID()
    let kana: String
    let meaning: String
    let kanji: String
    let lesson: Int //Vocab will be grouped by lesson
    var untilReview: Int //Number of days until this word needs to be review again. This goes up with each spaced repetition
    var reviewDate: Date
    
    private enum CodingKeys: String, CodingKey {
        case Kana
        case Meaning
        case Lesson
        case ReviewInterval
        case ReviewDate
        case Kanji
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        kana = try container.decode(String.self, forKey: .Kana)
        meaning = try container.decode(String.self, forKey: .Meaning)
        lesson = try container.decode(Int.self, forKey: .Lesson)
        kanji = try container.decode(String.self, forKey: .Kanji)
        untilReview = try container.decodeIfPresent(Int.self, forKey: .ReviewInterval) ?? 1
        reviewDate = try container.decodeIfPresent(Date.self, forKey: .ReviewDate) ?? Date()
    }
    
    init(kana: String, meaning: String, kanji: String, lesson: Int) {
        self.kana = kana
        self.meaning = meaning
        self.kanji = kanji
        self.lesson = lesson
        self.untilReview = 1
        self.reviewDate = Date()
    }
    
}

extension Vocab {
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(kana, forKey: .Kana)
        try container.encode(meaning, forKey: .Meaning)
        try container.encode(kanji, forKey: .Kanji)
        try container.encode(lesson, forKey: .Lesson)
        try container.encode(untilReview, forKey: .ReviewInterval)
        try container.encode(reviewDate, forKey: .ReviewDate)
    }
    
    enum Answer: String, Codable, Identifiable, CaseIterable {
        
        var id: String { self.rawValue }
        
        case again = "Repeat"
        case easy = "Easy"
        case normal = "Normal"
        case hard = "Hard"

    }
    
    mutating func updateReview(_ factor: Double) {
        untilReview = Int(Double(untilReview) * factor)
        reviewDate = Calendar.current.date(byAdding: .day, value: untilReview, to: Date()) ?? Date()
        
    }
    
}
