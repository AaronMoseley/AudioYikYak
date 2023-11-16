//
//  UIValues.swift
//  AudioYikYak
//
//  Created by Seun Adekunle on 11/16/23.
//

import Foundation
import UIKit
import SwiftUI

struct UIValues {
    static let customBackground: Color = Color(red: 0.98, green: 0.98, blue: 0.96, opacity: 1.00)
    
    static let cornerRadius: CGFloat = 15
    static let sidePadding: CGFloat = 20
    
    static func convertToColor(color: UIColor) -> Color {
            return Color(uiColor: color)
    }
}
