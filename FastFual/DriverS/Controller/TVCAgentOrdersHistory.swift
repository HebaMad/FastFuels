//
//  TVCAgentOrdersHistory.swift
//  FastFual
//
//  Created by macbook on 5/20/21.
//

import UIKit
import XLPagerTabStrip
import Alamofire
import ObjectMapper
import SDWebImage
class TVCAgentOrdersHistory: UIViewController,IndicatorInfoProvider  {
    @IBOutlet var emptyView: UIView!
    var driverN:String=""
    var driverAdress:String=""

    var sdata:[OrderDriveData]=[]
    static var identifier = "TVCAgentOrdersHistory"
    var itemInfo: IndicatorInfo = "History"

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    @IBOutlet var TdisplayOrder: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emptyView.isHidden=true

        registerNib()
      //  orderDrive()
        
        TdisplayOrder.delegate = self
        TdisplayOrder.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        orderDrive()


        self.TdisplayOrder.reloadData()
    }


    func registerNib(){
        let nib = UINib(nibName: "CVCOrdersHistory", bundle: nil)
        TdisplayOrder.register(nib, forCellReuseIdentifier: "CVCOrdersHistory")
    }
    @objc func buRateOrderPreesed(_ sender : UIButton ) {
            let vc = VCOrderRate()
            vc.orderId=sdata[sender.tag].id ?? 0
            
            navigationController?.pushViewController(vc, animated: true)
       

    }
}

extension TVCAgentOrdersHistory : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(sdata.count)
        return sdata.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CVCOrdersHistory", for: indexPath) as! CVCOrdersHistory
        cell.logo.sd_setImage(with:URL(string:(sdata[indexPath.row].supplier?.logo)! ))

        cell.laStationName.text=sdata[indexPath.row].supplier?.company_name ?? ""
        cell.laTo.text=sdata[indexPath.row].driver?.name
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_us")
        dateFormatter.dateFormat = "dd.MM.yyyy, hh:mm a"
        if let date = dateFormatter.date(from: sdata[indexPath.row].order_time ?? "") {
            cell.laDate.text = "\(date)"
        }
//        cell.laDate.text=sdata[indexPath.row].order_time ?? ""
        
        
        
        cell.laFrom.text=sdata[indexPath.row].supplier?.address ?? ""
        cell.laLength.text = "\(Int((sdata[indexPath.row].supplier?.distance)!))"
        cell.buStatus.setTitle(sdata[indexPath.row].status, for: .normal)
        cell.laToLocation.text=sdata[indexPath.row].driver?.address?.address
        if sdata[indexPath.row].is_rating == true{
            cell.buRateOrder.isEnabled=false
            cell.buRateOrder.backgroundColor = UIColor(named: "Color12")
            
        }else{
            cell.buRateOrder.isEnabled=true
            cell.buRateOrder.backgroundColor = UIColor(named: "Color")

        }
        
        cell.buRateOrder.addTarget(self, action: #selector(self.buRateOrderPreesed(_:)), for: .touchUpInside)
        cell.buRateOrder.tag = indexPath.row
        return cell
    }

    
    
    
}
extension TVCAgentOrdersHistory{
    
private func orderDrive(){
    
 
    let parameters: Parameters = [
        "type":2
   
        ]

        
    Alamofire.request(API_KEYS.postOrders.url, method: .post, parameters:parameters,headers: ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token")!)","Accept-Language": UserDefaults.standard.string(forKey: "language") ?? "en"]).validate().responseJSON { [self] (response) in
            if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
          print(str)
                if let parsedMapperString : OrderDrive = Mapper<OrderDrive>().map(JSONString:str){
                    if parsedMapperString.success == true{
                        sdata=(parsedMapperString.data)!
                        print(sdata.count)
                        if sdata.count == 0 {
                            self.emptyView.isHidden = false
                        }else {
                            self.emptyView.isHidden = true

                        }
                        self.TdisplayOrder.reloadData()
                    }else{
                        showAlertMessage(title: "Error", message: parsedMapperString.message ?? "")
                    }
                    }
                    
                }
    
        }


}
    
}
