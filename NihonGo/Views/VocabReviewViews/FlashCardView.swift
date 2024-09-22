//
//  FlashCardView.swift
//  NihonGo
//
//  Created by Medhansh Singla on 3/29/24.
//

import SwiftUI

struct FlashCardView: View {
    
    @EnvironmentObject var manager: Manager
    let lesson: Int
    
    var body: some View {
        ZStack {
            manager.appBackground
                .ignoresSafeArea()
            VStack {
                if manager.reviewing {
                    FlashCard()
                    HStack(spacing: 0) {
                        ZStack {
                            Rectangle()
                                .fill(manager.showAnswer ? Color(red: 0.851, green: 0.851, blue: 0.851) : Color(red: 1, green: 0.769, blue: 0.694))
                                .frame(width: 150, height: 25)
                            Text("Japanese")
                        }
                        ZStack {
                            Rectangle()
                                .fill(!manager.showAnswer ? Color(red: 0.851, green: 0.851, blue: 0.851) : Color(red: 1, green: 0.769, blue: 0.694))
                                .frame(width: 150, height: 25)
                            Text("English")
                        }
                    }
                    .cornerRadius(10.0)
                    HStack {
                        VStack {
                            FlashCardButton(answer: .again)
                            FlashCardButton(answer: .easy)
                        }
                        VStack {
                            FlashCardButton(answer: .normal)
                            FlashCardButton(answer: .hard)
                        }
                    }
                    .padding()
                }
                else {
                    Text("Finished reviewing!")
                        .foregroundStyle(Color.white)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        DismissButton()
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        SettingsButton()
                    }
                }
    }
}

struct FlashCardButton: View {
    
    @EnvironmentObject var manager: Manager
    let answer: Vocab.Answer
    
    var body: some View {
        Button {
            withAnimation {
                manager.updateReview(answer)
                manager.nextCard()
            }
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(answer: answer))
                    .frame(width: 90, height: 25)
                Text(answer.rawValue)
                    .foregroundStyle(.black)
            }
        }
        
    }
}


#Preview {
    FlashCardView(lesson: 2)
        .environmentObject(Manager())
}
