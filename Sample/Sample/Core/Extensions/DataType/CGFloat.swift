//
//  CGFloat.swift
//  Sample
//
//  Created by Muneeb on 08/02/2022.
//

import UIKit

extension CGFloat {
    var autoSized : CGFloat {
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        let diagonalSize = sqrt((screenWidth * screenWidth) + (screenHeight * screenHeight))
        let percentage = CGFloat(self)/929*100 //894 is the diagonal size of iphone xs / 11pro
        return diagonalSize * percentage / 100
    }
    
    var widthRatio: CGFloat {
        let width = UIScreen.main.bounds.width/390 //iphone 11 pro
        return CGFloat(self)*width
    }
    
    var heightRatio: CGFloat {
        let width = UIScreen.main.bounds.height/844 //iphone 11 pro
        return CGFloat(self)*width
    }
}
