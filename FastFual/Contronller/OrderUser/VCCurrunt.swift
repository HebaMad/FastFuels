//
//  VCCurrunt.swift
//  Antadrak
//
//  Created by Basim on 7/29/20.
//  Copyright © 2020 Basim. All rights reserved.
//

import UIKit
import KOLocalizedString
import XLPagerTabStrip
import Alamofire
import ObjectMapper
import SVProgressHUD
class VCCurrunt: UIViewController ,IndicatorInfoProvider  {
    var sdata:[MyOrderData]=[]
    var itemInfo: IndicatorInfo = "Currunt"
    

    @IBAction func buOrderNow(_ sender: Any) {
        goToHomeSupervisor()
        
    }
    
    var test=""
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    var id :Int=0
    
    @IBOutlet var displayTable: UITableView!

    @IBOutlet var emptyView: UIView!
    
        override func viewDidLoad() {
            super.viewDidLoad()
            emptyView.isHidden=true
            SVProgressHUD.show()
            registerNib()
            myOrder()
        
            
        }
    @objc func bu1Preesed(_ sender : UIButton ) {
//        let vc=VCBankTransfer()

        if #available(iOS 13.0, *) {
            let storyboard1 = UIStoryboard(name: "Main", bundle: nil)

            let vc = storyboard1.instantiateViewController(identifier: "VCBankTransfer") as! VCBankTransfer
            vc.orderId=sdata[sender.tag].id ?? 0
            vc.total=sdata[sender.tag].total ?? 0.0
            vc.orderNum=sdata[sender.tag].order_number ?? 0

            navigationController?.pushViewController(vc, animated: false)
        } else {
        }
   
 


    }
    @objc func bu2Preesed(_ sender : UIButton ) {
        
        
        if  test=="Track"{
            let vc = VCOrdersDetailsTrack()
            vc.id = sdata[sender.tag].id ?? 0
            navigationController?.pushViewController(vc, animated: true)
        }else{
            
       


            
let vc=VCCancelOrders()
        vc.id=sdata[sender.tag].id ?? 0

        let sheetController = SheetViewController(controller: vc , sizes: [SheetSize.fixed(470)])
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
    func registerNib(){
        
        let nib = UINib(nibName: "CVCOrdersCurrent", bundle: nil)
        displayTable.register(nib, forCellReuseIdentifier: "CVCOrdersCurrent")
        
    }
        


}
extension VCCurrunt : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(sdata.count)
        return sdata.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
                                                    "CVCOrdersCurrent", for: indexPath) as! CVCOrdersCurrent
        cell.bu1.setTitle(NSLocalizedString("Pay Now", comment: ""), for: .normal)
        cell.bu2.setTitle(NSLocalizedString("Canceled", comment: ""), for: .normal)
        cell.bu2.setTitleColor(UIColor(named: "Color2"), for: .normal)
        cell.name.text=sdata[indexPath.row].supplier?.company_name ?? ""
        cell.orderNum.text = "OR#" + "\(sdata[indexPath.row].order_number ?? 0)"
        cell.orderTime.text=sdata[indexPath.row].diff ?? ""
        cell.status.setTitle(sdata[indexPath.row].status, for: .normal)
        cell.totalPrice.text="\(sdata[indexPath.row].total ?? 0.0)" +  NSLocalizedString("SR", comment: "")
print(sdata[indexPath.row].fuels ?? [])
        cell.fuel=sdata[indexPath.row].fuels ?? []
