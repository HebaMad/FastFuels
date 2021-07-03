

import UIKit
//import ARSLineProgress
import SystemConfiguration
import AVFoundation
import AVKit
//import SCLAlertView



class MyTools: NSObject {
    static var tool = MyTools()
    
    func coonectInterntBasim () ->Void {
        
        
//                if let topVC = getTopViewController() {
//                    
//                }
        
    }
    func errorInterntBasim () ->Void {
      
        //        if let topVC = getTopViewController() {
        //
        //
        //
        //        }
    }
    
    
    
//    func alert(message: String, title: String = "", btn_actions: [String]) {
//
//        let appearance = SCLAlertView.SCLAppearance(
//            kTitleFont: UIFont(name: "FrutigerLTArabic-55Roman", size: 20)!,
//            kTextFont: UIFont(name: "FrutigerLTArabic-55Roman", size: 14)!,
//            kButtonFont: UIFont(name: "FrutigerLTArabic-55Roman", size: 14)!,
//            showCloseButton: false,
//            dynamicAnimatorActive: false,
//            buttonsLayout: .horizontal
//        )
//
//
//        let alert = SCLAlertView(appearance: appearance)
//        for action in btn_actions {
//
//            _ = alert.addButton(action) {
//            }
//        }
//
//
//
//       // let icon = UIImage(named:"1")
//        var color = #colorLiteral(red: 0.1516066194, green: 0.1516112089, blue: 0.1516087353, alpha: 1)
//
//        if Bundle.appBundleIdentifier == "com.savvy" {
//                 color = #colorLiteral(red: 0.1516066194, green: 0.1516112089, blue: 0.1516087353, alpha: 1)
//                } else {
//                  color = #colorLiteral(red: 0.8117647059, green: 0.2941176471, blue: 0.5882352941, alpha: 1)
//
//                }
//
//        //_ = alert.showCustom(title, subTitle: message , color: color, icon: nil , circleIconImage: nil)
//         _ = alert.showInfo(title, subTitle: message)
//
//           }
    
    // MARK: - Color With Hex
    func getColorByHex(rgbHexValue:UInt32) -> UIColor {
        let red = Double((rgbHexValue & 0xFF0000) >> 16) / 256.0
        let green = Double((rgbHexValue & 0xFF00) >> 8) / 256.0
        let blue = Double((rgbHexValue & 0xFF)) / 256.0
        
        return UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(1))
    }
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    func leftView (textField:UITextField) -> Void {
        let leftView = UIView()
        leftView.frame = CGRect(x: 0, y: 0, width: 15, height: textField.frame.size.height)
        textField.leftView = leftView
        textField.leftViewMode = .always
    }
    
    func setViewStyle(view:UIView) -> Void {
        view.layer.borderWidth = 1
        view.backgroundColor = UIColor.white
    }
    
