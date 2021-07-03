
//
//  MainController.swift
//
//  Created by Momen Reyad Sisalem on 5/30/20.
//  Copyright © 2020 Momen Reyad Sisalem. All rights reserved.
//

import UIKit
import SystemConfiguration
import Foundation

class MainController {
    

    
//    public static func setTextFieldIcon(iconName: String, object: AnyObject){
//        var imageView = UIImageView()
//        let leftView = UIView()
//        leftView.frame = CGRect(x: 0, y: 0, width: 25, height: 15)
//
//        let emailIcon = UIImage(named: iconName);
//        let iconWidth = (emailIcon?.size.width)!;
//        let iconHeight = (emailIcon?.size.height)!;
//        if L102Language.currentAppleLanguage() == "en" {
//            imageView = UIImageView(frame: CGRect(x: 10, y: 0, width: iconWidth, height: iconHeight))
//            imageView.image = emailIcon;
//        }else{
//            imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: iconWidth, height: iconHeight))
//            imageView.image = emailIcon;
//        }
//
//        leftView.addSubview(imageView)
//
//        if let textField = object as? UITextField{
//            textField.leftViewMode = UITextField.ViewMode.always;
//            textField.leftView = leftView
//        } else if object is UILabel{
//
//        }
//    }
    
//    static func getDeviceLocale() -> String {
//        let currentLocale = NSLocale.current.languageCode!
//        print(currentLocale)
//        return currentLocale
//    }
//
//    public static func isValidEmail(emailAddress:String) -> Bool {
//        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
//
//        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
//        return emailTest.evaluate(with: emailAddress)
//    }
//
//    public static func isEmpty(text: String) -> Bool {
//        if text.isEmpty {
//            return true
//        }
//
//        if text == "" {
//            return true
//        }
//
//        if text.count == 0 {
//            return true
//        }
//
//        return false
//    }
//
    public static func isConnectedToInternet() -> Bool{
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }

//    public static func makeGradientNavBar(navBar: UINavigationBar, colors: [UIColor]){
//        let gradient = CAGradientLayer()
//        let sizeLength = UIScreen.main.bounds.size.height * 2
//        let defaultNavigationBarFrame = CGRect(x: 0, y: 0, width: sizeLength, height: 64)
//
//        gradient.frame = defaultNavigationBarFrame
//        gradient.colors = colors
//        navBar.setBackgroundImage(image(fromLayer: gradient), for: .default)
//    }
//
//    private static func image(fromLayer layer: CALayer) -> UIImage {
//        UIGraphicsBeginImageContext(layer.frame.size)
//        layer.render(in: UIGraphicsGetCurrentContext()!)
//        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return outputImage!
//    }
    
    public static func viewAlertDialog(vc:UIViewController, title: String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        vc.present(alert, animated: true, completion: nil)
    }
    

    

    
    public static func getString(key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
    
    public static func setCustomCorners(view: UIView, topLeftRadius: CGFloat, topRightRadius: CGFloat, bottomRightRadius:CGFloat, bottomLeftRadius: CGFloat) {
        print("MIN Y: \(view.layer.bounds.minY)")
        let minx = view.layer.bounds.minX
        let miny = view.layer.bounds.minY
        let maxx = view.layer.bounds.maxX
        let maxy = view.layer.bounds.maxY
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: minx + topLeftRadius, y: miny))
        
        path.addLine(to: CGPoint(x: maxx - topRightRadius, y: miny))
        path.addArc(withCenter: CGPoint(x: maxx - topRightRadius, y: miny + topRightRadius), radius: topRightRadius, startAngle:CGFloat(3 * (Double.pi/2)), endAngle: 0, clockwise: true)
        
        path.addLine(to: CGPoint(x: maxx, y: maxy - bottomRightRadius))
        path.addArc(withCenter: CGPoint(x: maxx - bottomRightRadius, y: maxy - bottomRightRadius), radius: bottomRightRadius, startAngle: 0, endAngle: CGFloat((Double.pi/2)), clockwise: true)
        
        path.addLine(to: CGPoint(x: minx + bottomLeftRadius, y: maxy))
        path.addArc(withCenter: CGPoint(x: minx + bottomLeftRadius, y: maxy - bottomLeftRadius), radius: bottomLeftRadius, startAngle: CGFloat((Double.pi/2)), endAngle: CGFloat((Double.pi)), clockwise: true)
        
        path.addLine(to: CGPoint(x: minx, y: miny + topLeftRadius))
        path.addArc(withCenter: CGPoint(x: minx + topLeftRadius, y: miny + topLeftRadius), radius: topLeftRadius, startAngle: CGFloat((Double.pi)), endAngle: CGFloat(3 * (Double.pi/2)), clockwise: true)
        path.close()
        
