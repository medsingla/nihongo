//
//  DismissButton.swift
//  NihonGo
//
//  Created by Medhansh Singla on 4/5/24.
//

import SwiftUI

struct DismissButton: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "arrow.left.square")
                .foregroundStyle(Color.white)
        }
    }
}

#Preview {
    DismissButton()
}
