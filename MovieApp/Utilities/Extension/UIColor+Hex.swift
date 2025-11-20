//
//  UIColor+Hex.swift
//  MovieApp
//
//  Created by Rupak Shakya on 20/11/2025.
//

import UIKit

extension UIColor {

    // http://stackoverflow.com/a/27203691/940936
    static func fromHex(_ hex: String) -> UIColor {
        //removing whitespace and change to uppercase
        var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        //remove '#' if it is included in prefix
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }

        if cString.count != 6 {
            return .gray
        }

        //64-bit integer to store the converted hex value
        var rgbValue: UInt64 = 0
        
        //converts the hex string into an integer value
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

}
