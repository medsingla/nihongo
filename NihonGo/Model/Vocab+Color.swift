//
//  Vocab+Color.swift
//  NihonGo
//
//  Created by Medhansh Singla on 3/29/24.
//

import SwiftUI

extension Color {
    init(answer: Vocab.Answer) {
        switch answer {
        case .again:
            self = Color(#colorLiteral(red: 0.851, green: 0.851, blue: 0.851, alpha: 1))
        case .easy:
            self = Color(#colorLiteral(red: 0.714, green: 0.953, blue: 0.769, alpha: 1))
        case .normal:
            self = Color(#colorLiteral(red: 0.71, green: 0.914, blue: 1, alpha: 1))
        case .hard:
            self = Color(#colorLiteral(red: 1, green: 0.6, blue: 0.6, alpha: 1))
        }
    }
}
