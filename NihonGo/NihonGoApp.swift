//
//  NihonGoApp.swift
//  NihonGo
//
//  Created by Medhansh Singla on 3/28/24.
//

import SwiftUI

@main
struct NihonGoApp: App {
    
    @Environment(\.scenePhase) var scenePhase
    @StateObject var manager: Manager = Manager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(manager)
                .onChange(of: scenePhase) { oldValue, newValue in
                    switch newValue {
                    case .background:
                        manager.save()
                    default:
                        break
                    }
                }
        }
    }
}
