//
//  UIImageViewExtension.swift
//  Tmdb
//
//  Created by Guilherme Silva on 22/03/21.
//

import Foundation
import Kingfisher

extension UIImageView {
    
    @IBInspectable
    public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    func roundCornersForAspectFit(radius: CGFloat)
    {
        if let image = self.image {

            //calculate drawingRect
            let boundsScale = self.bounds.size.width / self.bounds.size.height
            let imageScale = image.size.width / image.size.height

            var drawingRect: CGRect = self.bounds

            if boundsScale > imageScale {
                drawingRect.size.width =  drawingRect.size.height * imageScale
                drawingRect.origin.x = (self.bounds.size.width - drawingRect.size.width) / 2
            } else {
                drawingRect.size.height = drawingRect.size.width / imageScale
                drawingRect.origin.y = (self.bounds.size.height - drawingRect.size.height) / 2
            }
            let path = UIBezierPath(roundedRect: drawingRect, cornerRadius: radius)
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
    
    func loadImage(url: String, placeholder: UIImage? = nil) {
        
        let url = URL(string: url)
        
        self.kf.setImage(
            with: url,
            placeholder: placeholder,
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0.3)),
                .cacheOriginalImage
            ])
    }
}
