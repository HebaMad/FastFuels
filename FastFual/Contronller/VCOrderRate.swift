//
//  VCOrderRate.swift
//  FastFual
//
//  Created by Basim on 5/8/21.
//

import UIKit
import Cosmos
import Alamofire
import ObjectMapper
class VCOrderRate: UIViewController {
    @IBOutlet var rateTitle: UILabel!
    
    var orderId:Int=0
    @IBOutlet weak var starRating: CosmosView!
    @IBOutlet var evaluation: UIView!
    var rate=0.0
    @IBOutlet var buBack: UIButton!{
        didSet {
            buBack.addTarget(self, action: #selector(self.buBackPressed), for: .touchUpInside)
           } }
           @objc func buBackPressed() {
            navigationController?.popViewController(animated: true)
    }

    
    @IBOutlet var buDone: UIButton!{
        didSet {
            buDone.addTarget(self, action: #selector(self.buDonePressed), for: .touchUpInside)
           } }
           @objc func buDonePressed() {
            if  checkDate(){
                rate(orderid: orderId, text: txtVComment.text, rate: rate)

            }else{
                
            }

    }
    override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           self.tabBarController?.tabBar.isHidden = false

       }

       override func viewWillAppear(_ animated: Bool) {
                   super.viewWillAppear(animated)
           self.tabBarController?.tabBar.isHidden = true

       }
    
    @IBOutlet var txtVComment: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controlBackItem(backItem: buBack)

        txtVComment.placeholder = "Add Comment"
        starRating.rating = 0

        starRating.didTouchCosmos = { rating in
            self.rate=rating
            print (rating)
//            self.starRating.settings.filledImage = UIImage(named: "starSelect")

        }



    }
    



}
extension VCOrderRate{
    func checkDate() -> Bool{
     if  !txtVComment.text!.isEmpty && rate != 0 {
        return true
     }else{
        if txtVComment.text!.isEmpty {
            showAlertMessage(title: "Error", message: "Enter your comment")
        }else if rate == 0{
            showAlertMessage(title: "Error", message: "rating the order please")
        }else{
            showAlertMessage(title: "Error", message: "Eror in order Id")

        }
        return false
     }
    }
    
    private func rate(orderid:Int,text:String,rate:Double){
        print(orderid)
        print(text)
        print(rate)
        let parameters: Parameters = [
            "order_id":orderid,
            "text":text,
            "rate":rate

        
        ]
        print(API_KEYS.postRate.url)

                 Alamofire.request(API_KEYS.postRate.url, method: .post, parameters:parameters,headers: ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token")!)","Accept-Language": UserDefaults.standard.string(forKey: "language") ?? "en"]).validate().responseJSON { [self] (response) in
                if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
     
                    if let parsedMapperString : login = Mapper<login>().map(JSONString:str){
                        if parsedMapperString.success == true{
                            navigationController?.popViewController(animated: true)
                        }else{
                            showAlertMessage(title: "Error", message: parsedMapperString.message ?? "")
                        }
                        }
                        
                    }
      
            }
  

    }
    func controlBackItem(backItem: UIButton){
       if L102Language.currentAppleLanguage().elementsEqual("ar"){
        if let _img = backItem.imageView{
            backItem.setImage(UIImage(cgImage: (_img.image?.cgImage!)!, scale:_img.image!.scale , orientation: UIImage.Orientation.upMirrored), for: .normal)
            
           }
       }
   }

    
}
