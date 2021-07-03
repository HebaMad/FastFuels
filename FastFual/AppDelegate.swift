//
//  AppDelegate.swift
//  FastFual
//
//  Created by Basim on 12/31/20.
//

import UIKit
import GoogleMaps
import IQKeyboardManagerSwift

import Firebase
import FirebaseMessaging
let googleApiKey = "AIzaSyCXGl4gcdSrR3HsJ3ad9_QDIv9a4hvgTsc"

@main
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate {
// test 
    static var fcm:FCM!
    var test :Bool = false
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        L102Localizer.DoTheMagic()
        UserDefaults.standard.setValue(test, forKey: "test")

        if UserDefaults.standard.bool(forKey: "test") == false {
      //      L102Language.setAppleLAnguageTo(lang: "en")
            UserDefaults.standard.setValue(true, forKey: "test")
          //  UserDefaults.standard.setValue("en", forKey: "language")

        }
        
        if UserDefaults.standard.string(forKey:"language") ?? "en"  == "en" {
         
            L102Language.setAppleLAnguageTo(lang: "en")

        }else{
            L102Language.setAppleLAnguageTo(lang: "ar")

        }
        
        
        
        IQKeyboardManager.shared.enable = true

        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:  #colorLiteral(red: 0.2980392157, green: 0.3529411765, blue: 0.3921568627, alpha: 1)], for: .normal)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:   #colorLiteral(red: 0, green: 0.5972704291, blue: 0.6789311767, alpha: 1)], for: .selected)
        UITabBar.appearance().barTintColor = UIColor.white // your color

        GMSServices.provideAPIKey(googleApiKey)

        UIFont.overrideInitialize()
        AppDelegate.fcm = FCM(withApplication: application)
        
        
        observerNetworkBasim ()

        return true
    }
    
    
    //
    
    func observerNetworkBasim () {
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do{
            try reachability?.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
        
    }

    
    let reachability = Reachability()
    
    
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi:
            DispatchQueue.main.async {
            
                print("Reachable via WiFi")
            }
            
        case .cellular:
            
            MyTools.tool.coonectInterntBasim()
       
            
            print("Reachable via Cellular")
        case .none:
            DispatchQueue.main.async {
                
                let sheetController = VCNoInternet()
                sheetController.modalPresentationStyle = .fullScreen

////
//                let  viewController =  VCNoInternet()
//
//
//                let sheetController = SheetViewController(controller: viewController , sizes: [SheetSize.fixed(475)])
//                sheetController.overlayColor = UIColor.black.withAlphaComponent(0.33)
//
//                sheetController.pullBarView.backgroundColor = .clear
//                sheetController.handleColor = UIColor.clear
//                sheetController.adjustForBottomSafeArea = true
//                sheetController.blurBottomSafeArea = false
//                sheetController.dismissOnBackgroundTap = false
//                sheetController.extendBackgroundBehindHandle = false
//                sheetController.topCornersRadius = 12.0
//                sheetController.makedissmWhencahngeBackGoud = false

                
                UIApplication.topViewController?.present(sheetController, animated: true, completion: {
                    
                })
                
                MyTools.tool.errorInterntBasim()
                //  self.currentTimesOfOpenApp = -1
                print("Network not reachable")
                
            }
        }
    }


//    // MARK: UISceneSession Lifecycle
//
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }


}

