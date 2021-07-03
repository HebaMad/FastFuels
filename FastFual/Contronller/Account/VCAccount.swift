//
//  VCAccount.swift
//  FastFual
//
//  Created by Basim on 5/9/21.
//

import UIKit
import Alamofire
import ObjectMapper
import Firebase
import UserNotifications

class VCAccount: UIViewController {
    var language=""
    var sdata:SettingData?
    var userData:ProfileData?
    
    @IBOutlet var icon1: UIImageView!
    @IBOutlet var icon2: UIImageView!
    @IBOutlet var icon3: UIImageView!
    @IBOutlet var icon4: UIImageView!
    @IBOutlet var icon5: UIImageView!
    @IBOutlet var icon6: UIImageView!
    
    
    
    @IBOutlet var laLang: UILabel!
    @IBOutlet weak var uiimgeLanguge: UIImageView!
    @IBOutlet var unCountNum: UILabel!
    
    @IBOutlet var unCountView: UIView!
    @IBAction func buNotfication(_ sender: Any) {
        let vc = VCNotifications()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBOutlet weak var laAccountNumber: UILabel!
    
    @IBOutlet var viewEditAccount: UIView!  {
        didSet {
            viewEditAccount.addGestureRecognizer( UITapGestureRecognizer(target: self, action: #selector(self.viewEditAccountPreseed(_:))))
            viewEditAccount.isUserInteractionEnabled = true
        }
    }
    @objc func viewEditAccountPreseed(_ sender: UITapGestureRecognizer) {
        print("viewEditAccountPreseed")
        
        let vc = VCEditAccount()
        vc.username = userData?.name ?? ""
        vc.Mobile = userData?.mobile ?? ""
        vc.email = userData?.email ?? ""
        vc.useraddress = userData?.address?.address ?? ""
        vc.userImg = userData?.image ?? ""
        
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    @IBOutlet var saleCalculator: UIView!  {
        didSet {
            saleCalculator.addGestureRecognizer( UITapGestureRecognizer(target: self, action: #selector(self.viewWhshlistPreseed(_:))))
            saleCalculator.isUserInteractionEnabled = true
        }
    }
    @objc func viewWhshlistPreseed(_ sender: UITapGestureRecognizer) {
        print("viewWhshlistPreseed")
        let vc = VCTanks()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBOutlet var viewContactAdmin: UIView!  {
        didSet {
            viewContactAdmin.addGestureRecognizer( UITapGestureRecognizer(target: self, action: #selector(self.viewContactAdmintPreseed(_:))))
            viewContactAdmin.isUserInteractionEnabled = true
        }
    }
    @objc func viewContactAdmintPreseed(_ sender: UITapGestureRecognizer) {
        print("viewContactAdmintPreseed")
        callMobile(mobileNum: self.sdata?.mobile ?? "")
        
    }
    
    @IBOutlet var viewAppLangoyge: UIView!  {
        didSet {
            viewAppLangoyge.addGestureRecognizer( UITapGestureRecognizer(target: self, action: #selector(self.viewAppLangoygePreseed(_:))))
            viewAppLangoyge.isUserInteractionEnabled = true
        }
    }
    @objc func viewAppLangoygePreseed(_ sender: UITapGestureRecognizer) {
        print("viewAppLangoygePreseed")
        
        if UserDefaults.standard.string(forKey:"language") ?? "en"  == "en"{
            self.updateLanguage(newLang: "ar")
            UserDefaults.standard.setValue("ar", forKey: "language")
            updateLanguage(lang: "ar")
            laLang.text="التحويل للإنجليزية"
            
        }else{
            
            self.updateLanguage(newLang: "en")
            UserDefaults.standard.setValue("en", forKey: "language")
            updateLanguage(lang: "en")
            laLang.text="Change to Arabic"
            
        }
    }
    
    @IBOutlet var viewAboutApp: UIView!  {
        didSet {
            viewAboutApp.addGestureRecognizer( UITapGestureRecognizer(target: self, action: #selector(self.viewAboutAppPreseed(_:))))
            viewAboutApp.isUserInteractionEnabled = true
        }
    }
    @objc func viewAboutAppPreseed(_ sender: UITapGestureRecognizer) {
        print("viewAboutAppPreseed")
        let vc = VCAboutApp()
        vc.email = sdata?.email ?? ""
        vc.facebook = sdata?.facebook ?? ""
        vc.instagram = sdata?.instagram ?? ""
        vc.twitter = sdata?.twitter ?? ""
        vc.mobile = sdata?.mobile ?? ""
        vc.name = sdata?.name ?? ""
        vc.descriptions = sdata?.about ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBOutlet var viewPraicvyPolicey: UIView!  {
        didSet {
            viewPraicvyPolicey.addGestureRecognizer( UITapGestureRecognizer(target: self, action: #selector(self.viewPraicvyPoliceyPreseed(_:))))
            viewPraicvyPolicey.isUserInteractionEnabled = true
        }
    }
    @objc func viewPraicvyPoliceyPreseed(_ sender: UITapGestureRecognizer) {
        print("viewPraicvyPoliceyPreseed")
        let vc = VCPrivacyPolicy()
        vc.privacy = sdata?.privacy ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBOutlet var signOut: UIView!
    {
        didSet {
            signOut.addGestureRecognizer( UITapGestureRecognizer(target: self, action: #selector(self.viewSignOutPreseed(_:))))
            signOut.isUserInteractionEnabled = true
        }
    }
    @objc func viewSignOutPreseed(_ sender: UITapGestureRecognizer) {
        
        logout()
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        unCountView.isHidden=true
        
        setting()
        
        controlBackItem(backItem: icon1)
        controlBackItem(backItem: icon2)
        controlBackItem(backItem: icon3)
        controlBackItem(backItem: icon4)
        controlBackItem(backItem: icon5)
        controlBackItem(backItem: icon6)
        if UserDefaults.standard.string(forKey:"language") ?? "en"  == "en"{
            uiimgeLanguge.image = UIImage(named: "saFalsgs")
            
            
        }else{
            
        }
        
    }
    
    private func updateLanguage(newLang: String){
        if !L102Language.currentAppleLanguage().elementsEqual(newLang){
            //            let storyboard1 = UIStoryboard(name: "Main", bundle: nil)
            //
            //            let vc = storyboard1.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            //
            //            let navController = UINavigationController(rootViewController: vc)
            L102Language.changeLanguage(view: self, newLang: newLang, rootViewController: "Navigate")
        }
        
        
    }
}
extension VCAccount{
    
    func controlBackItem(backItem: UIImageView){
        if L102Language.currentAppleLanguage().elementsEqual("ar"){
            if let _img = backItem.image {
                backItem.image =  UIImage(cgImage: _img.cgImage!, scale:_img.scale , orientation: UIImage.Orientation.upMirrored)
            }
        }
    }
    private func logout(){
        
        
        Alamofire.request(API_KEYS.getLogout.url, method: .get, parameters:nil,headers: ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token")!)","Accept-Language": UserDefaults.standard.string(forKey: "Languge") ?? "en"]).validate().responseJSON { [self] (response) in
            if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
                print(str)
                if let parsedMapperString : login = Mapper<login>().map(JSONString:str){
                    if parsedMapperString.success == true{
                        Messaging.messaging().unsubscribe(fromTopic: "all_users")
                        
                        if  UserDefaults.standard.string(forKey: "typeISSupervisor") == "yes" {
                            Messaging.messaging().unsubscribe(fromTopic: "supervisors")
                            
                        }else{
                            Messaging.messaging().unsubscribe(fromTopic: "all_driver")
                            
                        }
                        let defaults = UserDefaults.standard
                        let dictionary = defaults.dictionaryRepresentation()
                        
                        dictionary.keys.forEach
                        { key in   defaults.removeObject(forKey: key)
                        }
                        let domain = Bundle.main.bundleIdentifier!
                        UserDefaults.standard.removePersistentDomain(forName: domain)
                        UserDefaults.standard.synchronize()
                        print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
                        
                        goToStart()
                        
                        
                    }else{
                        showAlertMessage(title: "Error", message: parsedMapperString.message ?? "")
                    }
                }
                
            }
            
        }
        
    }
    
    
    func goToStart(){
        guard let window = UIApplication.shared.keyWindow else {return}
        
        UIView.transition(with: window , duration: 0.5, options: .transitionFlipFromLeft, animations: {
            
            let storyboard1 = UIStoryboard(name: "Main", bundle: nil)
            
            let vc = storyboard1.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            
            
            
            let navController = UINavigationController(rootViewController: vc)
            guard let window = UIApplication.shared.keyWindow else {return}
            
            navController.navigationBar.isHidden = true
            window.rootViewController = navController
            
            
        }, completion: { completed in
            
        })
    }
    
    private func updateLanguage(lang:String){
        
        
        let parameters: Parameters = [
            "locale":lang
        ]
        
        Alamofire.request(API_KEYS.postChangeLanguage.url, method: .post, parameters:parameters,headers: ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token")!)","Accept-Language": UserDefaults.standard.string(forKey: "Langugee") ?? "en"]).validate().responseJSON { [self] (response) in
            if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
                print(str)
                if let parsedMapperString : login = Mapper<login>().map(JSONString:str){
                    if parsedMapperString.success == true{
                        showAlertMessage(title: "Fast Fuel", message: parsedMapperString.message ?? "")
                    }else{
                        showAlertMessage(title: "Error", message: parsedMapperString.message ?? "")
                    }
                }
                
            }
            
        }
        
        
    }
    private func setting(){
        
        
        Alamofire.request(API_KEYS.getSetting.url, method: .get, parameters:nil,headers: ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token")!)","Accept-Language": UserDefaults.standard.string(forKey: "language") ?? "en"]).validate().responseJSON { [self] (response) in
            if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
                print(str)
                if let parsedMapperString : Setting = Mapper<Setting>().map(JSONString:str){
                    if parsedMapperString.success == true{
                        sdata=parsedMapperString.data
                        //                            laAccountNumber.text=sdata?.mobile ?? ""
                        profile()
                    }else{
                        showAlertMessage(title: "Error", message: parsedMapperString.message ?? "")
                    }
                }
                
            }
            
        }
        
        
    }
    private func profile(){
        
        
        
        
        Alamofire.request(API_KEYS.getProfile.url, method: .get, parameters:nil,headers: ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token")!)","Accept-Language": UserDefaults.standard.string(forKey: "language") ?? "en"]).validate().responseJSON { [self] (response) in
            if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
                
                if let parsedMapperString : Profile = Mapper<Profile>().map(JSONString:str){
                    if parsedMapperString.success == true {
                        laAccountNumber.text=parsedMapperString.data?.mobile ?? ""
                        userData = parsedMapperString.data
                        if parsedMapperString.data?.un_reade_notification_count != 0{
                            unCountView.isHidden=false
                            unCountNum.text = "\(parsedMapperString.data?.un_reade_notification_count ?? 0)"
                            
                        }else{
                            unCountView.isHidden=true
                        }
                    }else{
                        showAlertMessage(title: "Error", message: parsedMapperString.message ?? "")
                    }
                }
                
            }}}
    func callMobile(mobileNum:String){
        
        let number = Int(mobileNum)
        let url:NSURL = URL(string: "TEL://\(+966)\(number!)") as? NSURL ?? NSURL()
        
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        
    }
    
}
