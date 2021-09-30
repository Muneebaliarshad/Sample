//
//  ControllerManager.swift
//  Sample
//
//  Created by Muneeb on 27/09/2021.
//

import UIKit

@available(iOS 13.0, *)
let Scene_Delegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
let App_Delegate = UIApplication.shared.delegate as! AppDelegate
var isVisitor = false
var isLogedIn = false


class ControllerManager : NSObject {
    
    //MARK: - Variables
    
    
    //MARK: - Helper Methods
    final class func isLoginUser() -> Bool {
        if let user = UserDefaultsManager.getUserModel() {
            if user._id == "" {
                return false
            } else {
                return true
            }
        } else {
            return false
        }
    }
    
    //MARK: - Root Methods
    final class func setRootView(window: UIWindow?) {
        if #available(iOS 13.0, *){
            setRootAsLogin(window: window ?? Scene_Delegate.window!)
        } else {
            setRootAsLogin(window: window ?? App_Delegate.window!)
        }
    }
    
    
    final class func setRootAsLogin(window: UIWindow) {
        setOnBoardingAsRootView(window: window)
    }
    
    
    final class func setOnBoardingAsRootView(window: UIWindow) {
        let storyboard = UIStoryboard(name: "OnBoarding", bundle: Bundle.main)
        let onBoardingVC = storyboard.instantiateViewController(withIdentifier: "OnBoardingViewController")
        window.rootViewController = onBoardingVC
        window.makeKeyAndVisible()
    }
}
