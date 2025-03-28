//
//  ViewExtensions.swift
//  Humor-TCA
//
//  Created by Sucu, Ege on 28.03.2025.
//

import SwiftUI

extension View {
    func jokeStyle() -> some View {
        modifier(JokeTextStyle())
    }
}
