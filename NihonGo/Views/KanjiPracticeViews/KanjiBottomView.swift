//
//  KanjiBottomView.swift
//  NihonGo
//
//  Created by Medhansh Singla on 4/2/24.
//

import SwiftUI

struct KanjiBottomView: View {
    
    @EnvironmentObject var manager: Manager
    
    var body: some View {
        HStack(alignment: .bottom) {
            HintButtonView(hint: manager.currentKanji.reading)
                .frame(width: 30)
                .foregroundStyle(Color(red: 0.851, green: 0.851, blue: 0.851))
                .padding(.leading, 20)
            ZStack {
                RoundedRectangle(cornerRadius: 15.0)
                    .fill(manager.correct ? Color(red: 0.714, green: 0.953, blue: 0.769) : Color(red: 1, green: 0.6, blue: 0.6))
                    .frame(width: 180, height: 50)
                Text(manager.correct ? "Correct" : "Incorrect")
                    .font(.system(size: 25.0, weight: .light, design: .rounded))
            }
            Button {
                manager.nextKanji()
            } label: {
                Text(manager.correct ? "Next" : "Skip")
                    .font(.system(size: 15.0, weight: .light, design: .rounded))
                    .foregroundStyle(Color.black)
                    .padding(10)
                    .background(manager.correct ? Color(red: 0.714, green: 0.953, blue: 0.769) : Color(red: 1, green: 0.6, blue: 0.6))
                    .cornerRadius(15.0)
                    .frame(width: 51)
            }
        }
    }
}

#Preview {
    KanjiBottomView()
        .environmentObject(Manager())
}
