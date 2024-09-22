//
//  Manager+FlashCards.swift
//  NihonGo
//
//  Created by Medhansh Singla on 3/30/24.
//

import Foundation

extension Manager {
    
    var currentVocab: Vocab {
        vocabulary[lessonVocab[currentIndex]]
    }
    
    func nextCard() {
        showAnswer = false
        if currentIndex + 1 < lessonVocab.count {
            currentIndex += 1
            return
        }
        finishReview()
        return
    }
    
    func startReview() {
        
        lessonVocab = []
        currentIndex = 0
        
        for index in 0..<vocabulary.count {
            if (vocabulary[index].lesson == self.lesson) && (vocabulary[index].reviewDate <= Date()) {
                lessonVocab.append(index)
            }
        }
        self.reviewing = !lessonVocab.isEmpty
        return
    }
    
    func updateReview(_ answer: Vocab.Answer) {
        switch answer {
        case .again:
            vocabulary[currentIndex].updateReview(0.0)
        case .easy:
            vocabulary[currentIndex].updateReview(3.0)
        case .normal:
            vocabulary[currentIndex].updateReview(2.2)
        case .hard:
            vocabulary[currentIndex].updateReview(1.3)
        }
    }
    
    func finishReview() {
        self.reviewing = false
    }
    
    func resetCards() {
        for index in 0..<vocabulary.count {
            vocabulary[index].updateReview(0.0)
        }
    }
    
    func shuffleCards() {
        currentIndex = 0
        lessonVocab.shuffle()
    }
    
}
