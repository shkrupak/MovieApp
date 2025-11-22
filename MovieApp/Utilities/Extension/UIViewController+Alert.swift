//
//  Alert.swift
//  MovieApp
//
//  Created by Rupak Shakya on 22/11/2025.
//

import UIKit

extension UIViewController {
    func showAlertWith(message: String) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel))
        self.present(alertController, animated: true)
    }
}
