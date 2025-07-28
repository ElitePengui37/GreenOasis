//
//  Theme.swift
//  GreenOasisGardeningCentre
//
//  Created by Daniel Sergeev on 13/5/2025.
//

import SwiftUI

// extension for colour was found from chatGPT (propmpt: How to use hex colours in swift)
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hex)
        if hex.hasPrefix("#") {
            scanner.currentIndex = hex.index(after: hex.startIndex)
        }

        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double(rgb & 0xFF) / 255

        self.init(red: r, green: g, blue: b)
    }
}


// returns backgorund gradient (for reuse)
func LoadBackgroundTheme() -> some View
{
    LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: Color(hex: "#3E014D"), location: 0.0),
                    .init(color: Color(hex: "#270130"), location: 0.25),
                    .init(color: Color(hex: "#110015"), location: 0.75),
                    .init(color: Color(hex: "#000000"), location: 1.0)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
}
