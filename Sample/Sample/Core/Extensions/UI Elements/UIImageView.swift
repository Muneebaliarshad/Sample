//
//  UIImageView.swift
//  Sample
//
//  Created by Muneeb on 08/02/2022.
//

import UIKit
import SDWebImage


extension UIImageView {
    func setImageWith(stringURL: String) {
        sd_imageTransition = .fade
        sd_setImage(with: stringURL.createURL(), placeholderImage: UIImage(named: "Logo"))
    }
}
