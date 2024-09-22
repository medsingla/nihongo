//
//  VocabReviewView.swift
//  NihonGo
//
//  Created by Medhansh Singla on 3/30/24.
//

import SwiftUI

struct VocabReviewView: View {
    
    @EnvironmentObject var manager: Manager
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            manager.appBackground
                .ignoresSafeArea()
            ScrollView {
                ForEach(0..<24) { i in
                    NavigationLink(destination: FlashCardView(lesson: i)) {
                        LessonView(lesson: i)
                            .padding(5)
                            .padding(.leading, 20)
                            .padding(.trailing, 20)
                            .navigationBarTitle("")
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        manager.lesson = i
                        manager.startReview()
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
    VocabReviewView()
        .environmentObject(Manager())
}
