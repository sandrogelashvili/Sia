//
//  UIColor.swift
//  Sia
//
//  Created by Sandro Gelashvili on 24.07.24.
//

import UIKit

extension UIColor {
    // Predefined custom colors
    static let appThemeGreenUIKit: UIColor = UIColor(hex: "#559F7C")
    static let gray400UIKit: UIColor = UIColor(#colorLiteral(red: 0.9800000191, green: 0.9800000191, blue: 0.9800000191, alpha: 1))
    
    // Convenience initializer for hex color strings
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: .alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        
        let (a, r, g, b): (CGFloat, CGFloat, CGFloat, CGFloat)
        
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (1.0, CGFloat((int >> 8) * 17) / 255, CGFloat((int >> 4 & 0xF) * 17) / 255, CGFloat((int & 0xF) * 17) / 255)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (1.0, CGFloat(int >> 16) / 255, CGFloat(int >> 8 & 0xFF) / 255, CGFloat(int & 0xFF) / 255)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (CGFloat(int >> 24) / 255, CGFloat(int >> 16 & 0xFF) / 255, CGFloat(int >> 8 & 0xFF) / 255, CGFloat(int & 0xFF) / 255)
        default:
            (a, r, g, b) = (1.0, 0.0, 0.0, 0.0) // Default to black if hex format is incorrect
        }
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
}
