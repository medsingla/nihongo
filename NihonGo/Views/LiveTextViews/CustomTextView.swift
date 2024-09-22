//
//  CustomTextView.swift
//  NihonGo
//
//  Created by Medhansh Singla on 4/8/24.
//

import SwiftUI

struct TextViewWrapper: UIViewRepresentable {
    
    @Binding var text: String
    
    @EnvironmentObject var manager: Manager

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isEditable = false // Set to true if you want it to be editable
        textView.isSelectable = true // Enable text selection
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.delegate = context.coordinator
        return textView
    }

    func updateUIView(_ textView: UITextView, context: Context) {
        textView.text = text
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: TextViewWrapper

        init(_ parent: TextViewWrapper) {
            self.parent = parent
        }

        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }
        
        func textViewDidChangeSelection(_ textView: UITextView) {
            if let selectedRange = textView.selectedTextRange, let selectedText = textView.text(in: selectedRange) {
                if selectedText.isEmpty {
                    parent.manager.selectedText = nil
                    parent.manager.translatedText = nil
                }
                else {
                    parent.manager.selectedText = selectedText
                    parent.manager.translate()
                }
            }
        }
    }
}