//    func showErrorAlert(sender:AnyObject ,msg:String)
//    {
//        let alertController = UIAlertController(title: "", message: msg, preferredStyle: UIAlertControllerStyle.alert)
//        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
//        }
//        alertController.addAction(okAction)
//        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)
//        {
//            // Ipad
//
//            alertController.popoverPresentationController?.sourceView = sender.view
//             alertController.popoverPresentationController?.sourceRect = CGRect.init(x: sender.view.bounds.midX, y: sender.view.bounds.midY, width: 0, height: 0)
//            alertController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
//        }
//        sender.present(alertController, animated: true, completion: nil)
//    }
//
//
//    func showSuccessAlert(sender:AnyObject ,msg:String)
//    {
//        let alertController = UIAlertController(title: "", message: msg, preferredStyle: UIAlertControllerStyle.alert)
//        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
//        }
//        alertController.addAction(okAction)
//        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)
//        {
//            // Ipad
//
//            alertController.popoverPresentationController?.sourceView = sender.view
//            alertController.popoverPresentationController?.sourceRect = CGRect.init(x: sender.view.bounds.midX, y: sender.view.bounds.midY, width: 0, height: 0)
//
//            alertController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
//        }
//        sender.present(alertController, animated: true, completion: nil)
//    }
//
    
    
//    var  activityIndicatorView =  NVActivityIndicatorView(frame: CGRect.init(x: 150 , y:200 , width: 100, height: 100),type:NVActivityIndicatorType.ballSpinFadeLoader )
//
//    func showIndicator2()->Void{
//
//
//                  activityIndicatorView.stopAnimating()
//
//               if let topVC = getTopViewController() {
//
//                self.activityIndicatorView =  NVActivityIndicatorView(frame: CGRect.init(x: (topVC.view.bounds.width / 2.0) - 50.0 , y:(topVC.view.layer.frame.midY) - 150.0 , width: 100, height: 100),type:NVActivityIndicatorType.ballSpinFadeLoader )
//                self.activityIndicatorView.color =  #colorLiteral(red: 0.9215686275, green: 0.2235294118, blue: 0.2588235294, alpha: 1)
//
//
//                   topVC.view.addSubview(activityIndicatorView)
//
//
//                   activityIndicatorView.startAnimating()
//
//               topVC.view.isUserInteractionEnabled = false
//               }
//
//
//           }
//
//
//
//    func hideIndicator2()->Void{
//
//
//        if  activityIndicatorView.isAnimating {
//            activityIndicatorView.stopAnimating()
//        }
//        activityIndicatorView.stopAnimating()
//
//        if let topVC = getTopViewController() {
//
//        topVC.view.isUserInteractionEnabled = true
//        }
//
//    }

