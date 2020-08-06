//
//  AppDelegate.swift
//  Task1(SignUp_SignIn_Profile)
//
//  Created by IDE Academy on 5/12/20.
//  Copyright © 2020 Mostafa Saleh. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //APIMangager.loadMovies()
        setUpDatabase()
       setRootView()
        IQKeyboardManager.shared.enable = true
        UITabBar.appearance().barTintColor = .black
         UITabBar.appearance().tintColor = .red
        
        return true
    }
    func setUpDatabase() {
       SQLiteManager.getSharedInstance().setUpConnection()
        let numberOfRecordsInUserTable = SQLiteManager.getSharedInstance().selectAllRecords()
        if numberOfRecordsInUserTable == 0 {
          SQLiteManager.getSharedInstance().creatTable()
        }
        
        let numberOfRecordsInSearchResultTable = SQLiteManager.getSharedInstance().selectLsatSearchHistoryRecords()
        let count = numberOfRecordsInSearchResultTable.1
        
        if count == 0 {
            SQLiteManager.getSharedInstance().creatLastResultTable()
        }
    }
    func setRootView() {
        if let isLoggedIn = UserDefaults.standard.object(forKey: UserDefaultsKeys.isLoggedIn) as? Bool {
             let storyBoard = UIStoryboard(name: Storyboard.mainStoryBoard, bundle: nil)
             let navigationController:UINavigationController
            if isLoggedIn {
                let MoviesVC = storyBoard.instantiateViewController(withIdentifier: VCs.mainTabBarVC) as! mainTabBarVC			
                navigationController = UINavigationController(rootViewController: MoviesVC)
            }
            else{
                  let signInVC = storyBoard.instantiateViewController(withIdentifier: VCs.signInVC) as! SignInVC
                  navigationController = UINavigationController(rootViewController: signInVC)
            }
             self.window?.rootViewController = navigationController
             self.window?.makeKeyAndVisible()
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

