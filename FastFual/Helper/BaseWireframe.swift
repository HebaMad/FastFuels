////
////  BaseWireframe.swift
////  Tahadi
////
////  Created by iOS Developer on 7/27/19.
////  Copyright © 2019 iOS Developer. All rights reserved.
////
//
//import Foundation
////import JGProgressHUD
////import SwiftEntryKit
////
////protocol WireframeInterface: class {
////    func popFromNavigationController(animated: Bool)
////    func dismiss(animated: Bool)
////
////    func showErrorAlert(with message: String?)
////    func showAlert(with title: String?, message: String?)
////    func showAlert(with title: String?, message: String?, actions: [UIAlertAction])
////}
////class BaseWireframe: UIViewController {
////
////  //  var emptyView:EmptyView?
////
////
////    override func viewDidLoad() {
////        super.viewDidLoad()
////
////    }
////
////
////}
//
//
//extension UIViewController {
//    
//    func showMessage(message:String,type:EKAttributes.NotificationHapticFeedback = .success){
//
//        self.setupMessageView(type: type, title: "", body: message)
//    }
//    func showError(error:Error){
//        var message:String = error.localizedDescription
//        if let error = error as? BaseError {
//            message = error.localizedDescription
////            if error.localizedDescription == BaseError.authLogin.localizedDescription {
////                self.navigationController?.popViewController(animated: true, nil)
////            }
//        }
//        //
////        let hud = flashHud(message: message, view: self.view, indicator: JGProgressHUDErrorIndicatorView())
////        hud.dismiss(afterDelay: 2)
//        DispatchQueue.main.async {
//            self.setupMessageView(type: .error, title: "خطآ".localized, body: message)
//        }
//    }
//    
//    func setupMessageView(type:EKAttributes.NotificationHapticFeedback ,title:String,body:String,imageName:String? = ""){
//        
//        var attributes: EKAttributes
//        
//        // Preset I
//        attributes = .topToast
//        attributes.hapticFeedbackType = type
//        attributes.entranceAnimation = .init(translate: .init(duration: 0.3), scale: .init(from: 1.07, to: 1, duration: 0.3))
//        attributes.exitAnimation = .init(translate: .init(duration: 0.3))
//        attributes.statusBar = .hidden
//        attributes.scroll = .edgeCrossingDisabled(swipeable: false)
//        attributes.entryBackground = .color(color: EKColor(light: #colorLiteral(red: 0.5713273883, green: 0.5229924321, blue: 0.7786477208, alpha: 1), dark: .yellow))
//        
//        let title1 = EKProperty.LabelContent(text: title,  style: .init(font:UIFont.systemFont(ofSize: 14) , color: EKColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))))
//        
//        let description = EKProperty.LabelContent(text: body, style: .init(font:UIFont.systemFont(ofSize: 14), color: EKColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))))
//        var image: EKProperty.ImageContent?
//        if let imageName = imageName {
//       //  image = .init(image: UIImage(named: imageName)!, size: CGSize(width: 35, height: 35))
//        }
//        
//        let simpleMessage = EKSimpleMessage(image: image, title: title1, description: description)
//        let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage)
//        
//        let contentView = EKNotificationMessageView(with: notificationMessage)
//        contentView.semanticContentAttribute = .forceRightToLeft
//        let messageView = MessageView()
//        messageView.firstLabel.text = title
//        messageView.secondLael.text = body
//        SwiftEntryKit.display(entry:messageView, using: attributes)
//        
//        /*   let error = MessageView.viewFromNib(layout: .messageView)
//         error.configureTheme(theme ?? .success)
//         error.configureContent(title: title, body: body)
//         error.button?.setTitle("Stop", for: .normal)
//         //        error.buttonTapHandler = {
//         //            _  in
//         //        }
//         //
//         error.tapHandler = {
//         error in
//         SwiftMessages.hide()
//         
//         }
//         
//         error.button?.isHidden = true
//         SwiftMessages.show(view: error)*/
//        
//    }
//    
////
////    private struct HUDHolder {
////        static var shared: JGProgressHUD = {
////            let hud = JGProgressHUD(style: .dark)
////            hud.shadow = JGProgressHUDShadow(color: .black, offset: .zero, radius: 5.0, opacity: 0.2)
////            hud.vibrancyEnabled = true
////            return hud
////
////        }()
////    }
////
////    var HUD:JGProgressHUD {
////        get {
////            return HUDHolder.shared
////        }
////    }
//   
//    func popFromNavigationController(animated: Bool) {
//        let _ = navigationController?.popViewController(animated: animated)
//    }
//    
//    func dismiss(animated: Bool) {
//        navigationController?.dismiss(animated: animated)
//    }
//    
//    func showErrorAlert(with message: String?) {
//        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//        showAlert(with: "", message: message, actions: [okAction])
//    }
//    
//    func showAlert(with title: String?, message: String?) {
//        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//        showAlert(with: title, message: message, actions: [okAction])
//    }
//    
//    func showAlert(with title: String?, message: String?, actions: [UIAlertAction]) {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        actions.forEach { alert.addAction($0) }
//        navigationController?.present(alert, animated: true, completion: nil)
//    }
//    
//    func showLoading(){
//        HUD.show(in: self.view)
//    }
//    
//    func hideLoading(){
//        DispatchQueue.main.async {
//            
//            self.HUD.dismiss()
//            self.HUD.dismiss()
//        }
//    }
//    
//    func displayHUD(with title: String?){
//        HUD.textLabel.text = title
//        HUD.indicatorView = nil
//        HUD.show(in: self.view)
//        HUD.dismiss(afterDelay: 2.0)
//    }
//    
//    
//}
//
//
//
//enum BaseLoading {
//    case show
//    case hide
//    case withText(text: String)
//}
//func flashHud(message:String,view:UIView,indicator:JGProgressHUDIndicatorView) -> JGProgressHUD {
//    let hud = JGProgressHUD(style: .dark)
//    hud.textLabel.text = message
//    hud.indicatorView = nil
//    hud.shadow = JGProgressHUDShadow(color: .black, offset: .zero, radius: 5.0, opacity: 0.2)
//    hud.vibrancyEnabled = true
//    hud.show(in: view)
//    hud.dismiss(afterDelay: 2.0)
//    return hud
//}
//
//func loadingHud(view:UIView) -> JGProgressHUD {
//    let hud = JGProgressHUD(style: .dark)
//    hud.show(in: view)
//    hud.shadow = JGProgressHUDShadow(color: .black, offset: .zero, radius: 5.0, opacity: 0.2)
//    hud.vibrancyEnabled = true
//    return hud
//}
