//
//  AppDelegate.swift
//  MarvelAppIOS
//
//  Created by Guilherme Silva on 05/08/21.
//

import UIKit
import IQKeyboardManagerSwift
import PopupDialog
import Kako

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.shared.enable = true
        
        customizeNavBarAppearence()
        setupPopUpAppearence()
        
        KakoManager.shared.setup(dataSource: KakoHandler())
        
        return true
    }
    
    func customizeNavBarAppearence()
    {
        let navigationAttrs = [
            NSAttributedString.Key.foregroundColor : UIColor.greyishBrown,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18.0)
        ]
        
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().titleTextAttributes = navigationAttrs
        UINavigationBar.appearance().tintColor = UIColor.primaryColor
        UINavigationBar.appearance().isTranslucent = false
    }
    
    private func setupPopUpAppearence() {
        
        // Customize dialog appearance
        let pv = PopupDialogDefaultView.appearance()
        pv.titleFont    = UIFont.boldSystemFont(ofSize: 15)
        pv.titleColor   = UIColor.black
        pv.messageFont  = UIFont.systemFont(ofSize: 14)
        pv.messageColor = UIColor.black
        
        // Customize the container view appearance
        let pcv = PopupDialogContainerView.appearance()
        pcv.backgroundColor = UIColor.white
        pcv.shadowEnabled   = false
        pcv.shadowColor     = UIColor.clear
        
        // Customize overlay appearance
        let ov = PopupDialogOverlayView.appearance()
        ov.blurEnabled     = false
        ov.opacity         = 0.3
        ov.color           = UIColor.black
        
        // Customize default button appearance
        let db = DefaultButton.appearance()
        db.titleFont      = UIFont.boldSystemFont(ofSize: 12)
        db.titleColor     = UIColor.black
        db.buttonColor    = UIColor.clear
        db.separatorColor = UIColor.lightGrey
        db.buttonHeight   = 50
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

