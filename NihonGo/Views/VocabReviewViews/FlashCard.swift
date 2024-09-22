//
//  FlashCard.swift
//  NihonGo
//
//  Created by Medhansh Singla on 3/28/24.
//

import SwiftUI

struct FlashCard: View {
    
    @EnvironmentObject var manager: Manager
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(red: 0.851, green: 0.851, blue: 0.851))
                .frame(width: 350, height: 350)
                .shadow(radius: 5)
            
            VStack {
                HStack {
                    Spacer()
                    HintButtonView(hint: manager.currentVocab.kanji)
                        .foregroundStyle(Color(red: 0.918, green: 0.467, blue: 0.467))
                        .frame(width: 30)
                        .padding()
                }
                .frame(width: 350, height: 75)
                Text(manager.showAnswer ? manager.currentVocab.meaning : manager.currentVocab.kana)
                    .font(.system(size: 40.0, weight: .light, design: .rounded))
                    .foregroundColor(.black)
                    .frame(width: 350, height: 200)
                Button {
                    if manager.showAnswer {
                        manager.speaker.speak(manager.currentVocab.meaning, language: "en-US")
                    }
                    else {
                        manager.speaker.speak(manager.currentVocab.kana, language: "ja-JP")
                    }
                } label: {
                    Image(systemName: "mic.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 40)
                        .foregroundStyle(Color(red: 0.918, green: 0.467, blue: 0.467))
                }
                .frame(width: 350, height: 75)
                    
            }
            .frame(width: 350, height: 350)
        }
        .rotation3DEffect(
            .degrees(manager.showAnswer ? 180 : 0),
            axis: (x: 1.0, y: 0.0, z: 0.0))
        .onTapGesture {
            withAnimation(.easeInOut) {
                manager.showAnswer.toggle()
            }
        }
        .rotation3DEffect(
            .degrees(manager.showAnswer ? 180 : 0),
            axis: (x: 1.0, y: 0.0, z: 0.0)
        )
    }
}

#Preview {
    FlashCard()
        .environmentObject(Manager())
}
