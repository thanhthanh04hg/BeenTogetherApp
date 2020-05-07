//
//  AppDelegate.swift
//  BeenTogetherAppOffical
//
//  Created by Macbook on 4/24/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        let sb=UIStoryboard.init(name: "Main", bundle: nil)
//        let mainsb=UIStoryboard.init(name: "MainSb", bundle: nil)
//        var initialViewController : UIViewController
//        let isDateSet = UserDefaults.standard.bool(forKey: "isDateSet")
//        if(isDateSet){
//            initialViewController=mainsb.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
//        }
//        else{
//            initialViewController=sb.instantiateViewController(withIdentifier: "ViewController") as! ViewController
//        }
//
//
//        self.window?.rootViewController = initialViewController;
//        self.window?.makeKeyAndVisible();
        return true
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

