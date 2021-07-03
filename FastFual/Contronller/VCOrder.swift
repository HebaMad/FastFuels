//
//  VCOrder.swift
//  FastFual
//
//  Created by macbook on 5/23/21.
//

import UIKit
import Alamofire
import ObjectMapper
class VCOrder: UIViewController {
    
    var OrderStatus:String?
    var PaymentStatus:String?
    var Ordertype:String?
    
    var sdata:[MyOrderData]=[]

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func filter(_ sender: Any) {
        showFilter()
        
    }
    func showFilter()  {
        let  viewController =  VCOrderFilter()
        
                viewController.popBlocks = {
                    value in
                    if  value.first == "goToFilterList"
                    {
        
        
                        
                        let index =  (value[1])
        
                        print ((value[0]))
                        print ((value[1]))
                        print ((value[2]))
                        print ((value[3]))
                        
                        DispatchQueue.main.async
                        {
                            self.OrderStatus = value[1]
                            self.PaymentStatus = value[2]
                            self.Ordertype = value[3]

                            print (self.OrderStatus)
                            print (self.PaymentStatus)
                            print (self.Ordertype)
                            
                            self.myOrder(status: self.OrderStatus ?? "-1" , paying: self.PaymentStatus ?? "-1" , booking: self.Ordertype ?? "-1")

                            
                        }
        
                    }
        
        
                }
        //
        
        let sheetController = SheetViewController(controller: viewController , sizes: [SheetSize.fixed(760)])
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

}
extension VCOrder{
    
    private func myOrder(status:String,paying:String,booking:String){
        
        let parameters: Parameters = [
            "status" : status,
            "paying" : paying,
            "booking" : booking
        ]

            print(API_KEYS.postMyOrder.url)
                 Alamofire.request(API_KEYS.postMyOrder.url, method: .post, parameters:parameters,headers: ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token")!)","Accept-Language": UserDefaults.standard.string(forKey: "language") ?? "en"]).validate().responseJSON { [self] (response) in
                if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
              print(str)
                    print(data)

                    if let parsedMapperString : MyOrder = Mapper<MyOrder>().map(JSONString:str){
                        if parsedMapperString.success == true{
                       
                            sdata=parsedMapperString.data ?? []
                            let vc = VCFResult()
                            vc.sdata=sdata
                            navigationController?.pushViewController(vc, animated: true)
           
                        }else{
                            showAlertMessage(title: "Error", message: parsedMapperString.message ?? "")
                        }}}}
                        

    }
    
    
 
    
    
}
