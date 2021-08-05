//
//  NavigationManager.swift
//  MarvelAppIOS
//
//  Created by Guilherme Silva on 05/08/21.
//

import Foundation
import UIKit

class NavigationManager {
    
    private static var _shared: NavigationManager?
    public static var shared: NavigationManager {
        get {
            if _shared == nil {
                _shared = NavigationManager()
            }
            return _shared!
        }
    }
    
    /*func navigateToMain() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = mainStoryboard.instantiateViewController(withIdentifier: "MainTabBarViewController") as! MainTabBarViewController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = mainViewController
    }*/
}
