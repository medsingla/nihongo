//
//  StreakView.swift
//  NihonGo
//
//  Created by Medhansh Singla on 4/28/24.
//

import SwiftUI

struct StreakView: View {
    
    @EnvironmentObject var manager: Manager
    
    var body: some View {
        Text("\(String(manager.streakCount)) day\(manager.streakCount == 1 ? "" : "s") study streak")
            .foregroundStyle(Color.white)
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 250, height: 50)
                .foregroundStyle(Color(red: 0.851, green: 0.851, blue: 0.851))
                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
            RoundedRectangle(cornerRadius: 10)
                .frame(width: min(CGFloat(manager.streakCount) / CGFloat(10) * 250, 250), height: 50)
                .foregroundColor(Color(#colorLiteral(red: 0.714, green: 0.953, blue: 0.769, alpha: 1)))
        }
        .padding(.bottom)
    }
}

#Preview {
    StreakView()
        .environmentObject(Manager())
}
