//
//  LiveTranslationView.swift
//  NihonGo
//
//  Created by Medhansh Singla on 4/8/24.
//

import SwiftUI

struct LiveTranslationView: View {
    
    @EnvironmentObject var manager: Manager
    
    var body: some View {
        LiveTextView()
            .popover(isPresented: $manager.showTranslation,
                     attachmentAnchor: .point(.center),
                     arrowEdge: .top,
                     content: {
                TranslationView()
                    .onAppear(perform: {
                        manager.translatedText = ""
                    })
            })
    }
}



struct TranslationView: View {
    
    @EnvironmentObject var manager: Manager
    
    var body: some View {
        VStack {
            Text("Text from Camera")
                .padding(.top)
            TextViewWrapper(text: $manager.liveText)
                .padding()
                .border(Color.gray)
                .frame(height: 150)
            .padding()
            Text("Selected Text")
            ScrollView {
                Text(manager.selectedText ?? "None")
                    .padding()
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .scrollBounceBehavior(.basedOnSize, axes: [.vertical])
            .border(Color.gray)
            .frame(height: 150)
            .padding()
            Text("Translated Text")
            ScrollView {
                Text(manager.translatedText ?? "None")
                    .padding()
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .scrollBounceBehavior(.basedOnSize, axes: [.vertical])
            .border(Color.gray)
            .frame(height: 150)
            .padding()
            Button {
                manager.addVocab()
            } label: {
                Text("Add to Vocab")
                    .padding(10)
                    .background(Color(red: 0.918, green: 0.467, blue: 0.467))
                    .foregroundStyle(Color.white)
                    .cornerRadius(15.0)
            }
            .disabled(manager.present)
        }
    }
}

#Preview {
    TranslationView()
        .environmentObject(Manager())
}