//       func showIndicator1()->Void{
//
//               activityIndicatorView.stopAnimating()
//
//            if let topVC = getTopViewController() {
//
//
//                activityIndicatorView.color =  #colorLiteral(red: 0.8117647059, green: 0.2941176471, blue: 0.5882352941, alpha: 1)
//
//
//                topVC.view.addSubview(activityIndicatorView)
//
//
//                activityIndicatorView.startAnimating()
//            }
//
//
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            appDelegate.window?.rootViewController?.view.isUserInteractionEnabled = true //false
//        }
//
//
//        func hideIndicator1()->Void{
//
//
//            if  activityIndicatorView.isAnimating {
//                 activityIndicatorView.stopAnimating()
//            }
//              activityIndicatorView.stopAnimating()
//
//
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            appDelegate.window?.rootViewController?.view.isUserInteractionEnabled = true
//        }
//
//    func showIndicator()->Void{
////        ARSLineProgress.show();
////        let appDelegate = UIApplication.shared.delegate as! AppDelegate
////appDelegate.window?.rootViewController?.view.isUserInteractionEnabled = false
//    }
//
//    func hideIndicator()->Void{
////        ARSLineProgress.hide();
////        let appDelegate = UIApplication.shared.delegate as! AppDelegate
////        appDelegate.window?.rootViewController?.view.isUserInteractionEnabled = true
//    }
//
//
//    func validateEmail(candidate: String) -> Bool {
//        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
//        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
//    }
//
//
//    func connectedToNetwork() -> Bool {
//
//        var zeroAddress = sockaddr_in()
//        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
//        zeroAddress.sin_family = sa_family_t(AF_INET)
//
//        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
//            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
//                SCNetworkReachabilityCreateWithAddress(nil, $0)
//            }
//        }) else {
//            return false
//        }
//
//        var flags: SCNetworkReachabilityFlags = []
//        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
//            return false
//        }
//
//        let isReachable = flags.contains(.reachable)
//        let needsConnection = flags.contains(.connectionRequired)
//
//        return (isReachable && !needsConnection)
//    }
//
//    func alertWithOkButton(VC: UIViewController ,Title: String , Message: String)->Void
//    {
//        let alertController = UIAlertController(title: Title, message: Message, preferredStyle: UIAlertControllerStyle.alert)
//        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
//        }
//        alertController.addAction(okAction)
//        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)
//        {
//            // Ipad
//
//            alertController.popoverPresentationController?.sourceView = VC.view
//            alertController.popoverPresentationController?.sourceRect = CGRect.init(x: VC.view.bounds.midX, y: VC.view.bounds.midY, width: 0, height: 0)
//            alertController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
//        }
//        VC.present(alertController, animated: true, completion: nil)
//    }
//
    func hideBackWord(navItem : UINavigationItem) -> Void {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navItem.backBarButtonItem = backItem
        
    }
    
    func getCurrentDate() -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.timeZone = NSTimeZone(name: "UTC")! as TimeZone
        formatter.locale = NSLocale(localeIdentifier: "en") as Locale?
        let today = formatter.string(from: Date())
        return today
    }
    
    func convertDateToString(_ date: Date) -> String {
        let formater = DateFormatter()
        formater.locale = NSLocale(localeIdentifier: "en") as Locale?
        formater.dateFormat = "d' 'MMMM' 'yyyy'"
        return formater.string(from: date)
    }
    
    
    func getMyId(key:String) -> String {
        let ns = UserDefaults.standard
        var idd : String = ""
        if  let dict = ns.value(forKey: "CurrentUser"){
            let id = (dict as! NSDictionary).value(forKey: key) as! String
            idd = String(describing: id)
        }
        return idd
    }
   
    
    //    func getMyIdClocation(key:String) -> Double {
    //
    //        let ns = UserDefaults.standard
    //        let dict = ns.value(forKey: "CurrentUserLocation") as! NSDictionary
    //
    //
    //        let id = dict.value(forKey: key) as! Double
    //        let idd = Double(id)
    //        return idd
    //    }
    
    func filterStringNull(txt: Any) -> String {
        let str = "\(txt)"
        if (str.isEmpty) {
            return ""
        }
        if str.isEqual(nil)  {
            return ""
        }
        if (str == "(null)") {
            return ""
        }
        if (str == "(NULL)") {
            return ""
        }
        if (str == "null") {
            return ""
        }
        if str.isEqual(NSNull()) {
            return ""
        }
        //        if (str.lowercased() as String).rangeOf("null", options: .regularExpression).location != NSNotFound {
        //            return ""
        //        }
        return str.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func randomString(length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    
    //    func PostCategorybyChannelWith(fk_channel_id:String , Categries:String,completion:((DataResponse<Any>,Error?)->Void)!)
    //    {
    //        Alamofire.request(String(format:"your url"), method: .post,encoding: JSONEncoding.default).responseJSON { response in
    //            if(response.result.isSuccess)
    //            {
    //                completion(response,nil)
    //            }
    //            else
    //            {
    //                completion(response,response.result.error)
    //            }
    //        }
    //    }
    
    
    
    func updateProfileValue(key:String,value:String){
        let ns = UserDefaults.standard
        let dict = (ns.value(forKey: "CurrentUser") as! NSMutableDictionary).mutableCopy()
        let newValue = dict as! NSMutableDictionary
        newValue.setValue(value, forKey: key)
        ns.setValue(newValue, forKeyPath: "CurrentUser")
        ns.synchronize()
    }
    
//    func getUserIdAndApiToken()-> String;String{
//
//        let api_tokenGetting = UserDefaults.standard.string(forKey: "api_token")!
//        let userIdGetting =  UserDefaults.standard.string(forKey: "userId")!
//
//    }
//
    func getUserId(key:String) -> String {
        let ns = UserDefaults.standard
        var idd : String = ""
        if  let dict = ns.value(forKey: "userId"){
            let id = (dict as! NSDictionary).value(forKey: key) as! String
            idd = String(describing: id)
        }
        return idd
    }
}
//extension UIView {
//    func addConstraintsWithFormat(_ format: String, views: UIView...) {
//        var viewsDictionary = [String: UIView]()
//        for (index, view) in views.enumerated() {
//            let key = "v\(index)"
//            view.translatesAutoresizingMaskIntoConstraints = false
//            viewsDictionary[key] = view
//        }
//        
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
//    }
//}


//extension UIViewController {
    
//
//    func checkForInternetConnection() {
//
//
//    }
//
//    func alert(message: String, title: String = "", btn_actions: [String]) {
//
//        let appearance = SCLAlertView.SCLAppearance(
//
//            kTitleFont: UIFont(name: "FrutigerLTArabic-55Roman", size: 20)!,
//            kTextFont: UIFont(name: "FrutigerLTArabic-55Roman", size: 14)!,
//            kButtonFont: UIFont(name: "FrutigerLTArabic-55Roman", size: 14)!,
//            showCloseButton: false,
//            showCircularIcon: false ,
//            dynamicAnimatorActive: false,
//            buttonsLayout: .horizontal
//
//        )
//
//
//        let alert = SCLAlertView(appearance: appearance)
//        for action in btn_actions {
//            _ = alert.addButton(action) {
//            }
//        }
//
//        let icon = UIImage(named:"111")
//       var color = #colorLiteral(red: 0.1516066194, green: 0.1516112089, blue: 0.1516087353, alpha: 1)
//              if Bundle.appBundleIdentifier == "com.savvy" {
//                       color = #colorLiteral(red: 0.1516066194, green: 0.1516112089, blue: 0.1516087353, alpha: 1)
//                      } else {
//                        color = #colorLiteral(red: 0.8117647059, green: 0.2941176471, blue: 0.5882352941, alpha: 1)
//
//                      }
//
//
//
//    _ = alert.showCustom(title, subTitle: message , color: color, icon: icon!, circleIconImage: icon!)
//    //    _ = alert.showInfo(title, subTitle: message )
//    //  _ = alert.showTitle(title, subTitle: message, style:.info)
//}
//
//}



extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}

