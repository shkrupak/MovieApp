//
//  AppConfiguration.swift
//  MovieApp
//
//  Created by Rupak Shakya on 20/11/2025.
//

import UIKit

final class AppConfiguration {
    
    static func setup() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
        appearance.shadowColor = .clear
        
        appearance.titleTextAttributes = [.foregroundColor: UIColor.App.text]
        
        let navbar = UINavigationBar.appearance()
        navbar.standardAppearance = appearance
        navbar.scrollEdgeAppearance = appearance
        navbar.compactAppearance = appearance
        navbar.tintColor = .black
    }
}
