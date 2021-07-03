//
//  TVCAgentOrdersCurrent.swift
//  FastFual
//
//  Created by macbook on 5/20/21.
//

import UIKit
import XLPagerTabStrip
import Alamofire
import ObjectMapper
class TVCAgentOrdersCurrent: UIViewController ,IndicatorInfoProvider {
    
    @IBOutlet var emptyView: UIView!

    static var identifier = "TVCAgentOrdersCurrent"
    var itemInfo: IndicatorInfo = "Current"
    var sdata:[OrderDriveData]=[]

    var id:Int = 0
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    @IBOutlet var TdisplayOrder: UITableView!
    @objc func budelieveringPressed() {
        orderCompleted(id: id)
}
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
        let nib = UINib(nibName: "CVCOrdersNew", bundle: nil)
        TdisplayOrder.register(nib, forCellReuseIdentifier: "CVCOrdersNew")
    }
    @objc func buCompletePreesed(_ sender : UIButton ) {

        orderCompleted(id: sdata[sender.tag].id ?? 0)

    }
}

extension TVCAgentOrdersCurrent : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sdata.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CVCOrdersNew", for: indexPath) as! CVCOrdersNew

        cell.logo.sd_setImage(with:URL(string:(sdata[indexPath.row].supplier?.image)! ))
        id=sdata[indexPath.row].id!
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
        
        cell.buComplete.addTarget(self, action: #selector(self.buCompletePreesed(_:)), for: .touchUpInside)
        cell.buComplete.tag = indexPath.row
  

return cell
    }
}
extension TVCAgentOrdersCurrent{
    
private func orderDrive(){
    
 
    let parameters: Parameters = [
        "type":1,
   
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
    func orderCompleted(id:Int){
    
      let  driveUrl = API_KEYS.getOrderCompleted.withId(id:id )

            
        Alamofire.request(driveUrl, method: .get, parameters:nil,headers: ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token")!)"]).validate().responseJSON { [self] (response) in
                if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
              print(str)
                    if let parsedMapperString : OrderDrive = Mapper<OrderDrive>().map(JSONString:str){
                        if parsedMapperString.success == true{
                            showAlertMessage(title: "Fast Fuel", message: parsedMapperString.message ?? "")
                            orderDrive()
                        }
                        }
                        
                    }
        
            }
    }
    
    
    
}
