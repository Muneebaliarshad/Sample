//
//  BaseViewController.swift
//  Sample
//
//  Created by Muneeb on 30/09/2021.
//

import Foundation
import UIKit


typealias success = (Bool) -> Void


class BaseViewController: UIViewController {
    
    //MARK: - Variables
    
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setViewUI()
        bindViews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: - Setup Methods
    func setViewUI() {
    }
    
    func bindViews() {
    }
}
