//
//  VCOTP.swift
//  FastFual
//
//  Created by Basim on 1/16/21.
//

import UIKit
import Alamofire
import ObjectMapper
import Firebase
import UserNotifications

class VCOTP: UIViewController ,UITextFieldDelegate{
    var timer: Timer?
    var totalTime = 90
    var mobileNumber = ""
    var auth:Int?
  var edit=false
    private var notes: ValidationData?
    var type:String=""
    var otp:(([String])->Void)?


    @IBOutlet weak var buBack: UIButton!
    { didSet {
        buBack.addTarget(self, action: #selector(self.buBackPressed), for: .touchUpInside)
    }        }
    @objc func buBackPressed() {
        print("buBackPressed")
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBOutlet weak var laEnterOTP: UILabel!
    @IBOutlet weak var laOTPNumber: UILabel!
    @IBOutlet weak var laResendCodeIn: UILabel!
    
    @IBOutlet weak var laTimer: UILabel!
    
    @IBOutlet weak var labyclicking : UILabel!
    @IBOutlet weak var laTermsandCondition : UILabel!
    
//    @IBOutlet weak var txtPhoneNumber: UITextField!
        
    @IBOutlet weak var buTermsandCondition: UIButton!
    { didSet {
        buTermsandCondition.addTarget(self, action: #selector(self.buTermsandConditionPressed), for: .touchUpInside)
    }        }
    @objc func buTermsandConditionPressed() {
        UIApplication.shared.open(URL(string:"http://fastfuel-sa.com/terms_and_conditions" ?? "")!)
    }
    @IBOutlet weak var buContinue: UIButton!
    { didSet {
        buContinue.addTarget(self, action: #selector(self.buContinuePressed), for: .touchUpInside)
    }        }
    @objc func buContinuePressed() {

    }
    
    @IBOutlet weak var txtOTP: UITextField!{
        didSet {
//            if  edit == false{

            txtOTP.addTarget(self, action: #selector(handleSubmit), for: .editingChanged)
//            }else{
//
//            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        txtOTP.becomeFirstResponder()
        txtOTP.delegate = self
        txtOTP.keyboardType = .asciiCapableNumberPad
        if #available(iOS 12.0, *) {
            txtOTP.textContentType = .oneTimeCode
        }
        
        
        startOtpTimer()
        
        self.laOTPNumber.text = self.mobileNumber
            }

    @objc func handleSubmit() {
        guard let code = txtOTP.text, code.count > 0 else { return }
        

        let attributedString = NSMutableAttributedString(string: code)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: CGFloat(75), range: NSRange(location: 0, length: attributedString.length))
        self.txtOTP.attributedText = attributedString
        
        
        if code.count == 4 {
            self.continueOTP(code: txtOTP.text!, mobileNumber: mobileNumber)
            self.view.endEditing(true)
        }
        
        
        
        
    }
 
    
    func startOtpTimer() {
        self.totalTime = 90
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        print(self.totalTime)
        self.laTimer.text = self.timeFormatted(self.totalTime) // will show timer
        if totalTime != 0 {
            totalTime -= 1  // decrease counter timer
        } else {
            if let timer = self.timer {
                timer.invalidate()
                self.timer = nil
            }
        }
    }
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    
}
extension VCOTP{
    
    private func checkData()->Bool{
        if !txtOTP.text!.isEmpty {
            return true
        }
        return false;
    }
    private func continueOTP(code:String,mobileNumber:String){
        
        
        let parameters: Parameters = [
            "mobile":mobileNumber,
            "code" : code
            ]

            
            Alamofire.request(API_KEYS.validation_code.url, method: .post, parameters:parameters,headers: ["Accept-Language": UserDefaults.standard.string(forKey: "language") ?? "en"]).validate().responseJSON { [self] (response) in
                if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
              print(str)
                    if let parsedMapperString : Validation = Mapper<Validation>().map(JSONString:str){
                        if parsedMapperString.success == true{
                       
                        Messaging.messaging().subscribe(toTopic: "user_\(parsedMapperString.data?.id)")
                        Messaging.messaging().subscribe(toTopic: "all_users")

                  print(parsedMapperString.data?.access_token)
                        
                
                        type=parsedMapperString.data?.type ?? ""
                        UserDefaults.standard.set(parsedMapperString.data?.access_token, forKey: "token")
                    
                        if type.elementsEqual("supervisor"){
                            UserDefaults.standard.set("yes", forKey: "typeISSupervisor")
                            Messaging.messaging().subscribe(toTopic: "supervisors")

                        } else {
                            Messaging.messaging().subscribe(toTopic: "all_driver")
                            UserDefaults.standard.set("no", forKey: "typeISSupervisor")
                            
                        }
                            if  edit == false{

                        let vc = VCRegister_Done()
                        vc.type = parsedMapperString.data?.type ?? ""
                            self.navigationController?.pushViewController(vc, animated: true)
                            }else{
                                showAlertPopUp(title: "Fast Fuel", message: "Authentication Sucess") {
                                    self.sheetViewController?.dismissTapped()
                                    self.otp?(["Value","true"])
                                } action2: {
                                    
                                }

                            }
                            
                        }else{
                            showAlertMessage(title: "Error", message: parsedMapperString.message ?? "")
                        }
                        
                    }}}
}
     
}