//        cell.registerNib()
//        cell.displayTable.delegate=self
//        cell.displayTable.dataSource=self
        if sdata[indexPath.row].paying == 0{
        if sdata[indexPath.row].status_number == 0{
            cell.bu1.backgroundColor=UIColor(named: "Color7")
            if sdata[indexPath.row].payment == "Bank transfer" || sdata[indexPath.row].payment == "التحويل المصرفي"{
                cell.bu1.backgroundColor=UIColor(named: "Color")
                cell.bu1.isEnabled=true
                cell.bu2.isEnabled=true

                cell.bu2.backgroundColor=UIColor(named: "Color13")


            }else{
                
                cell.bu1.isEnabled=false
                cell.bu1.backgroundColor=UIColor(named: "Color12")
                cell.bu2.backgroundColor=UIColor(named: "Color13")

            }
        }else if sdata[indexPath.row].status_number == 1{
            cell.status.backgroundColor=UIColor(named: "Color11")
            cell.bu1.backgroundColor=UIColor(named: "Color")
            test="Cancelled"
            cell.bu2.backgroundColor=UIColor(named: "Color13")


        }else if sdata[indexPath.row].status_number == 2{
            cell.status.backgroundColor=UIColor(named: "Color9")

            cell.bu1.isHidden=true
            cell.bu2.isHidden=true
        }else if sdata[indexPath.row].status_number == 3{
            cell.bu2.backgroundColor=UIColor(named: "Color")
            cell.bu1.isHidden=true
            cell.bu2.setTitle(NSLocalizedString("Track", comment: ""), for: .normal)
            test="Track"
        }else if sdata[indexPath.row].status_number == 4{
            cell.status.backgroundColor=UIColor(named: "Color10")

            cell.bu1.backgroundColor=UIColor(named: "Color")
            cell.bu2.backgroundColor=UIColor(named: "Color13")

            cell.bu1.isHidden=true
            cell.bu2.isHidden=true

        }else {
            cell.status.backgroundColor=UIColor(named: "Color8")

            cell.bu1.backgroundColor=UIColor(named: "Color")
            cell.bu2.backgroundColor=UIColor(named: "Color13")

            test="Cancelled"

        }
        }else{
            cell.bu1.isHidden=false
            cell.bu2.isHidden=false
            cell.bu1.isEnabled=false
            cell.bu1.backgroundColor=UIColor(named: "Color12")

            cell.bu2.isEnabled=true
        }
        cell.bu1.addTarget(self, action: #selector(self.bu1Preesed(_:)), for: .touchUpInside)
        cell.bu1.tag = indexPath.row
        
        cell.bu2.addTarget(self, action: #selector(self.bu2Preesed(_:)), for: .touchUpInside)
        cell.bu2.tag = indexPath.row
     return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = VCOrderDetails()
        vc.id = sdata[indexPath.row].id ?? 0
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 253.0 + (CGFloat(sdata[indexPath.row].fuels?.count ?? 0) * 70)

    }
    
}
extension VCCurrunt {
    
    func goToHomeSupervisor(){
        guard let window = UIApplication.shared.keyWindow else {return}
        
        UIView.transition(with: window , duration: 0.5, options: .transitionFlipFromLeft, animations: {
            let storyboard1 = UIStoryboard(name: "Main", bundle: nil)
            
            let vc = storyboard1.instantiateViewController(withIdentifier: "TTabBarViewController") as! TTabBarViewController
            
            window.rootViewController =  vc // UINavigationController(rootViewController: VCHome())
            
        }, completion: { completed in
            
        })
    }
    
    private func myOrder(){
        

        let parameters: Parameters = [
            "type" : 0
        ]

            print(API_KEYS.postMyOrder.url)
                 Alamofire.request(API_KEYS.postMyOrder.url, method: .post, parameters:parameters,headers: ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token")!)","Accept-Language": UserDefaults.standard.string(forKey: "language") ?? "en"]).validate().responseJSON { [self] (response) in
                if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
              print(str)
                    print(data)

                    if let parsedMapperString : MyOrder = Mapper<MyOrder>().map(JSONString:str){
                        if parsedMapperString.success == true{
                       
                            sdata=parsedMapperString.data ?? []
                            displayTable.delegate=self
                            displayTable.dataSource=self
                            if sdata.count == 0 {
                                self.emptyView.isHidden = false
                            }else {
                                self.emptyView.isHidden = true

                            }
                            displayTable.reloadData()
                            SVProgressHUD.dismiss()

                        }else{
                            showAlertMessage(title: "Error", message: parsedMapperString.message ?? "")

                            
                        }
                        }
                        
                    }
      
            }
  

    }
    

}
