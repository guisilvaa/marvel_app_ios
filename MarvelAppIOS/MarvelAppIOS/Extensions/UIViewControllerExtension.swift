//
//  UIViewControllerExtension.swift
//  Tmdb
//
//  Created by Guilherme Silva on 22/03/21.
//

import UIKit
import Kako
import PopupDialog

extension UIViewController {
    
    func showLoading(show: Bool)
    {
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            if show {
                if let _ = window.viewWithTag(LoadingView.TAG)
                {
                    return
                }
                
                let loading = LoadingView.loadFromNib(frame: UIScreen.main.bounds)
                loading.tag = LoadingView.TAG
                window.addSubview(loading)
            }
            else {
                window.viewWithTag(LoadingView.TAG)?.removeFromSuperview()
            }
        }
    }
    
    
    public func showErrorMessage(title: String? = nil, error: KakoError?, completionHandler: (() -> Void)? = nil) {
        
        let title = title ?? "ERROR_TITLE".localized()
        var message = "ERROR_GENERIC_MESSAGE".localized()
        
        if let error = error, let code = error.code, let errorType = KakoErrorType(rawValue: code) {
            if errorType == KakoErrorType.connection {
                message = "ERROR_CONECTION_MESSAGE".localized()
            }
        }
        
        self.showAlertDialog(title: title, message: message, completionHandler: completionHandler)
    }
    
    public func showAlertDialog(title: String? = nil,
                                 message: String,
                                 dismissal: Bool = true,
                                 completionHandler: (() -> Void)? = nil)
    {
        let popup = PopupDialog(title: title,
                                message: message,
                                buttonAlignment: .horizontal,
                                transitionStyle: .bounceUp,
                                tapGestureDismissal: dismissal,
                                panGestureDismissal: dismissal,
                                completion: completionHandler)
        
        let okButton = DefaultButton(title: "Ok", action: nil)
        popup.addButton(okButton)
        
        present(popup, animated: true, completion: nil)
    }
}
