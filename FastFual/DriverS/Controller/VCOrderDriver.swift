//
//  VCOrderDriver.swift
//  FastFual
//
//  Created by macbook on 5/23/21.
//

import UIKit
import Alamofire
import ObjectMapper
class VCOrderDriver: UIViewController {
    var sdata:[OrderDriveData]=[]
    var OrderStatus:Int?
    var PaymentStatus:Int?
    var Ordertype:Int?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func filter(_ sender: Any) {
        showFilter() 
        
    }
    

}
extension VCOrderDriver {
    func showFilter()  {

    let  viewController =  OrderFilter()
    
            viewController.popBlocks = {
                value in
                if  value.first == 200
                {
    
    
                    
//                    let index =  (value[1])
    
                    print ((value[0]))
                    print ((value[1]))
                    print ((value[2]))
                    print ((value[3]))
                    self.OrderStatus=value[1]
                    self.PaymentStatus=value[2]
                    self.Ordertype=value[3];
                    DispatchQueue.main.async{
                     
                        self.myOrder(status: self.OrderStatus ?? -1, paying: self.PaymentStatus ?? -1 , booking: self.Ordertype ?? -1 )

                    }
    
                }
    
    
            }
    //
    
    let sheetController = SheetViewController(controller: viewController , sizes: [SheetSize.fixed(630)])
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

extension VCOrderDriver{
    
    private func myOrder(status:Int,paying:Int,booking:Int){
        
        let parameters: Parameters = [
            "status" : status,
            "paying" : paying,
            "booking" : booking
        ]

            print(API_KEYS.postMyOrder.url)
                 Alamofire.request(API_KEYS.postOrders.url, method: .post, parameters:parameters,headers: ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token")!)","Accept-Language": UserDefaults.standard.string(forKey: "language") ?? "en"]).validate().responseJSON { [self] (response) in
                if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
              print(str)
                    print(data)

                    if let parsedMapperString : OrderDrive = Mapper<OrderDrive>().map(JSONString:str){
                        if parsedMapperString.success == true{
                       
                            sdata=parsedMapperString.data ?? []
                            let vc = VCDriverOrderF()
                            vc.sdata=sdata
                            navigationController?.pushViewController(vc, animated: true)
           
                        }else{
                            showAlertMessage(title: "Error", message: parsedMapperString.message ?? "")
                        }}}}
                        

    }
    
    
 
    
    
}

