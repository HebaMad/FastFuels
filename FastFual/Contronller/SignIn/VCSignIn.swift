//
//  VCSignIn.swift
//  FastFual
//
//  Created by Basim on 1/4/21.
//

import UIKit
import Alamofire
import ObjectMapper
class VCSignIn: UIViewController {
    
    @IBOutlet var cancelImg: UIImageView!
    @IBOutlet weak var laWelcomeBack: UILabel!
    @IBOutlet weak var laEnteryourphonenumber: UILabel!
    @IBOutlet weak var lawebelievethat: UILabel!
    @IBOutlet weak var la966: UILabel!
    @IBOutlet weak var labyclicking : UILabel!
    @IBOutlet weak var laTermsandCondition : UILabel!
    var edit=false
    @IBOutlet weak var txtPhoneNumber: UITextField!{
        didSet {
            txtPhoneNumber.addTarget(self, action: #selector(handleSubmit), for: .editingChanged)
        }
    }
        
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
        if checkData(){
            performLogin(number: txtPhoneNumber.text ?? "")

        }
     
    }
    
    
    @objc func handleSubmit() {
        guard let code = txtPhoneNumber.text, code.count > 0 else { return }
        

        if code.count == 9 {
            cancelImg.isHidden=false

            cancelImg.image=UIImage(named: "true")
            self.view.endEditing(true)
        }else{
            cancelImg.isHidden=false
            cancelImg.image=UIImage(named: "cancel-1")

        }
        
        
        
        
    }
 

    override func viewDidLoad() {
        super.viewDidLoad()
        cancelImg.isHidden=true
    }
    

    @IBAction func stationAction(_ sender: Any) {
        UIApplication.shared.open(URL(string:"http://fastfuel-sa.com/join_us_station" ?? "")!)
    }
    
    @IBAction func supplierAction(_ sender: Any) {
        UIApplication.shared.open(URL(string:"http://fastfuel-sa.com/join_us_supplier" ?? "")!)
    }
    


}

extension VCSignIn{
    
    private func checkData()->Bool{
        if txtPhoneNumber.text?.count == 9{
            return true
        }else{
            showAlertMessage(title: "Error", message: "your number should be 9 number")

        }
        return false;
    }
    
    private func performLogin(number:String){
        if checkData() {
            let parameters: Parameters = ["mobile":number]

      
                Alamofire.request(API_KEYS.login.url, method: .post, parameters:parameters).validate().responseJSON { [self] (response) in
                    if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
                  print(str)
                        if let parsedMapperString : login = Mapper<login>().map(JSONString:str){
                            if parsedMapperString.success == true{
                   
                      let vc = VCOTP()
                                
                        vc.mobileNumber=txtPhoneNumber.text!
                        self.navigationController?.pushViewController(vc, animated: true)
                    }else{
                        showAlertMessage(title: "Error", message: parsedMapperString.message ?? "")

                        
                    }
            }
        }
    }}
    }
}
extension String {

func isValidPhone(phone: String) -> Bool {

   let phoneRegex = "^[0-9]{6,14}$";
   let valid = NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: phone)
   return valid
}

}
