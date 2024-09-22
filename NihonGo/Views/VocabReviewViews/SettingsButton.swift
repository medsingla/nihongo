//
//  SettingsButton.swift
//  NihonGo
//
//  Created by Medhansh Singla on 4/23/24.
//

import SwiftUI

struct SettingsButton: View {
    
    @EnvironmentObject var manager: Manager
    @State var show = false
    
    var body: some View {
        Button {
            self.show = true
        }
        label: {Image(systemName: "gear")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(Color.white)
        }
        .sheet(isPresented: $show) {
            List {
                Button {
                    manager.shuffleCards()
                } label: {
                    Text("Shuffle Cards")
                }
                Button {
                    manager.resetCards()
                } label: {
                    Text("Reset Cards")
                        .foregroundStyle(Color.red)
                }
            }
                .presentationDetents([.fraction(0.15)])
        }
    }
    
}

#Preview {
    SettingsButton()
        .environmentObject(Manager())
}
