//
//  StorageManager.swift
//  NihonGo
//
//  Created by Medhansh Singla on 2/17/24.
//

import Foundation

class StorageManager<T: Codable>{
    
    let modelData : T?
    let filePath: String
    
    init(filePath: String) {
        
        self.filePath = filePath
        
        let fileUrl = URL.documentsDirectory.appendingPathComponent("\(self.filePath).json")
        
        if FileManager.default.fileExists(atPath: fileUrl.path) {
            
            do {
                let content = try Data(contentsOf: fileUrl)
                let decoder = JSONDecoder()
                modelData = try decoder.decode(T.self, from: content)
                
                
            } catch {
                print(error)
                modelData = nil
            }
            
            return
        }

        let bundle = Bundle.main
        let url = bundle.url(forResource: self.filePath, withExtension: "json")
        
        guard let url = url else { modelData = nil; return}
        
        
        do {
            let content = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            modelData = try decoder.decode(T.self, from: content)
            
            
        } catch {
            print(error)
            modelData = nil
        }
        
    }
    
    
    func save(components: T) {
        let encoder = JSONEncoder()
        let url = URL.documentsDirectory.appendingPathComponent("\(filePath).json")
        do {
            let data = try encoder.encode(components)
            try data.write(to: url)
        } catch {
            print(error)
        }
        
    }
    
    
}
