//
//  TextEditorBackgroundModifier.swift
//  StormChaser
//
//  Created by Tung on 17/7/2025.
//

import SwiftUI

struct TextEditorBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(UIKitTextViewBackground())
    }

    private struct UIKitTextViewBackground: UIViewRepresentable {
        func makeUIView(context: Context) -> UIView {
            let view = UIView()
            view.backgroundColor = .white
            return view
        }

        func updateUIView(_ uiView: UIView, context: Context) {}
    }
}
