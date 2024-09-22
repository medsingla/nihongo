//
//  Kanji.swift
//  NihonGo
//
//  Created by Medhansh Singla on 3/28/24.
//

import Foundation

struct Kanji: Codable, Identifiable {
    
    let id = UUID()
    let meaning: String
    let kanji: String
    let reading: String
    let lesson: Int //Vocab will be grouped by lesson
    
    private enum CodingKeys: String, CodingKey {
        case Definition
        case Kanji
        case Reading
        case Lesson
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        meaning = try container.decode(String.self, forKey: .Definition)
        kanji = try container.decode(String.self, forKey: .Kanji)
        reading = try container.decode(String.self, forKey: .Reading)
        lesson = try container.decode(Int.self, forKey: .Lesson)
    }
    
}

extension Kanji {
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(meaning, forKey: .Definition)
        try container.encode(kanji, forKey: .Kanji)
        try container.encode(reading, forKey: .Reading)
        try container.encode(lesson, forKey: .Lesson)
    }
    
}
