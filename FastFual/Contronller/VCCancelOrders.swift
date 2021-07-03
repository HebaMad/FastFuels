//
//  VCCancelOrders.swift
//  FastFual
//
//  Created by Basim on 4/10/21.
//

import UIKit
import Alamofire
import ObjectMapper
class VCCancelOrders: UIViewController {
var id = 0
    @IBOutlet var buConfirmCancelation: UIButton!{
        didSet {
            buConfirmCancelation.addTarget(self, action: #selector(self.buConfirmCancelationPressed), for: .touchUpInside)
           } }
           @objc func buConfirmCancelationPressed() {
            cancelled()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


}
extension VCCancelOrders{
    private func cancelled(){
        

        let  cancelledOrder = API_KEYS.getCancelOrder.withId(id:id )


                 Alamofire.request(cancelledOrder, method: .get, parameters:nil,headers: ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token")!)","Accept-Language": UserDefaults.standard.string(forKey: "language") ?? "en"]).validate().responseJSON { [self] (response) in
                if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
     
                    if let parsedMapperString : MyOrder = Mapper<MyOrder>().map(JSONString:str){
                        if parsedMapperString.success == true{
                            self.sheetViewController?.dismissTapped()

               
                        }else{
                            showAlertMessage(title: "Error", message: parsedMapperString.message ?? "")
                        }
                        }
                        
                    }
      
            }
  

    }
}
