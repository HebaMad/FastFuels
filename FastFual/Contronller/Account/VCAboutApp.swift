//
//  VCAboutApp.swift
//  FastFual
//
//  Created by Basim on 5/10/21.
//

import UIKit
import MessageUI
class VCAboutApp: UIViewController {
    var descriptions:String?
    var email : String?
    var facebook :  String?
    var instagram :  String?
    var mobile : String?
    var name :  String?
    var twitter :  String?
    var whatsApp :  String?
    @IBOutlet weak var buBack: UIButton!
           { didSet {
               buBack.addTarget(self, action: #selector(self.buBackPressed), for: .touchUpInside)
           }        }
      
       @objc func buBackPressed() {
           self.navigationController?.popViewController(animated: true)
       }
    
    
    @IBOutlet weak var laDescrption: UILabel!
    @IBOutlet weak var buNumber: UIButton!
    @IBAction func buNumber1(_ sender: Any) {
        callMobile(mobileNum: mobile ?? "")
    }
    @IBOutlet weak var buEmail1: UIButton!
    
    @IBAction func buEmail(_ sender: Any) {
        contactUsEmail()
        
    }
    

    @IBAction func buFace(_ sender: Any) {
        var Username = ""
        Username =  self.facebook ?? ""

                 let appURL = URL(string: "fb://profile/\(Username)")!
                 let application = UIApplication.shared
                 
                 if application.canOpenURL(appURL) {
                     application.open(appURL)
                 } else {
                     // if Instagram app is not installed, open URL inside Safari
                     let webURL = URL(string: "https://facebook.com/\(Username)")!
                     application.open(webURL)
                 }
            }
    @IBAction func buInsta(_ sender: Any) {
        var Username = ""
     Username =  self.instagram ?? ""

              
                let appURL = URL(string: "instagram://user?username=\(Username)")!
                let application = UIApplication.shared
                
                if application.canOpenURL(appURL) {
                    application.open(appURL)
                } else {
                    // if Instagram app is not installed, open URL inside Safari
                    let webURL = URL(string: "https://instagram.com/\(Username)")!
                    application.open(webURL)
                }    }
    @IBAction func buTwitrer(_ sender: Any) {
        var twUrl:URL
             
     twUrl = URL(string: "twitter://user?screen_name=\(self.twitter ?? "")")!
                            
             
               let twUrlWeb = URL(string: "https://www.twitter.com/")!
               if UIApplication.shared.canOpenURL(twUrl){
                   UIApplication.shared.open(twUrl, options: [:],completionHandler: nil)
               }else{
                   UIApplication.shared.open(twUrlWeb, options: [:], completionHandler: nil)
               }
        
    }
    @IBAction func buWhatsApp(_ sender: Any) {
        openWhatsApp()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        laDescrption.text = descriptions ?? ""
        buNumber.setTitle(self.mobile, for: .normal)
        buEmail1.setTitle(self.email, for: .normal)
        controlBackItem(backItem: buBack)
    }


     override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            self.tabBarController?.tabBar.isHidden = false

        }

        override func viewWillAppear(_ animated: Bool) {
                    super.viewWillAppear(animated)
            self.tabBarController?.tabBar.isHidden = true

        }


    }
extension VCAboutApp {
    func contactUsEmail() {
        
        
        
        let email =  self.email ?? ""// "support@antadrak.com"
        let subject = "Need Help"
        
        let bodyText = " Hello I would like to talk Fast Fuel team"
        
        // https://developer.apple.com/documentation/messageui/mfmailcomposeviewcontroller
        if MFMailComposeViewController.canSendMail() {
            
            let mailComposerVC = MFMailComposeViewController()
            mailComposerVC.mailComposeDelegate = self as? MFMailComposeViewControllerDelegate
            
            mailComposerVC.setToRecipients([email])
            mailComposerVC.setSubject(subject)
            mailComposerVC.setMessageBody(bodyText, isHTML: false)
            
            self.present(mailComposerVC, animated: true, completion: nil)
            
        } else {
            print("Device not configured to send emails, trying with share ...")
            
            let coded = "mailto:\(email)?subject=\(subject)&body=\(bodyText)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            if let emailURL = URL(string: coded!) {
                if #available(iOS 10.0, *) {
                    if UIApplication.shared.canOpenURL(emailURL) {
                        UIApplication.shared.open(emailURL, options: [:], completionHandler: { (result) in
                            if !result {
                                print("Unable to send email.")
                            }
                        })
                    }
                }
                else {
                    UIApplication.shared.openURL(emailURL as URL)
                }
            }
        }
    }
    
     func openWhatsApp() {
            
            
        let phoneNumber = self.whatsApp
            
   let msg = "Hello I would like to talk Fast Fuel team"
           
             let stginggg = "https://wa.me/\(phoneNumber)?text=\(msg)"
            
            let urlwithPercentEscapes = stginggg.decodeUrl
            let newURl = urlwithPercentEscapes().encodeUrl
            let appURL = NSURL(string: newURl())!
            
            if UIApplication.shared.canOpenURL(appURL as URL) {
                
                
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(appURL as URL, options: [:], completionHandler: nil)
                }
                else {
                    UIApplication.shared.openURL(appURL as URL)
                }
            }
            else {
                // Whatsapp is not installed
                
              
            }
            
        }
    
    func callMobile(mobileNum:String){
 
        let number = Int(mobileNum)
            let url:NSURL = URL(string: "TEL://\(+966)\(number!)") as? NSURL ?? NSURL()

        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    
    }
    func controlBackItem(backItem: UIButton){
       if L102Language.currentAppleLanguage().elementsEqual("ar"){
        if let _img = backItem.imageView{
            backItem.setImage(UIImage(cgImage: (_img.image?.cgImage!)!, scale:_img.image!.scale , orientation: UIImage.Orientation.upMirrored), for: .normal)
            
           }
       }
   }

}
    



