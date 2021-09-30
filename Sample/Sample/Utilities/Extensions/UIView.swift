//
//  UIView.swift
//  Sample
//
//  Created by Muneeb on 27/09/2021.
//

import UIKit
import NVActivityIndicatorView


extension UIView {
    
    //MARK: - IBInspectable
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        } set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
            self.clipsToBounds = true
        }
    }
    
    
    @IBInspectable var isRoundView: Bool {
        get {
            return self.isRoundView
        }
        set(isRoundView){
            if(isRoundView){
                self.layer.cornerRadius = self.frame.size.height / 2
                self.clipsToBounds = true
            }
        }
    }
    
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        } set {
            layer.borderWidth = newValue
        }
    }
    
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        } set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    
    //MARK: - Animation
    func shadow(color: UIColor) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 5.0
        layer.masksToBounds = false
    }
    
    
    func setViewWithAnimation(alpha: CGFloat) {
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveEaseIn, animations: { () -> Void in
            self.alpha = alpha
        })
    }
    
    
    //MARK: - View Modification Methods
    func round(corners: UIRectCorner, cornerRadius: Double) {
        self.layoutIfNeeded()
        let size = CGSize(width: cornerRadius, height: cornerRadius)
        let bezierPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: size)
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        shapeLayer.path = bezierPath.cgPath
        self.layer.mask = shapeLayer
    }
    
    
    //MARK: - Loader Methods
    func showLoader(loaderWidth: Int = 100, loaderHeight: Int = 100) {
        let loadingView = UIView()
        loadingView.frame = self.bounds
        loadingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        loadingView.tag = 112233
        
        let activityIndicator = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: loaderWidth, height: loaderHeight), type:  .circleStrokeSpin, color: UIColor(named: "TextColor"), padding: 0.0)
        activityIndicator.center = self.center
        activityIndicator.startAnimating()
        loadingView.addSubview(activityIndicator)
        self.addSubview(loadingView)
    }
    
    func removeLoader() {
        DispatchQueue.main.async {
            self.subviews.forEach { (view) in
                if view.tag == 112233 {
                    view.removeFromSuperview()
                }
            }
        }
    }
    
    
}
