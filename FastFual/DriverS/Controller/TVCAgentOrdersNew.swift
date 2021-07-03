//
//  TVCAgentOrdersNew.swift
//  FastFual
//
//  Created by macbook on 5/20/21.
//

import UIKit
import XLPagerTabStrip
import Alamofire
import ObjectMapper
class TVCAgentOrdersNew: UIViewController,IndicatorInfoProvider {
    var sdata:[OrderDriveData]=[]
    
    @IBOutlet var emptyView: UIView!
static var identifier = "TVCAgentOrdersNew"
    var itemInfo: IndicatorInfo = "New"

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    @IBOutlet var TdisplayOrder: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emptyView.isHidden = true

        registerNib()
        orderDrive()
        TdisplayOrder.delegate=self
        TdisplayOrder.dataSource=self
        

        // Do any additional setup after loading the view.
    }


    func registerNib(){
        let nib = UINib(nibName: "OrderCurrntCell", bundle: nil)
        TdisplayOrder.register(nib, forCellReuseIdentifier: "OrderCurrntCell")
    }
    @objc func bugoogleMapTrackPreesed(_ sender : UIButton ) {


    }
    @objc func budelieveringPreesed(_ sender : UIButton ) {
        orderDelievering        (id: sdata[sender.tag].id ?? 0)


    }
}

extension TVCAgentOrdersNew : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sdata.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCurrntCell", for: indexPath) as! OrderCurrntCell
        cell.logo.sd_setImage(with:URL(string:(sdata[indexPath.row].supplier?.image)! ))

        cell.laStationName.text=sdata[indexPath.row].supplier?.company_name ?? ""
        cell.laTo.text=sdata[indexPath.row].driver?.name
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_us")
        dateFormatter.dateFormat = "dd.MM.yyyy, hh:mm a"
        if let date = dateFormatter.date(from: sdata[indexPath.row].order_time ?? "") {
            cell.laDate.text = "\(date)"
        }
        cell.laFrom.text=sdata[indexPath.row].supplier?.address ?? ""
        cell.laLength.text = "\(Int((sdata[indexPath.row].supplier?.distance)!))"
        cell.buStatus.setTitle(sdata[indexPath.row].status, for: .normal)
        cell.laToLocation.text=sdata[indexPath.row].driver?.address?.address
        
        cell.delieveringAction.addTarget(self, action: #selector(self.budelieveringPreesed(_:)), for: .touchUpInside)
        cell.delieveringAction.tag = indexPath.row
        
        cell.googleMapTrack.addTarget(self, action: #selector(self.bugoogleMapTrackPreesed(_:)), for: .touchUpInside)
        cell.googleMapTrack.tag = indexPath.row

return cell
    }
    
    
}
extension TVCAgentOrdersNew{
    
private func orderDrive(){
    
 
    let parameters: Parameters = [
        "type":0,
   
        ]

        
    Alamofire.request(API_KEYS.postOrders.url, method: .post, parameters:parameters,headers: ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token")!)","Accept-Language": UserDefaults.standard.string(forKey: "language") ?? "en"]).validate().responseJSON { [self] (response) in
            if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
          print(str)
                if let parsedMapperString : OrderDrive = Mapper<OrderDrive>().map(JSONString:str){
                    if parsedMapperString.success == true{
                        sdata=(parsedMapperString.data)!
                        if sdata.count == 0 {
                            self.emptyView.isHidden = false
                        }else {
                            self.emptyView.isHidden = true

                        }
                        TdisplayOrder.reloadData()
                    }else{
                        showAlertMessage(title: "Error", message: parsedMapperString.message ?? "")
                    }
                    }
                }
        }
}
    
    func orderDelievering(id:Int){
    
      let  driveUrl = API_KEYS.getOrderDeleviered.withId(id:id )

            
        Alamofire.request(driveUrl, method: .get, parameters:nil,headers: ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token")!)"]).validate().responseJSON { [self] (response) in
                if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
              print(str)
                    if let parsedMapperString : OrderDrive = Mapper<OrderDrive>().map(JSONString:str){
                        if parsedMapperString.success == true{
                            showAlertMessage(title: "Fast Fuel", message: parsedMapperString.message ?? "")

                        }else{
                            showAlertMessage(title: "Error", message: parsedMapperString.message ?? "")
                        }
                        }
                        
                    }
        
            }
    }

    
    
    
     
}