        let maskLayer = CAShapeLayer()
        
        maskLayer.path = path.cgPath
        view.layer.mask = maskLayer
    }
    
    public static func setNavBarTransparent(viewController: UIViewController){
        viewController.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        viewController.navigationController?.navigationBar.shadowImage = UIImage()
        viewController.navigationController?.navigationBar.isTranslucent = true
        viewController.navigationController?.view.backgroundColor = .clear
        viewController.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }
    
    public static func changeNavBarSettings(viewController: UIViewController, bgColor: UIColor, withoutShadow: Bool){
        viewController.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        if withoutShadow {
            viewController.navigationController?.navigationBar.shadowImage = UIImage()
        }
        
        viewController.navigationController?.view.backgroundColor = bgColor
    }
    
    public static func generateColors() -> [String: UIColor]{
        return ["start_color": UIColor(red:0.01, green:0.57, blue:1.00, alpha:1.0),
                "center_color": UIColor(red:0.20, green:0.73, blue:0.87, alpha:1.0),
                "end_color": UIColor(red:0.36, green:0.85, blue:0.76, alpha:1.0)]
    }
    
    public static func changeButtonImageWithAnimation(button: UIButton, imageName: String){
        UIView.animate(withDuration: 0.5, animations: {
            button.alpha = 0.0
        }, completion:{(finished) in
            button.setImage(UIImage(named: ""), for: .normal)
            UIView.animate(withDuration: 0.5,animations:{
                button.alpha = 1.0
            },completion:nil)
        })
    }
    
    public static func changeBarButtomImage(barButton: UIBarButtonItem, image: String)->UIButton{
        let button: UIButton = UIButton(type: UIButton.ButtonType.custom)
        //set image for button
        let newImage = UIImage(named: image)
        button.setImage(newImage, for: .normal)
        //set frame
        button.frame = CGRect(x: 0, y: 0, width: (newImage?.size.width)!, height: (newImage?.size.height)!)
        barButton.customView = button
        return button
    }
    
    public static func addLogoToHeader(viewController: UIViewController, isMain: Bool){
        let logo = UIImage(named: "ic_bar_logo")
        let imageView = UIImageView(image:logo)
        if isMain{
            viewController.tabBarController?.navigationItem.titleView = imageView
        }else{
            viewController.navigationItem.titleView = imageView
        }
    }

    
    public static func showWithCurrecny(price: Any) -> String{
        return "\(String(describing: price)) \(UserDefaults.standard.string(forKey: "currency")!)"
    }
    
    public static func getHtml(html:String) -> NSAttributedString{
        let htmlData = NSString(string: html).data(using: String.Encoding.unicode.rawValue)
        let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        let attributedString = try! NSAttributedString(data: htmlData!, options: options, documentAttributes: nil)
        return attributedString
    }
    

    
    public static func share(viewController:UIViewController, text: String, url: String){
        let url:URL = URL(string: url)!
        let shareAll = [text, url] as [Any]
        let activityViewController = UIActivityViewController(activityItems : shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = viewController.view
        
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop,
                                                         UIActivity.ActivityType.postToFacebook,
                                                         UIActivity.ActivityType.postToTwitter,
                                                         UIActivity.ActivityType.postToTencentWeibo,
                                                         UIActivity.ActivityType.mail]
        
        viewController.present(activityViewController, animated: true, completion: nil)
    }
    
    public static func popToRoot(view: UIViewController, rootViewController: String)  {
        let transition: UIView.AnimationOptions = .transitionFlipFromLeft
        let rootviewcontroller: UIWindow = ((UIApplication.shared.delegate?.window)!)!
        rootviewcontroller.rootViewController = view
            .storyboard?.instantiateViewController(withIdentifier: rootViewController)
        let mainwindow = (UIApplication.shared.delegate?.window!)!
        mainwindow.backgroundColor = UIColor(hue: 0.6477, saturation: 0.6314, brightness: 0.6077, alpha: 0.8)
        UIView.transition(with: mainwindow, duration: 0.55001, options: transition, animations: { () -> Void in
        }) { (finished) -> Void in
            
        }
    }
    

    
    public static func dialNumber(number : String) {
        if let url = URL(string: "tel://\(number)"),
            UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler:nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        } else {
            // add error message here
        }
    }
    
    public static func openWebsite(website: String){
        if let url = URL(string: website) {
            UIApplication.shared.open(url, options: [:])
        }
    }
}

