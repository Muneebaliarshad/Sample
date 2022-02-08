//
//  UIApplication.swift
//  Sample
//
//  Created by Muneeb on 08/02/2022.
//

import UIKit


extension UIApplication {
    static var topSafeAreaHeight: CGFloat {
        var topSafeAreaHeight: CGFloat = 0
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.windows[0]
            let safeFrame = window.safeAreaLayoutGuide.layoutFrame
            topSafeAreaHeight = safeFrame.minY
        }
        return topSafeAreaHeight
    }
    
    
    class func getTopViewController() -> UIViewController? {
        var finalViewController = UIViewController()
        if var topController = shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            finalViewController = topController
        }
        return finalViewController
    }
}
