//
//  PrimaryButtonStyle.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 15/08/2021.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    // MARK: Public Properties

    let color: Color

    // MARK: Public Methods

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(10)
            .foregroundColor(configuration.isPressed ? color.opacity(0.5) : color)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(configuration.isPressed ? color.opacity(0.5) : color, lineWidth: 1.5)
            )
    }
}
