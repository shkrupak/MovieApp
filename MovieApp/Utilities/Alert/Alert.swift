//
//  Alert.swift
//  MovieApp
//
//  Created by Rupak Shakya on 22/11/2025.
//

import UIKit

enum MovieAlert: String {
    case noMovieDetail = "Unable to load movie detail"
    case noInternet = "Internet connection is not available"
    
}

extension UIViewController {
    func showAlertWith(message: MovieAlert) {
        let alertController = UIAlertController(title: "", message: message.rawValue, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel))
        self.present(alertController, animated: true)
    }
}
