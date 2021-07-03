//
//  VCDriverOrderF.swift
//  FastFual
//
//  Created by macbook on 6/17/21.
//

import UIKit
import Alamofire
import ObjectMapper
import SVProgressHUD
class VCDriverOrderF: UIViewController {
    var sdata:[OrderDriveData]=[]
    @IBOutlet var backButton: UIButton!
    var OrderStatus:Int?
    var PaymentStatus:Int?
    var Ordertype:Int?
    @IBOutlet var emptyView: UIView!

    @IBOutlet var displayTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controlBackItem(backItem: backButton)
print(sdata.count)
        registerNib()
        if sdata.count == 0 {
            emptyView.isHidden=false
        }else{
            emptyView.isHidden=true
//            SVProgressHUD.dismiss()

        display.delegate=self
        display.dataSource=self
        display.reloadData()
        }
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           self.tabBarController?.tabBar.isHidden = false

       }

       override func viewWillAppear(_ animated: Bool) {
                   super.viewWillAppear(animated)
           self.tabBarController?.tabBar.isHidden = true

       }
    @IBAction func back(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func registerNib(){
        let nib = UINib(nibName: "OrderCurrntCell", bundle: nil)
        displayTable.register(nib, forCellReuseIdentifier: "OrderCurrntCell")
    }
    
    func controlBackItem(backItem: UIButton){
       if L102Language.currentAppleLanguage().elementsEqual("ar"){
        if let _img = backItem.imageView{
            backItem.setImage(UIImage(cgImage: (_img.image?.cgImage!)!, scale:_img.image!.scale , orientation: UIImage.Orientation.upMirrored), for: .normal)
            
           }
       }
   }





@IBOutlet var filterAction: UIView!{
    didSet {
        filterAction.addGestureRecognizer( UITapGestureRecognizer(target: self, action: #selector(self.filterPreseed(_:))))
        filterAction.isUserInteractionEnabled = true
    }
}
@objc func filterPreseed(_ sender: UITapGestureRecognizer) {
    showFilter()

}
@IBAction func buBack(_ sender: Any) {
    navigationController?.popViewController(animated: true)
}
@IBOutlet var display: UITableView!
func showFilter()  {
    let  viewController =  OrderFilter()
    
            viewController.popBlocks = {
                value in
              if  value[0] == 200
              {
  
                    print ((value[0]))
                    print ((value[1]))
                    print ((value[2]))
                    print ((value[3]))
                    self.OrderStatus=value[1]
                    self.PaymentStatus=value[2]
                    self.Ordertype=value[3]

                    DispatchQueue.main.async
                    {
                        SVProgressHUD.show()
                        SVProgressHUD.setBackgroundColor(UIColor.clear)


                        self.myOrder(status: self.OrderStatus  ?? -1 , paying: self.PaymentStatus ?? -1 , booking: self.Ordertype ?? -1)

                        
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

var test=""
var test2=""




@objc func bu1Preesed(_ sender : UIButton ) {

    if  test==NSLocalizedString(NSLocalizedString("rate Order", comment: ""), comment: ""){
        let vc = VCOrderRate()
        vc.orderId=sdata[sender.tag].id ?? 0
        
        navigationController?.pushViewController(vc, animated: true)
   
    }else if test==NSLocalizedString(NSLocalizedString("Complete Order", comment: ""), comment: ""){
        
        orderCompleted(id: sdata[sender.tag].id ?? 0)

        
        
        
    }else{
        
        
    }
}
@objc func bu2Preesed(_ sender : UIButton ) {
    
    
    if  test==NSLocalizedString("Track", comment: ""){
        let vc = VCOrdersDetailsTrack()
        vc.id = sdata[sender.tag].id ?? 0
        navigationController?.pushViewController(vc, animated: true)
    }else if  test==NSLocalizedString("Rate order", comment: ""){
        
        let vc = VCOrderRate()
        vc.orderId=sdata[sender.tag].id ?? 0
        
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
    

}


extension VCDriverOrderF:UITableViewDataSource,UITableViewDelegate{

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    print(sdata.count)
    return sdata.count
    
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier:
                                                "OrderCurrntCell", for: indexPath) as! OrderCurrntCell
    cell.logo.sd_setImage(with:URL(string:(sdata[indexPath.row].supplier?.image)! ))
//    id=sdata[indexPath.row].id!
    cell.laStationName.text=sdata[indexPath.row].supplier?.company_name ?? ""
    cell.laTo.text=sdata[indexPath.row].driver?.name
    let dateFormatter = DateFormatter()

    dateFormatter.locale = Locale(identifier: "en_us")
    dateFormatter.dateFormat = "EEE, dd.MM.yyyy, hh:mm a"
    if let date = dateFormatter.date(from: sdata[indexPath.row].order_time ?? "") {
        cell.laDate.text = "\(date)"
    }
    cell.laFrom.text=sdata[indexPath.row].supplier?.address ?? ""
    cell.laLength.text = "\(Int((sdata[indexPath.row].supplier?.distance)!))"
    cell.buStatus.setTitle(sdata[indexPath.row].status, for: .normal)
    cell.laToLocation.text=sdata[indexPath.row].driver?.address?.address
    
    
//    if sdata[indexPath.row].paying == 0{
     if sdata[indexPath.row].status_number == 2{
        cell.buStatus.backgroundColor=UIColor(named: "Color9")

        cell.delieveringAction.isHidden=false
        cell.googleMapTrack.isHidden=false
    }else if sdata[indexPath.row].status_number == 3{
        cell.buStatus.backgroundColor=UIColor(named: "Color7")

        cell.googleMapTrack.isHidden=true
        test = NSLocalizedString("Complete Order", comment: "")
        cell.delieveringAction.setTitle(test, for: .normal)

    }else if sdata[indexPath.row].status_number == 4{
        cell.buStatus.backgroundColor=UIColor(named: "Color10")

        cell.delieveringAction.isHidden=true
        cell.googleMapTrack.isHidden=true

    }else{
        cell.googleMapTrack.isHidden=true
        cell.buStatus.backgroundColor=UIColor(named: "Color8")

        if sdata[indexPath.row].is_rating == false{
            
            cell.delieveringAction.isEnabled=true
            cell.delieveringAction.setTitle(NSLocalizedString("rate Order", comment: ""), for: .normal)

        }else{
            cell.delieveringAction.isEnabled=false
            cell.delieveringAction.setTitle(NSLocalizedString("Already rating", comment: ""), for: .normal)
            cell.delieveringAction.backgroundColor=UIColor(named: "Color12")

        }


    }
//    }else{
////        cell.delieveringAction.isHidden=false
////        cell.googleMapTrack.isHidden=false
////        cell.delieveringAction.isEnabled=false
////        cell.delieveringAction.backgroundColor=UIColor(named: "Color12")
////
////        cell.googleMapTrack.isEnabled=true
//    }
    cell.delieveringAction.addTarget(self, action: #selector(self.bu1Preesed(_:)), for: .touchUpInside)
    cell.delieveringAction.tag = indexPath.row
    
    cell.googleMapTrack.addTarget(self, action: #selector(self.bu2Preesed(_:)), for: .touchUpInside)
    cell.googleMapTrack.tag = indexPath.row

 return cell
    
}


}
extension VCDriverOrderF{
    func orderCompleted(id:Int){
    
      let  driveUrl = API_KEYS.getOrderCompleted.withId(id:id )

            
        Alamofire.request(driveUrl, method: .get, parameters:nil,headers: ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token")!)"]).validate().responseJSON { [self] (response) in
                if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
              print(str)
                    if let parsedMapperString : OrderDrive = Mapper<OrderDrive>().map(JSONString:str){
                        if parsedMapperString.success == true{
                            SVProgressHUD.show()
                     
                            self.myOrder(status: self.OrderStatus  ?? -1 , paying: self.PaymentStatus ?? -1 , booking: self.Ordertype ?? -1)

                        }
                        }
                        
                    }
        
            }
    }
private func myOrder(status:Int,paying:Int,booking:Int){
    
    let parameters: Parameters = [
        "status" : status ,
        "paying" : paying,
        "booking" : booking
    ]

    
Alamofire.request(API_KEYS.postOrders.url, method: .post, parameters:parameters,headers: ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token")!)","Accept-Language": UserDefaults.standard.string(forKey: "language") ?? "en"]).validate().responseJSON { [self] (response) in
        if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
      print(str)
            if let parsedMapperString : OrderDrive = Mapper<OrderDrive>().map(JSONString:str){
                if parsedMapperString.success == true{
                    sdata=(parsedMapperString.data) ?? []
                    print(sdata.count)
                    if sdata.count == 0 {
                        self.emptyView.isHidden = false
                    }else {
                        self.emptyView.isHidden = true

                    
                        display.delegate=self
                        display.dataSource=self
                        display.reloadData()
                        }
                        SVProgressHUD.dismiss()


       
                    }else{
                        showAlertMessage(title: "Error", message: parsedMapperString.message ?? "")
                    }}}}
                    

}

}
