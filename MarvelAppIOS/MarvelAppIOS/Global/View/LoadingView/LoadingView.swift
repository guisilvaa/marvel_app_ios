//
//  LoadingView.swift
//  PayPaxx-Portador
//
//  Created by Guilherme Henrique Silva on 01/07/16.
//  Copyright © 2016 HubFintech. All rights reserved.
//

import UIKit
import Lottie

class LoadingView: UIView {

    @IBOutlet weak var animationView: AnimationView!
    
    static let TAG = 42

    class func loadFromNib(frame: CGRect) -> UIView
    {
        let nib = UINib(nibName: "LoadingView", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = frame
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        return view
    }
    
    override func awakeFromNib()
    {
        animationView.loopMode = .loop
        animationView.play()
    }
}
