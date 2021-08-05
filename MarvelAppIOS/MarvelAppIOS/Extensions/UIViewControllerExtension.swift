//
//  UIViewControllerExtension.swift
//  Tmdb
//
//  Created by Guilherme Silva on 22/03/21.
//

import UIKit

extension UIViewController {
    
    func showLoading(_ show: Bool)
    {
        let window = UIApplication.shared.delegate?.window
        if show {
            if let _ = window??.viewWithTag(LoadingView.TAG)
            {
                return
            }
            
            let loading = LoadingView.loadFromNib(frame: UIScreen.main.bounds)
            loading.tag = LoadingView.TAG
            window??.addSubview(loading)
        }
        else {
            window??.viewWithTag(LoadingView.TAG)?.removeFromSuperview()
        }
    }
    /*
    public func showErrorMessage(title: String? = nil, error: GameficError?, completionHandler: (() -> Void)? = nil) {
        
        if let error = error, let code = error.code, let errorType = GameficErrorType(rawValue: code) {
            if errorType == GameficErrorType.unauthorized {
                self.showAlertMessage(message: GameficErrorType.unauthorized.localizedMessage(), icon: UIImage(named: "icDialogError")!) {
                    AuthenticationManager.shared.logout()
                }
            }
            else if errorType == GameficErrorType.invalidAppVersion {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let versionViewController = storyboard.instantiateViewController(withIdentifier: "VersionOutdatedViewController")
                versionViewController.modalPresentationStyle = .fullScreen
                appDelegate.window?.rootViewController?.present(versionViewController, animated: true, completion: nil)
            }
            else {
                self.showAlertDialog(title: title, message: "UNKNOWN_SERVER_ERROR".localized(), icon: UIImage(named: "icDialogError")!, completionHandler: completionHandler)
            }
        }
        else {
            self.showAlertDialog(title: title, message: error?.userMessage ?? "UNKNOWN_SERVER_ERROR".localized(), icon: UIImage(named: "icDialogError")!, completionHandler: completionHandler)
        }
    }
    
    public func showAlertMessage(title: String? = nil, message: String, icon: UIImage? = nil, completionHandler: (() -> Void)? = nil) {
        self.showAlertDialog(title: title, message: message, icon: icon ?? UIImage(named: "icDialogSuccess")!, completionHandler: completionHandler)
    }
    
    public func showAlertDialog(title: String? = nil,
                                 message: String,
                                 icon: UIImage,
                                 dismissal: Bool = true,
                                 completionHandler: (() -> Void)? = nil)
    {
        let viewController = ErrorAlertDialog(nibName: "ErrorAlertDialog", bundle: nil)
        viewController.icon = icon
        viewController.alertTitle = title
        viewController.message = message
        
        showCustomDialog(viewController: viewController, dismissal: dismissal, completionHandler: completionHandler)
    }
    
    public func showConfirmationDialog(title: String? = nil,
                                       message: String,
                                       icon: UIImage? = nil,
                                       confirmButton: String,
                                       cancelButton: String,
                                       dismissal: Bool = true,
                                       confirmHandler: (() -> Void)? = nil,
                                       cancelHandler: (() -> Void)? = nil)
    {
        let viewController = ConfirmationDialog(nibName: "ConfirmationDialog", bundle: nil)
        viewController.icon = icon ?? UIImage(named: "icInfoDialog")!
        viewController.alertTitle = title
        viewController.message = message
        viewController.confirmButton = confirmButton
        viewController.confirmBlock = confirmHandler
        viewController.cancelButton = cancelButton
        viewController.cancelBlock = cancelHandler
        
        showCustomDialog(viewController: viewController, dismissal: dismissal)
    }
    
    public func showCustomDialog(viewController: UIViewController, dismissal: Bool = true, completionHandler: (() -> Void)? = nil) {
        let popup = PopupDialog(viewController: viewController,
                                buttonAlignment: .horizontal,
                                transitionStyle: .bounceUp,
                                tapGestureDismissal: dismissal,
                                panGestureDismissal: dismissal,
                                completion: completionHandler)
        present(popup, animated: true, completion: nil)
    }
    
    public func openUrl(url: String) {
        if let url = URL(string: url), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }*/
}
