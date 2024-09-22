//
//  ContentView.swift
//  NihonGo
//
//  Created by Medhansh Singla on 3/28/24.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var manager: Manager
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                manager.appBackground
                    .ignoresSafeArea()
                VStack {
                    StreakView()
                    NavigationLink(destination: VocabReviewView()) {
                        InfoView(destination: .vocab)
                    }
                    NavigationLink(destination: KanjiLessonPicker()) {
                        InfoView(destination: .kanji)
                    }
                    NavigationLink(destination: LiveTranslationView()) {
                        InfoView(destination: .live)
                    }
                }
                .padding()
            }
        }
        .onAppear {
                    manager.updateStreak()
                }
    }
}

struct InfoView: View {
    
    @EnvironmentObject var manager: Manager
    
    let destination: Destination
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(red: 0.851, green: 0.851, blue: 0.851))
                .shadow(radius: 10)
            HStack {
                VStack {
                    HStack {
                        Text(destination.rawValue)
                            .font(.system(size: 32.0, weight: .light, design: .rounded))
                        Spacer()
                    }
                    HStack {
                        Text(DestinationInfo(destination: destination).getInfo())
                            .font(.system(size: 12.0, weight: .light, design: .rounded))
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    .frame(width: 300)
                }
                .foregroundStyle(Color.black)
                Image(systemName: "chevron.right")
                    .resizable()
                    .frame(width: 20, height: 40)
                    .foregroundStyle(Color.black)
            }
            .padding()
        }
        .frame(width: 300, height: 125)
    }
    
    
}


#Preview {
    ContentView()
        .environmentObject(Manager())
}
