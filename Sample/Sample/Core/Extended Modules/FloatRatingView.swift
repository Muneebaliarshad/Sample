//
//  FloatRatingView.swift
//  Sample
//
//  Created by Muneeb on 27/09/2021.
//

import Foundation
import UIKit


@objc public protocol FloatRatingViewDelegate {
    ///Returns the rating value when touch events end
    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Float)
    ///Returns the rating value as the user pans
    @objc optional func floatRatingView(_ ratingView: FloatRatingView, isUpdating rating: Float)
}


///A simple rating view that can set whole, half or floating point ratings.
@IBDesignable
open class FloatRatingView: UIView {
    
    // MARK: - Properties
    open weak var delegate: FloatRatingViewDelegate?
    fileprivate var emptyImageViews: [UIImageView] = []
    fileprivate var fullImageViews: [UIImageView] = []
    var imageContentMode: UIView.ContentMode = UIView.ContentMode.scaleAspectFit
    
    
    //MARK: - IBInspectable
    @IBInspectable open var minImageSize: CGSize = CGSize(width: 1.0, height: 1.0)
    @IBInspectable open var editable: Bool = true
    @IBInspectable open var halfRatings: Bool = false
    @IBInspectable open var floatRatings: Bool = false
    
    @IBInspectable open var emptyImage: UIImage? {
        didSet {
            for imageView in emptyImageViews {
                imageView.image = emptyImage
            }
            refresh()
        }
    }
    
    @IBInspectable open var fullImage: UIImage? {
        didSet {
            for imageView in fullImageViews {
                imageView.image = fullImage
            }
            refresh()
        }
    }
    
    @IBInspectable open var minRating: Int  = 0 {
        didSet {
            if rating < Float(minRating) {
                rating = Float(minRating)
                refresh()
            }
        }
    }
    
    @IBInspectable open var maxRating: Int = 5 {
        didSet {
            if maxRating != oldValue {
                removeImageViews()
                initImageViews()
                setNeedsLayout()
                refresh()
            }
        }
    }
    
    @IBInspectable open var rating: Float = 0 {
        didSet {
            if rating != oldValue {
                refresh()
            }
        }
    }
    
    // MARK: - Initializations
    required override public init(frame: CGRect) {
        super.init(frame: frame)
        
        initImageViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initImageViews()
    }
    
    
    // MARK: - Helper methods
    fileprivate func initImageViews() {
        guard emptyImageViews.isEmpty && fullImageViews.isEmpty else {
            return
        }
        
        self.backgroundColor = UIColor.clear
        for _ in 0..<maxRating {
            let emptyImageView = UIImageView()
            emptyImageView.contentMode = imageContentMode
            emptyImageView.image = emptyImage
            emptyImageViews.append(emptyImageView)
            addSubview(emptyImageView)
            
            let fullImageView = UIImageView()
            fullImageView.contentMode = imageContentMode
            fullImageView.image = fullImage
            fullImageViews.append(fullImageView)
            addSubview(fullImageView)
        }
    }
    
    fileprivate func removeImageViews() {
        for i in 0..<emptyImageViews.count {
            var imageView = emptyImageViews[i]
            imageView.removeFromSuperview()
            imageView = fullImageViews[i]
            imageView.removeFromSuperview()
        }
        emptyImageViews.removeAll(keepingCapacity: false)
        fullImageViews.removeAll(keepingCapacity: false)
    }
    
    
    fileprivate func refresh() {
        for i in 0..<fullImageViews.count {
            let imageView = fullImageViews[i]
            
            if rating >= Float(i+1) {
                imageView.layer.mask = nil
                imageView.isHidden = false
            } else if rating > Float(i) && rating < Float(i+1) {
                let maskLayer = CALayer()
                maskLayer.frame = CGRect(x: 0, y: 0, width: CGFloat(rating-Float(i))*imageView.frame.size.width, height: imageView.frame.size.height)
                maskLayer.backgroundColor = UIColor.black.cgColor
                imageView.layer.mask = maskLayer
                imageView.isHidden = false
            } else {
                imageView.layer.mask = nil;
                imageView.isHidden = true
            }
        }
    }
    
    /// Calculates the ideal ImageView size in a given CGSize
    fileprivate func sizeForImage(_ image: UIImage, inSize size: CGSize) -> CGSize {
        let imageRatio = image.size.width / image.size.height
        let viewRatio = size.width / size.height
        
        if imageRatio < viewRatio {
            let scale = size.height / image.size.height
            let width = scale * image.size.width
            
            return CGSize(width: width, height: size.height)
        } else {
            let scale = size.width / image.size.width
            let height = scale * image.size.height
            
            return CGSize(width: size.width, height: height)
        }
    }
    
    /// Calculates new rating based on touch location in view
    fileprivate func updateLocation(_ touch: UITouch) {
        guard editable else {
            return
        }
        
        let touchLocation = touch.location(in: self)
        var newRating: Float = 0
        for i in stride(from: (maxRating-1), through: 0, by: -1) {
            let imageView = emptyImageViews[i]
            guard touchLocation.x > imageView.frame.origin.x else {
                continue
            }
            
            /// Find touch point in image view
            let newLocation = imageView.convert(touchLocation, from: self)
            
            /// Find decimal value for float or half rating
            if imageView.point(inside: newLocation, with: nil) && (floatRatings || halfRatings) {
                let decimalNum = Float(newLocation.x / imageView.frame.size.width)
                newRating = Float(i) + decimalNum
                if halfRatings {
                    newRating = Float(i) + (decimalNum > 0.75 ? 1 : (decimalNum > 0.25 ? 0.5 : 0))
                }
            } else {
                /// Whole rating
                newRating = Float(i) + 1.0
            }
            break
        }
        
        /// Check min rating
        rating = newRating < Float(minRating) ? Float(minRating) : newRating
        
        /// Update delegate
        delegate?.floatRatingView?(self, isUpdating: rating)
    }
    
    // MARK: - UIView
    
    /// Override to calculate ImageView frames
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        guard let emptyImage = emptyImage else {
            return
        }
        
        let desiredImageWidth = frame.size.width / CGFloat(emptyImageViews.count)
        let maxImageWidth = max(minImageSize.width, desiredImageWidth)
        let maxImageHeight = max(minImageSize.height, frame.size.height)
        let imageViewSize = sizeForImage(emptyImage, inSize: CGSize(width: maxImageWidth, height: maxImageHeight))
        let imageXOffset = (frame.size.width - (imageViewSize.width * CGFloat(emptyImageViews.count))) /
        CGFloat((emptyImageViews.count - 1))
        
        for i in 0..<maxRating {
            let imageFrame = CGRect(x: i == 0 ? 0 : CGFloat(i)*(imageXOffset+imageViewSize.width+2), y: 0, width: imageViewSize.width, height: imageViewSize.height)
            
            var imageView = emptyImageViews[i]
            imageView.frame = imageFrame
            
            imageView = fullImageViews[i]
            imageView.frame = imageFrame
        }
        
        refresh()
    }
    
    
    // MARK: - Touch events
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        updateLocation(touch)
    }
    
    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        updateLocation(touch)
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.floatRatingView(self, didUpdate: rating)
    }
    
    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.floatRatingView(self, didUpdate: rating)
    }
}
