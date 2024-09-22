//
//  LessonView.swift
//  NihonGo
//
//  Created by Medhansh Singla on 3/30/24.
//

import SwiftUI

struct LessonView: View {
    
    let lesson: Int
    @EnvironmentObject var manager: Manager
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(red: 0.851, green: 0.851, blue: 0.851))
                .frame(height: 50)
            if lesson != 0 {
                Text("Lesson \(lesson)")
                    .font(.system(size: 20.0, weight: .light, design: .rounded))
                    .foregroundStyle(Color.black)
            }
            else {
                Text("Custom Vocab")
                    .font(.system(size: 20.0, weight: .light, design: .rounded))
                    .foregroundStyle(Color.black)
            }
        }
    }
}

#Preview {
    LessonView(lesson: 12)
        .environmentObject(Manager())
}