extension String {
    var html2AttributedString: NSAttributedString? {
        return Data(utf8).html2AttributedString
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}

extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}


extension UIApplication {
    
    class var topViewController: UIViewController? {
        return getTopViewController()
    }
    
    private class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return getTopViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}

extension Equatable {
    func share() {
        let activity = UIActivityViewController(activityItems: [self], applicationActivities: nil)
        UIApplication.topViewController?.present(activity, animated: true, completion: nil)
        
    }
}

extension UIView {
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

public extension UIWindow {
    var visibleViewController: UIViewController? {
        return UIWindow.getVisibleViewControllerFrom(vc: self.rootViewController)
    }
    
    static func getVisibleViewControllerFrom(vc: UIViewController?) -> UIViewController? {
        if let nc = vc as? UINavigationController {
            return UIWindow.getVisibleViewControllerFrom(vc: nc.visibleViewController)
        } else if let tc = vc as? UITabBarController {
            return UIWindow.getVisibleViewControllerFrom(vc: tc.selectedViewController)
        } else {
            if let pvc = vc?.presentedViewController {
                return UIWindow.getVisibleViewControllerFrom(vc: pvc)
            } else {
                return vc
            }
        }
    }
}

func getTopViewController() -> UIViewController? {
    
    // iOS13 or later
    if #available(iOS 13.0, *) {
        let sceneDelegate = UIApplication.shared.connectedScenes
            .first!.delegate as! SceneDelegate
       
     return   sceneDelegate.window!.rootViewController

    // iOS12 or earlier
    } else {
        // UIApplication.shared.keyWindow?.rootViewController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
      return  appDelegate.window!.rootViewController //= /* ViewController Instance */
        
    }
    
    
//
//    let appDelegate = UIApplication.shared.delegate
//    if let window = appDelegate!.window {
//        return window?.visibleViewController
//    }
//    return nil
}
