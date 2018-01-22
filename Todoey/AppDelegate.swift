//
//  AppDelegate.swift
//  Todoey
//
//  Created by Ancy Thomas on 1/17/18.
//  Copyright © 2018 ThinkPalm. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        do {
            _ = try Realm()
        }catch {
            print ("Error init Realm \(error)")
        }
        return true
    }
  
    func applicationWillTerminate(_ application: UIApplication) {
        
    }
    
   


}

