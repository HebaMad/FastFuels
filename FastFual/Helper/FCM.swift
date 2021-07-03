import Foundation

import UIKit
import Firebase
import UserNotifications
import FirebaseMessaging


class FCM: NSObject,MessagingDelegate {

    let gcmMessageIDKey = "gcm.message_id"

    init(withApplication:UIApplication) {
        super.init()

        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self

            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })

        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            withApplication.registerUserNotificationSettings(settings)
        }
        UNUserNotificationCenter.current().delegate = self

        withApplication.registerForRemoteNotifications()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.tokenRefreshNotification),
                                               name: Notification.Name.MessagingRegistrationTokenRefreshed,
                                               object: nil)
        connectToFcm()

        // [END register_for_notifications]
    }


    func connectToFcm() {
        
        Messaging.messaging().token { token, error in
          if let error = error {
            print("Error fetching FCM registration token: \(error)")
          } else if let token = token {
            print("FCM registration token: \(token)")
            
            UserDefaults.standard.setValue(token, forKey: "fcmToken")
            UserDefaults.standard.synchronize()
//            Messaging.messaging().shouldEstablishDirectChannel = true
            Messaging.messaging().isAutoInitEnabled = true

           // self.fcmRegTokenMessage.text  = "Remote FCM registration token: \(token)"
          }
        }


//        InstanceID.instanceID().instanceID { (result, error) in
//            if let error = error {
//                print("Error fetching remote instange ID: \(error)")
//                Messaging.messaging().shouldEstablishDirectChannel = false
//
//            } else if let result = result {
//                print("Remote instance ID token: \(result.token)")
//                UserDefaults.standard.setValue(result.token, forKey: "fcmToken")
//                UserDefaults.standard.synchronize()
//                Messaging.messaging().shouldEstablishDirectChannel = true
//
//            }
//        }



        Messaging.messaging().subscribe(toTopic: "users") { error in
            print("Subscribed to promotional topic")
        }

    }

    @objc func tokenRefreshNotification(_ notification: Notification) {
//        InstanceID.instanceID().instanceID { (result, error) in
//            if let error = error {
//                print("Error fetching remote instange ID: \(error)")
//                Messaging.messaging().shouldEstablishDirectChannel = false
//                Messaging.messaging().autoInitEnabled = false
//
//
//            } else if let result = result {
//                print("InstanceID token: \(result.token)")
//                UserDefaults.standard.setValue(result.token, forKey: "fcmToken")
//                UserDefaults.standard.synchronize()
////                Messaging.messaging().shouldEstablishDirectChannel = true
//                Messaging.messaging().autoInitEnabled = true
//
//            }
//        }
//
        
        Messaging.messaging().token { token, error in
          if let error = error {
            print("Error fetching FCM registration token: \(error)")
            Messaging.messaging().isAutoInitEnabled = false
            
          } else if let token = token {
            print("FCM registration token: \(token)")
            
            UserDefaults.standard.setValue(token, forKey: "fcmToken")
            UserDefaults.standard.synchronize()
//            Messaging.messaging().shouldEstablishDirectChannel = true
            Messaging.messaging().isAutoInitEnabled = true

           // self.fcmRegTokenMessage.text  = "Remote FCM registration token: \(token)"
          }
        }


        // Connect to FCM since connection may have failed when attempted before having a token.
    }
    func disconnect(){
//        Messaging.messaging().shouldEstablishDirectChannel = false

        Messaging.messaging().isAutoInitEnabled = false

    }
    func recievedRemoteNotification(userInfo: [AnyHashable: Any]){


        // Print full message.
        print(userInfo)
    }

    func application(received remoteMessage: MessagingDelegate){

    }

    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        
        print("Firebase registration token: \(fcmToken)")

        let dataDict:[String: String] = ["token": "\(fcmToken)"]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)

        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
        connectToFcm()
    }


    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingDelegate) {
        print("Received data message: \(remoteMessage.description)")
//        print(remoteMessage.appData)
    }
    
    
}





// [START ios_10_message_handling]
@available(iOS 10, *)
extension FCM : UNUserNotificationCenterDelegate {

    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        // Print message ID.
        if let messageID = userInfo["gcm.message_id"] {
            print("Message ID: \(messageID)")
        }

        // Change this to your preferred presentation option
        completionHandler([.alert, .badge, .sound])
    }

    //When tap  on the notification
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo

        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }

      //  (getTopViewController() as!  TTabBarViewController).selectedIndex

        completionHandler()
    }
}


extension AppDelegate{

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
      //  Messaging.messaging().shouldEstablishDirectChannel = false
        Messaging.messaging().isAutoInitEnabled = false

        print("Disconnected from FCM.")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        AppDelegate.fcm.connectToFcm()
    }


    //    func applicationWillTerminate(_ application: UIApplication) {
    //
    //        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    //    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }

    // This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
    // If swizzling is disabled then this function must be implemented so that the APNs token can be paired to
    // the InstanceID token.
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // With swizzling disabled you must set the APNs token here.
        // FIRInstanceID.instanceID().setAPNSToken(deviceToken, type: FIRInstanceIDAPNSTokenType.sandbox)

        let apns = deviceToken.map{ String(format: "%02x", $0) }.joined()
        print("APNs token hex: \(apns)")
        print("FCM Token: \( String(describing: UserDefaults.standard.value(forKey: "fcmToken") as? String))")




        Messaging.messaging().setAPNSToken(deviceToken, type: MessagingAPNSTokenType.sandbox)
        Messaging.messaging().apnsToken = deviceToken

        Messaging.messaging().subscribe(toTopic: "users")
    }


    // [START receive_message] When tap  on the notification
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // Print message ID.
        // Print message ID.
//             if let messageID = userInfo[gcmMessageIDKey] {
//               print("Message ID: \(messageID)")
//             }

             // Print full message.
             print(userInfo)
           }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // Print message ID.
        
        
        // Print message ID.
//            if let messageID = userInfo[gcmMessageIDKey] {
//              print("Message ID: \(messageID)")
//            }

            // Print full message.
            print(userInfo)
        
        
        Messaging.messaging().appDidReceiveMessage(userInfo)
        
        
        completionHandler(UIBackgroundFetchResult.newData)
    }

   

    


    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {

    }

}
