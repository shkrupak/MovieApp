//
//  Colors.swift
//  MovieApp
//
//  Created by Rupak Shakya on 20/11/2025.
//

import UIKit

extension UIColor {
    struct App {
        static var primary: UIColor {
            UIColor(named: "Primary") ?? .gray
        }
        
        static var secondary: UIColor {
            UIColor(named: "Secondary") ?? .gray
        }
        
        static var card: UIColor {
            UIColor(named: "Card") ?? .gray
        }
        
        static var background: UIColor {
            UIColor(named: "Background") ?? .gray
        }
        
        static var favorite: UIColor {
            UIColor(named: "Favorite") ?? .gray
        }
        
        static var text: UIColor {
            UIColor(named: "Text") ?? .gray
        }
        
        static var navigationBar: UIColor {
            UIColor(named: "NavigationBar") ?? .gray
        }
    }
}
