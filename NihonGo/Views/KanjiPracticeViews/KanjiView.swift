//
//  KanjiView.swift
//  NihonGo
//
//  Created by Medhansh Singla on 4/2/24.
//

import SwiftUI

struct KanjiView: View {
    
    @EnvironmentObject var manager: Manager
    
    var body: some View {
        
        ZStack {
            Text(manager.currentKanji.meaning)
                .font(.system(size: 25.0, weight: .light, design: .rounded))
                .padding(10)
                .background(Color(red: 0.851, green: 0.851, blue: 0.851))
                .cornerRadius(15.0)
        }
        
    }
}

#Preview {
    KanjiView()
        .environmentObject(Manager())
}
