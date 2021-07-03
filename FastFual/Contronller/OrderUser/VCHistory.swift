//
//  VCHistory.swift
//  Antadrak
//
//  Created by Basim on 7/30/20.
//  Copyright © 2020 Basim. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Alamofire
import ObjectMapper
import SVProgressHUD
class VCHistory: UIViewController  , UITextFieldDelegate,IndicatorInfoProvider{
    var sdata:[MyOrderData]=[]
    
    @IBAction func buOrderNow(_ sender: Any) {
        goToHomeSupervisor()
        
    }
    @objc func bu1Preesed(_ sender : UIButton ) {
        SVProgressHUD.show()

        reOrder(id:sdata[sender.tag].id ?? 0)
        displayTable.reloadData()
    }
    @objc func bu2Preesed(_ sender : UIButton ) {
        
        let vc = VCOrderRate()
        vc.orderId=sdata[sender.tag].id ?? 0
        
        navigationController?.pushViewController(vc, animated: true)
        
    }

    @IBOutlet var emptyView: UIView!
    var itemInfo: IndicatorInfo = "History"

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
    @IBOutlet var displayTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        emptyView.isHidden=true
        SVProgressHUD.show()

        registerNib()
        myOrder()

    }
    func registerNib(){
        let nib = UINib(nibName: "CVCOrdersCurrent", bundle: nil)
        displayTable.register(nib, forCellReuseIdentifier: "CVCOrdersCurrent")
    }
}
extension VCHistory : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sdata.count
        
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CVCOrdersCurrent", for: indexPath) as! CVCOrdersCurrent
        cell.name.text=sdata[indexPath.row].supplier?.company_name ?? ""
        cell.orderNum.text = "OR#" + "\(sdata[indexPath.row].order_number ?? 0)"
        cell.orderTime.text=sdata[indexPath.row].diff ?? ""
        cell.status.setTitle(sdata[indexPath.row].status, for: .normal)
        cell.totalPrice.text="\(sdata[indexPath.row].total ?? 0.0)" +  NSLocalizedString("SR", comment: "")
        cell.fuel=sdata[indexPath.row].fuels ?? []


        if sdata[indexPath.row].status_number == 0{
            cell.status.backgroundColor=UIColor(named: "Color7")
            if sdata[indexPath.row].is_rating == false{
                cell.bu1.isEnabled=true
                cell.status.backgroundColor=UIColor(named: "Color")

            }else{
                cell.bu1.isEnabled=false
                cell.bu2.backgroundColor=UIColor(named: "Color14")


            }
            cell.bu1.isHidden=false
            cell.bu2.isHidden=false
        }else if sdata[indexPath.row].status_number == 1{
            cell.status.backgroundColor=UIColor(named: "Color11")
            if sdata[indexPath.row].is_rating == false{
                cell.bu2.isEnabled=true
                cell.status.backgroundColor=UIColor(named: "Color")

            }else{
                cell.bu2.isEnabled=false
                cell.bu2.backgroundColor=UIColor(named: "Color14")


            }
            cell.bu1.isHidden=false
            cell.bu2.isHidden=false
        }else if sdata[indexPath.row].status_number == 2{
            cell.status.backgroundColor=UIColor(named: "Color9")
            if sdata[indexPath.row].is_rating == false{
                cell.bu2.isEnabled=true
                cell.status.backgroundColor=UIColor(named: "Color")

            }else{
                cell.bu2.isEnabled=false
                cell.bu2.backgroundColor=UIColor(named: "Color14")


            }
            cell.bu1.isHidden=false
            cell.bu2.isHidden=false
        }else if sdata[indexPath.row].status_number == 3{
            cell.status.backgroundColor=UIColor(named: "Color")
            if sdata[indexPath.row].is_rating == false{
                cell.bu2.isEnabled=true
                cell.status.backgroundColor=UIColor(named: "Color")

            }else{
                cell.bu2.isEnabled=false
                cell.bu2.backgroundColor=UIColor(named: "Color14")


            }
            cell.bu1.isHidden=false
            cell.bu2.isHidden=false
        }else if sdata[indexPath.row].status_number == 4{
            cell.status.backgroundColor=UIColor(named: "Color10")
            cell.bu1.isHidden=true
            cell.bu2.isHidden=true

        }else {
            
            if sdata[indexPath.row].is_rating == false{
                cell.bu2.isEnabled=true
                cell.status.backgroundColor=UIColor(named: "Color")

            }else{
                cell.bu2.isEnabled=false
                cell.bu2.backgroundColor=UIColor(named: "Color14")

            }
            
            cell.status.backgroundColor=UIColor(named: "Color8")
            cell.bu2.setTitle(NSLocalizedString("Rate order", comment: ""), for: .normal)
            cell.bu1.isHidden=false
            cell.bu2.isHidden=false
  
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
extension VCHistory {
    
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
        
        sdata = []

        let parameters: Parameters = [
            "type":1
    
            ]

            
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
    private func reOrder(id:Int){
        

        let  reOrder = API_KEYS.getre_order.withId(id:id )


                 Alamofire.request(reOrder, method: .get, parameters:nil,headers: ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token")!)","Accept-Language": UserDefaults.standard.string(forKey: "language") ?? "en"]).validate().responseJSON { [self] (response) in
                if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
     
                    if let parsedMapperString : MyOrder = Mapper<MyOrder>().map(JSONString:str){
                        if parsedMapperString.success == true{
                            showAlertMessage(title: "Fast Fuel", message: parsedMapperString.message ?? "")
                            myOrder()
                        }
                        }
                        
                    }
      
            }
  

    }
    
}
