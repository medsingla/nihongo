//
//  KanjiPracticeView.swift
//  NihonGo
//
//  Created by Medhansh Singla on 3/30/24.
//

import SwiftUI

struct KanjiPracticeView: View {
    
    @EnvironmentObject var manager: Manager
    
    var body: some View {
        ZStack {
            manager.appBackground
                .ignoresSafeArea()
            VStack {
                Spacer()
                KanjiBottomView()
                Rectangle()
                    .frame(height: 2)
                    .foregroundStyle(Color.white)
                KanjiWritingView()
                Rectangle()
                    .frame(height: 2)
                    .foregroundStyle(Color.white)
                KanjiView()
                    .padding()
                Button {
                    manager.speaker.speak(manager.currentKanji.kanji, language: "ja-JP")
                } label: {
                    Image(systemName: "mic")
                        .resizable()
                        .frame(width: 30, height: 50)
                        .foregroundStyle(Color.white)
                }
                WritingControls()
            }
        }
        .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        DismissButton()
                    }
                }
    }
}

struct WritingControls: View {
    
    @EnvironmentObject var manager: Manager
    
    var body: some View {
        HStack {
            Button {
                manager.resetKanji()
            } label: {
                Image(systemName: "trash")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundStyle(Color.white)
            }
            Button {
                manager.getAnswer()
            } label: {
                Text("Submit")
                    .font(.system(size: 20.0, weight: .light, design: .rounded))
                    .foregroundStyle(Color.black)
                    .padding(10)
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                    .background(Color(answer: Vocab.Answer.normal))
                    .cornerRadius(15.0)
            }
            .padding()
            Button {
                manager.undoStroke()
            } label: {
                Image(systemName: "arrow.uturn.backward")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundStyle(Color.white)
            }
        }
    }
    
}

#Preview {
    KanjiPracticeView()
        .environmentObject(Manager())
}
