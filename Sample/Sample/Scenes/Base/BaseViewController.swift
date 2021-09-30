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
    var leftBarButtonItem : UIBarButtonItem?
    var rightBarButtonItem : UIBarButtonItem?
    
    
    //MARK: - View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewUI()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: - Navigation Methods
    func setupNavigationBar(titleString: String = "", isTransparent: Bool = false) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        if let font = UIFont(name: "CircularStd-Book", size: 20) {
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: font,
                                                                       NSAttributedString.Key.foregroundColor: UIColor(named: "TextColor")!]
            navigationController?.navigationBar.barStyle = .default
        }
        
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
        
        if isTransparent {
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            navigationController?.view.backgroundColor = .clear
        } else {
            navigationController?.navigationBar.barTintColor = UIColor(named: "AccentColor")
            navigationController?.view.backgroundColor = UIColor(named: "AccentColor")
        }
        
        if titleString != "" {
            title = titleString
        }
    }
    
    
    func addMenuButton(){
        leftBarButtonItem =  UIBarButtonItem(image: #imageLiteral(resourceName: "SelectedPage"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(showSideMenu))
        navigationItem.leftBarButtonItem = leftBarButtonItem;
    }
    
    
    //MARK: - Navigation Helper Methods
    @objc func showSideMenu(_ sender: UIBarButtonItem) {
    }
    
    func loadLogoImageView(_ frame: CGRect) -> UIImageView {
        let imageView = UIImageView(frame: frame)
        imageView.image = #imageLiteral(resourceName: "SplashLogo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    
    //MARK: - Setup Methods
    func setViewUI() {
    }
    
    
    //MARK: - Helper Methods
    
    
    //MARK:- Loader Methods
    func startLoading(){
        self.view.isUserInteractionEnabled = false
        self.view.showLoader()
    }
    
    func stopLoading(){
        self.view.isUserInteractionEnabled = true
        self.view.removeLoader()
    }
}
