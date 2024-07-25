//
//  ColorExtensionForHex.swift
//  Sia
//
//  Created by Sandro Gelashvili on 13.07.24.
//

import SwiftUI

extension Color {
    // Static color properties
    static let appThemeGreenSwiftUI: Color = Color(hex: "#559F7C") ?? .clear
    static let gray400SwiftUI: Color = Color(#colorLiteral(red: 0.9800000191, green: 0.9800000191, blue: 0.9800000191, alpha: 1))
    
    // Consolidated initializer for hex color strings
    init?(hex: String) {
        let r, g, b, a: Double
        
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (1.0, (Double(int >> 8) * 17) / 255, (Double(int >> 4 & 0xF) * 17) / 255, (Double(int & 0xF) * 17) / 255)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (1.0, Double(int >> 16) / 255, Double(int >> 8 & 0xFF) / 255, Double(int & 0xFF) / 255)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (Double(int >> 24) / 255, Double(int >> 16 & 0xFF) / 255, Double(int >> 8 & 0xFF) / 255, Double(int & 0xFF) / 255)
        default:
            return nil
        }
        
        self.init(red: r, green: g, blue: b, opacity: a)
    }
}
