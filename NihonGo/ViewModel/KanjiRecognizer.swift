//
//  KanjiRecognizer.swift
//  NihonGo
//
//  Created by Medhansh Singla on 3/31/24.
//

import Foundation
import MLKit

class KanjiRecognizer {
    
    let identifier = DigitalInkRecognitionModelIdentifier(forLanguageTag: "ja")
    let recognizer: DigitalInkRecognizer
    
    //Code contains boilerplate code from Google Documentation
    
    init() {
        let model = DigitalInkRecognitionModel.init(modelIdentifier: identifier!)
        let modelManager = ModelManager.modelManager()
        let conditions = ModelDownloadConditions.init(allowsCellularAccess: true,
                                                      allowsBackgroundDownloading: true)
        modelManager.download(model, conditions: conditions)

        let options: DigitalInkRecognizerOptions = DigitalInkRecognizerOptions.init(model: model)
        recognizer = DigitalInkRecognizer.digitalInkRecognizer(options: options)
    }
    
    func doRecognition(strokes: [Stroke], completion: @escaping (String) -> Void) {
        let ink = Ink(strokes: strokes)
        recognizer.recognize(ink: ink) { result, error in
            if let result = result, let candidate = result.candidates.first {
                completion(candidate.text)
            } else {
                completion("")
            }
        }
    }
}
