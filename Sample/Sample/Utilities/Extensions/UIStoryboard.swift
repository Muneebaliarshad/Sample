//
//  UIStoryboard.swift
//  Sample
//
//  Created by Muneeb on 27/09/2021.
//

import UIKit

enum storyboards : String {
    
    ///All Storyboards Name
    case Main = "Main"
}


extension UIStoryboard {
    
    /// Generic Public/Instance Methods
    func loadViewController(withIdentifier identifier: String) -> UIViewController {
        return self.instantiateViewController(withIdentifier:  identifier)
    }
    
    //MARK:- Class Methods to load Storyboards
    
    class func storyBoard(withName name: storyboards) -> UIStoryboard {
        return UIStoryboard(name: name.rawValue , bundle: Bundle.main)
    }
    
    class func storyBoard(withTextName name:String) -> UIStoryboard {
        return UIStoryboard(name: name , bundle: Bundle.main)
    }
    
}



extension UINavigationController {
    
    ///Get previous view controller of the navigation stack
    func previousViewController() -> UIViewController?{
        let lenght = self.viewControllers.count
        let previousViewController: UIViewController? = lenght >= 2 ? self.viewControllers[lenght-2] : nil
        return previousViewController
    }
    
}


extension UIApplication {
    
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
