//
//  Extensions.swift
//  ColorMix
//
//  Created by Ylyas Abdywahytow on 9/14/24.
//

import Foundation
import SwiftUI

extension Color {
    func blend(with color: Color) -> Color {
        let color1Components = UIColor(self).cgColor.components ?? [0, 0, 0, 0]
        let color2Components = UIColor(color).cgColor.components ?? [0, 0, 0, 0]
        
        let red = (color1Components[0] + color2Components[0]) / 2
        let green = (color1Components[1] + color2Components[1]) / 2
        let blue = (color1Components[2] + color2Components[2]) / 2
        
        return Color(red: red, green: green, blue: blue)
    }
}
