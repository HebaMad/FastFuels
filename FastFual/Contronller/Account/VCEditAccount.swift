//
//  VCEditAccount.swift
//  FastFual
//
//  Created by Basim on 5/10/21.
//

import UIKit
import Alamofire
import ObjectMapper
import SDWebImage
import SVProgressHUD
class VCEditAccount: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    var username:String?
    var useraddress:String?
    var userImg:String?
    var Mobile:String?
    var email:String?
    
    @IBOutlet var buVerify: UIButton!
    { didSet {
        buBack.addTarget(self, action: #selector(self.buVerifyPressed), for: .touchUpInside)
    }        }

@objc func buVerifyPressed(){
    if numAuthenticate == false{
                   
       showAlertPopUp(title: "Error", message: "you should authonticate the number first") {
                     SVProgressHUD.show()
           self.showSheet()
                } action2: {

               }
     }
}
    
    
    
    @IBOutlet var laNumberStatus: UILabel!
    var photoImage:UIImage=UIImage()
    var numAuthenticate=false
    @IBOutlet var mapAddressView: UIView!{
        didSet {
            mapAddressView.addGestureRecognizer( UITapGestureRecognizer(target: self, action: #selector(self.mapAddressViewPreseed(_:))))
            mapAddressView.isUserInteractionEnabled = true
        }
    }
    @objc func mapAddressViewPreseed(_ sender: UITapGestureRecognizer) {
        let vc = VCMapKitMaker()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
   
    @IBOutlet weak var buBack: UIButton!
           { didSet {
               buBack.addTarget(self, action: #selector(self.buBackPressed), for: .touchUpInside)
           }        }
      
       @objc func buBackPressed() {
           self.navigationController?.popViewController(animated: true)
       }
    
    
    @IBOutlet weak var buSave: UIButton!
           { didSet {
            buSave.addTarget(self, action: #selector(self.buSavePressed), for: .touchUpInside)
           }        }
      
       @objc func buSavePressed() {
        print(Mobile)
        print(txtNumber.text ?? "")

                if checkData(){
                    
                    
update(lng: UserDefaults.standard.double(forKey: "longitude"), lat: UserDefaults.standard.double(forKey: "latitude"), address: txtCity.text ?? "", mobile: txtNumber.text ?? "", email: txtEmail.text ?? "", name: txtName.text ?? "", image: photoImage)
                 
                    if ((Mobile?.elementsEqual(txtNumber.text ?? "")) == true){
                    
                    }else{
                     if numAuthenticate == false{
                                    
                        showAlertPopUp(title: "Error", message: "you should authonticate the number first") {
                                      SVProgressHUD.show()
                            self.showSheet() 
                                 } action2: {
                 
                                }
                      }

                        
                    }
                    
                    
                    
                    
                    
                }
        

       }
    @IBOutlet weak var buAddPhoto: UIButton!
           { didSet {
            buAddPhoto.addTarget(self, action: #selector(self.buUploadPressed), for: .touchUpInside)
           }        }
      
    @objc func buUploadPressed() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        
        self.present(picker, animated: true, completion: nil)
    }
        

        
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            guard let image = info[.editedImage] as? UIImage else{
                return
            }
            photoImage=image
            uiimgePhoto.image = photoImage
            picker.dismiss(animated: true, completion: nil)
        }
        
    @IBOutlet weak var uiimgePhoto: UIImageView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtNumber: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtName.text = username ?? ""
        txtNumber.text = Mobile ?? ""
        txtEmail.text = email ?? ""
        uiimgePhoto.sd_setImage(with:URL(string: userImg ?? ""))
        txtCity.text = useraddress ?? ""
        controlBackItem(backItem: buBack)



    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           self.tabBarController?.tabBar.isHidden = false

       }

       override func viewWillAppear(_ animated: Bool) {
                   super.viewWillAppear(animated)
        txtCity.text =  UserDefaults.standard.string(forKey: "address") ?? "not found"

           self.tabBarController?.tabBar.isHidden = true

       }


    @IBAction func buBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)

    }
    

}
extension VCEditAccount{
    func checkData() -> Bool{
        if !txtName.text!.isEmpty  && !txtNumber.text!.isEmpty && !txtEmail.text!.isEmpty && !txtCity.text!.isEmpty{
          return true
        }else{
            if txtName.text!.isEmpty{
                showAlertMessage(title: "Fast Fuel", message: "Enter your Name")
            }else if txtNumber.text!.isEmpty{
                showAlertMessage(title: "Fast Fuel", message: "Enter your Number ")

            }else if txtEmail.text!.isEmpty{
                showAlertMessage(title: "Fast Fuel", message: "Enter your Email Account  ")

            }else if txtCity.text!.isEmpty{
                showAlertMessage(title: "Fast Fuel", message: "Select your location")

            }
            return false

        }

    }
    private func update(lng:Double,lat:Double,address:String,mobile:String,email:String,name:String,image:UIImage){
        let parameters: Parameters = ["lng":lng,
                                      "lat":lat,
                                      "address":address,
                                      "mobile":mobile,
                                      "email":email,
                                      "name":name,
                                      "image":image
        
        ]

  
            Alamofire.request(API_KEYS.postUpdateUserProfile.url, method: .post, parameters:parameters,headers: ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token")!)","Accept-Language": UserDefaults.standard.string(forKey: "language") ?? "en"]).validate().responseJSON { [self] (response) in
                if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
              print(str)
                    if let parsedMapperString : UpdateUserProfile = Mapper<UpdateUserProfile>().map(JSONString:str){
                        if parsedMapperString.success == true{
                            showAlertMessage(title: "Fast Fuel", message: parsedMapperString.message ?? "")
                        }else{
                            showAlertMessage(title: "Error", message: parsedMapperString.message ?? "")

                        }
                        }
                        
                    }
          
            }
  

    }
    
    func  showSheet(){
        let  vc =  VCOTP()
        SVProgressHUD.dismiss()
        vc.mobileNumber=txtNumber.text ?? ""
        vc.edit=true
        
        vc.otp = {
            value in
            if  value.first == "Value"
            {


                print ((value[0]))
                SVProgressHUD.dismiss()
                if value[1] == "true"{
                    DispatchQueue.main.async
                    {

                        self.numAuthenticate=true
                        self.buVerify.isHidden = true
                    }
                }else{
                    self.numAuthenticate=false
                    self.buVerify.isHidden = false
                }
            

            }

            print("Hi basem \(value)")

        }
        
        
        
        let sheetController = SheetViewController(controller: vc , sizes: [SheetSize.fixed(400)])
        sheetController.overlayColor = UIColor.black.withAlphaComponent(0.33)
        
        sheetController.pullBarView.backgroundColor = .clear
        sheetController.handleColor = UIColor.clear
        sheetController.adjustForBottomSafeArea = true
        sheetController.blurBottomSafeArea = false
        sheetController.dismissOnBackgroundTap = true
        sheetController.extendBackgroundBehindHandle = false
        sheetController.topCornersRadius = 12.0
        
        
        sheetController.willDismiss = { _ in
            print(1231423123213)
            
            
        }
        sheetController.didDismiss = { _ in
            
            print(976697)
            
            
            
        }
        self.present(sheetController, animated: false, completion: nil)

    }

    func controlBackItem(backItem: UIButton){
       if L102Language.currentAppleLanguage().elementsEqual("ar"){
        if let _img = backItem.imageView{
            backItem.setImage(UIImage(cgImage: (_img.image?.cgImage!)!, scale:_img.image!.scale , orientation: UIImage.Orientation.upMirrored), for: .normal)
            
           }
       }
   }
}
