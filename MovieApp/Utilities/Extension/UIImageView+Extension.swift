//
//  UIImageView+Extension.swift
//  MovieApp
//
//  Created by Rupak Shakya on 20/11/2025.
//

import UIKit
import SDWebImage

extension UIImageView {
    func setImage(named image: String, completion: @escaping (Bool) -> Void) {
        let url = URL(string: "\(APIConstant.getImageBaseUrl())\(image))")
        self.sd_imageTransition = .fade
        self.sd_setImage(with: url) { image, error, _, _ in
            if error == nil {
                completion(true)
            }
            else {
                completion(false)
            }
        }
    }
}
