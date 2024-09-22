//
//  Manager+LiveText.swift
//  NihonGo
//
//  Created by Medhansh Singla on 4/10/24.
//

import Foundation

extension Manager {
    
    var present: Bool {
        for vocab in vocabulary {
            if vocab.kana == translatedText {
                return true
            }
        }
        return false
    }
    
    func translate() {
        if let text = self.selectedText {
            self.translator.translate(text) { result in
                if result.isEmpty {
                    self.translatedText = nil
                }
                else {
                    self.translatedText = result
                }
            }
        }
    }
    
    func addVocab() {
        if let selected = selectedText, let translated = translatedText {
            vocabulary.append(Vocab(kana: selected, meaning: translated, kanji: "N/A", lesson: 0))
        }
    }
    
}
