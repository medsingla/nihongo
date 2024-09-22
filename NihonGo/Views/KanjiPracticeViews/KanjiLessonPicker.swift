//
//  KanjiLessonPicker.swift
//  NihonGo
//
//  Created by Medhansh Singla on 4/2/24.
//

import SwiftUI

struct KanjiLessonPicker: View {
    
    @EnvironmentObject var manager: Manager
    
    var body: some View {
        ZStack {
            manager.appBackground
                .ignoresSafeArea()
            ScrollView {
                ForEach(3..<13) { i in
                    NavigationLink(destination: KanjiPracticeView()) {
                        LessonView(lesson: i)
                            .padding(5)
                            .padding(.leading, 20)
                            .padding(.trailing, 20)
                            .navigationBarTitle("")
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        manager.lesson = i
                        manager.startKanjiReview()
                    })
                }
            }
            .toolbarBackground(manager.appBackground, for: .navigationBar)
            .navigationBarBackButtonHidden(true)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            DismissButton()
                        }
                    }
        }
    }
}

#Preview {
    KanjiLessonPicker()
        .environmentObject(Manager())
}
