//
//  JokeTextStyle.swift
//  Humor-TCA
//
//  Created by Sucu, Ege on 28.03.2025.
//

import SwiftUI

struct JokeTextStyle: ViewModifier {

    func body(content: Content) -> some View {
        content
            .multilineTextAlignment(.center)
            .font(.callout)
            .italic()
            .bold()
            .foregroundStyle(.gray)
    }
}
