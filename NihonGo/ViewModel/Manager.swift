//
//  Manager.swift
//  NihonGo
//
//  Created by Medhansh Singla on 3/28/24.
//

import Foundation
import MLKit
import SwiftUI

class Manager: ObservableObject {
    
    private let vocabData: StorageManager = StorageManager<[Vocab]>(filePath: "vocab")
    private let kanjiData: StorageManager = StorageManager<[Kanji]>(filePath: "kanji")
    var appBackground = LinearGradient(gradient: Gradient(colors: [Color(red: 202/255, green: 96/255, blue: 96/255), Color(red: 245/255, green: 102/255, blue: 205/255)]), startPoint: .top, endPoint: .bottom)
    
    
    let recognizer = KanjiRecognizer()
    @Published var strokes: [MLKit.Stroke] = []
    @Published var points: [MLKit.StrokePoint] = []
    @Published var currentKIndex: Int = 1
    @Published var streakCount: Int = (UserDefaults(suiteName: "group.edu.psu.mks6942.NihonGo")!.object(forKey: "streakCount") as? Int ?? 1)
    
    let translator = JapaneseTranslator()
    
    let speaker = TextToSpeech()
    
    var correct: Bool {
        switch (self.answer) {
        case "ー":
            return "一" == self.currentKanji.kanji
        case "ニ":
            return "二" == self.currentKanji.kanji
        case "ハ":
            return "八" == self.currentKanji.kanji
        case "ロ":
            return "口" == self.currentKanji.kanji
        default:
            return self.answer == self.currentKanji.kanji
            
        }
    }
    
    @Published var vocabulary: [Vocab]
    @Published var lessonVocab: [Int] = []
    @Published var kanji: [Kanji]
    @Published var currentIndex: Int = 0
    @Published var showAnswer: Bool = false
    @Published var lesson: Int = 1
    @Published var reviewing: Bool = false
    @Published var answer: String = ""
    var i = 0
    
    @Published var liveText: String = ""
    @Published var translatedText: String?
    @Published var selectedText: String?
    @Published var showTranslation = false
    
    
    public init() {
        vocabulary = vocabData.modelData ?? []
        kanji = kanjiData.modelData ?? []
    }
    
    func save() {
        vocabData.save(components: vocabulary)
        kanjiData.save(components: kanji)
    }
    
    func updateStreak() {
        let lastAccessDate = UserDefaults(suiteName: "group.edu.psu.mks6942.NihonGo")!.object(forKey: "lastAccessDate") as? Date
            let currentDate = Date()
            
            if let lastDate = lastAccessDate {
                let calendar = Calendar.current
                if calendar.isDateInToday(lastDate) {
                    return
                } else if calendar.isDate(currentDate, equalTo: lastDate.addingTimeInterval(86400), toGranularity: .day) {
                    streakCount += 1
                } else {
                    streakCount = 1
                }
            } else {
                streakCount = 1
            }
            UserDefaults(suiteName: "group.edu.psu.mks6942.NihonGo")!.set(streakCount, forKey: "streakCount")
            UserDefaults(suiteName: "group.edu.psu.mks6942.NihonGo")!.set(currentDate, forKey: "lastAccessDate")
        }
    
        
}
