//
//  HintButtonView.swift
//  NihonGo
//
//  Created by Medhansh Singla on 4/4/24.
//

import SwiftUI

struct HintButtonView: View {
    
    @EnvironmentObject var manager: Manager
    var hint: String
    @State var show = false
    
    var body: some View {
        Button {
            self.show = true
        }
        label: {Image(systemName: "questionmark.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .popover(isPresented: self.$show,
                attachmentAnchor: .point(.center),
                arrowEdge: .top,
                content: {
                    Text(hint.isEmpty ? "None" : hint)
                        .padding()
                        .foregroundStyle(Color.black)
                        .presentationCompactAdaptation(.none)
                        .onTapGesture {
                            self.show = false
                        }
                }
        )
    }
}
