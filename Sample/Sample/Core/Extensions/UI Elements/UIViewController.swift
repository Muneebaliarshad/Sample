//
//  UIViewController.swift
//  Sample
//
//  Created by Muneeb on 08/02/2022.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, image: AlertImage , defaultButton : DefaultButton , destructiveButton: DestructiveButton) {
        let popupController = AlertController(title: title, message: message, image: image, defaultButton: defaultButton, destructiveButton: destructiveButton)
        popupController.delegate = self as? AlertControllerDelegate
        popupController.modalPresentationStyle = .overFullScreen
        popupController.modalTransitionStyle = .crossDissolve
        self.view.endEditing(true)
        self.present(popupController, animated: false, completion: nil)
    }
}
