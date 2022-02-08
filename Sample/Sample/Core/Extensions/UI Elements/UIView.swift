//
//  UIView.swift
//  Sample
//
//  Created by Muneeb on 08/02/2022.
//

import UIKit

extension UIView {
    //MARK: - Properties
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        } set {
            layer.borderWidth = newValue
        }
    }
    
    var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        } set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    
    //MARK: - Methods
    func shadow(color: UIColor) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 5.0
        layer.masksToBounds = false
    }
    
    
}
