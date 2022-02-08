//
//  NavigationController.swift
//  Sample
//
//  Created by Muneeb on 08/02/2022.
//

import UIKit

class NavigationController: UINavigationController, UINavigationControllerDelegate {
    
    //MARK: - Variables
    
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        customizeNavigationTitle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    //MARK: - Helper Methods
    func customizeNavigationTitle() {
        navigationBar.barTintColor = .themeColor
        navigationBar.tintColor = .white
        navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
    }
    
    //MARK: - UINavigationControllerDelegate
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let item = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem = item
    }
}
