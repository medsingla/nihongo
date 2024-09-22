//
//  DestinationInfo.swift
//  NihonGo
//
//  Created by Medhansh Singla on 4/3/24.
//

import Foundation

struct DestinationInfo {
    
    let destination: Destination
    
    func getInfo() -> String {
        switch destination {
        case .vocab:
            return "Practice your Japanese vocabulary using spaced repetition"
        case .kanji:
            return "Practice writing Kanji characters on your phone and get instant feedback"
        case .live:
            return "Translate Japanese characters in the real world and also add them to your word bank"
        }
        
    }
    
    
}

enum Destination: String, Codable, Identifiable, CaseIterable {
    
    var id: String { self.rawValue }
    
    case vocab = "Flash Cards"
    case kanji = "Writing Practice"
    case live = "Live Translate"

}
