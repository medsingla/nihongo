//
//  Translator.swift
//  NihonGo
//
//  Created by Medhansh Singla on 4/2/24.
//

import Foundation
import MLKitTranslate

class JapaneseTranslator {
    
    var japTranslator: Translator
    
    init() {
        
        let options = TranslatorOptions(sourceLanguage: .japanese, targetLanguage: .english)
        japTranslator = Translator.translator(options: options)
        
        let conditions = ModelDownloadConditions(
            allowsCellularAccess: true,
            allowsBackgroundDownloading: true
        )
        japTranslator.downloadModelIfNeeded(with: conditions) { error in
            guard error == nil else { return }
        }
        
    }
    
    func translate(_ input: String, completion: @escaping (String) -> Void) {
        
        DispatchQueue.main.async {
            
            self.japTranslator.translate(input) { result, error in
                if let result = result {
                    completion(result)
                } else {
                    completion("None found")
                }
            }
            
        }
    }
    
}
