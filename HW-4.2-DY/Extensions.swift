//
//  Extensions.swift
//  HW-4.2-DY
//
//  Created by Denis Yarets on 16/12/2023.
//

import SwiftUI

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 50, alignment: .trailing)
    }
}

extension TextField {
    func modified(_ isFocused: FocusState<Bool>.Binding) -> some View {
        ModifiedContent(
            content: self
                .textFieldStyle(.roundedBorder)
                .multilineTextAlignment(.trailing)
                .focused(isFocused)
                .keyboardType(.decimalPad)
            ,
            modifier: TextFieldModifier()
        )
    }
}
