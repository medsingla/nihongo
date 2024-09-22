//
//  TextToSpeech.swift
//  NihonGo
//
//  Created by Medhansh Singla on 4/2/24.
//

import Foundation
import AVFoundation

class TextToSpeech {
    
    private let synthesizer = AVSpeechSynthesizer()

    func speak(_ input: String, language: String) {
        
        let utterance = AVSpeechUtterance(string: input)
        utterance.voice = AVSpeechSynthesisVoice(language: language) // Set the language
        utterance.rate = 0.4
        synthesizer.speak(utterance)
    }
}

