//
//  Manager+Kanji.swift
//  NihonGo
//
//  Created by Medhansh Singla on 4/2/24.
//

import Foundation
import MLKit

extension Manager {
    
    var currentKanji: Kanji {
        return kanji[currentKIndex]
    }
    
    func addPoint(_ loc: CGPoint) {
        self.points.append(StrokePoint(x: Float(loc.x), y: Float(loc.y)))
    }
    
    func finishStroke() {
        self.strokes.append(Stroke(points: self.points))
        self.points = []
    }
    
    func getAnswer() {
        DispatchQueue.main.async {
            self.recognizer.doRecognition(strokes: self.strokes) { result in
                self.answer = result
            }
        }
    }
    
    func resetKanji() {
        self.strokes = []
        self.points = []
    }
    
    func undoStroke() {
        if !self.strokes.isEmpty {
            self.strokes = self.strokes.dropLast()
        }
    }
    
    func nextKanji() {
        resetKanji()
        for index in (currentKIndex+1)..<kanji.count {
            if (kanji[index].lesson == kanji[currentKIndex].lesson) {
                currentKIndex = index
                return
            }
        }
        finishReview()
        return
    }
    
    func startKanjiReview() {
        for index in 0..<kanji.count {
            if (kanji[index].lesson == self.lesson) {
                self.currentKIndex = index
                return
            }
        }
        return
    }
    
}
