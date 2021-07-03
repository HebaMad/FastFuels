//
//  VCOrderDetails.swift
//  FastFual
//
//  Created by Basim on 4/10/21.
//

import UIKit
import Alamofire
import ObjectMapper
import SDWebImage
class VCOrderDetails: UIViewController {
    static var identifier = "VCOrderDetails"
    var sdata:OrderDetailsData?
    var fuel:[Fuell]=[]
    var id = 0
    var test=""
    var test2=""
//    @IBOutlet var bu1: UIButton!
//    @IBOutlet var bu2: UIButton!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var laView: UIView!
    
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBOutlet var vatValue: UILabel!
    @IBOutlet var laStationName: UILabel!
    @IBOutlet var laPrice: UILabel!
    @IBOutlet var laCode: UILabel!
    @IBOutlet var laItemNum: UILabel!
    @IBOutlet var laQNum: UILabel!
    
    @IBOutlet var orderStstus: UILabel!
    @IBOutlet var stationImg: UIImageView!
    @IBOutlet var laSize: UILabel!
    @IBOutlet var laQuality: UILabel!
    @IBOutlet var laCopoun: UILabel!
    @IBOutlet var laTotalPrice: UILabel!
    @IBOutlet var laDate: UILabel!
    
    @IBOutlet var laOrderTime: UILabel!
    @IBOutlet var txtVNote: UITextView!
    
    
    @IBOutlet var displayTable: UITableView!
    
    
    @IBOutlet var buRateOrder: UIButton!{
        didSet {
            buRateOrder.addTarget(self, action: #selector(self.buRateOrderPressed), for: .touchUpInside)
        } }
    @objc func buRateOrderPressed() {

                if  test==NSLocalizedString("Track", comment: ""){
                    let vc = VCOrdersDetailsTrack()
                    vc.id = sdata?.id ?? 0
                    navigationController?.pushViewController(vc, animated: true)
                }else if  test==NSLocalizedString("Rate order", comment: ""){
        
                    let vc = VCOrderRate()
                    vc.orderId=sdata?.id ?? 0
        
                    navigationController?.pushViewController(vc, animated: true)
                }else{
        
                let vc=VCCancelOrders()
                vc.id=sdata?.id ?? 0
        
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

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        
    }
    @IBOutlet var buRecorder: UIButton!{
        didSet {
            buRecorder.addTarget(self, action: #selector(self.buRecorderPressed), for: .touchUpInside)
        } }
    @objc func buRecorderPressed() {
        if  test2 == NSLocalizedString("Reorder", comment: ""){
                 reOrder(id:sdata?.id ?? 0)
     
             }else{
     
             }
             if #available(iOS 13.0, *) {
                 let storyboard1 = UIStoryboard(name: "Main", bundle: nil)
     
                 let vc = storyboard1.instantiateViewController(identifier: "VCBankTransfer") as! VCBankTransfer
                 vc.orderId=sdata?.id ?? 0
                 vc.total=sdata?.total ?? 0.0
                 vc.orderNum=sdata?.order_number ?? 0
     
                     navigationController?.pushViewController(vc, animated: false)
     
     
             }else {
     
     
             }
     
     
     
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()
        orderDetails()
        //        displayTable.reloadData()
        controlBackItem(backItem: backButton)
        
    }
    
    func registerNib(){
        let nib = UINib(nibName: "CVCOrderDetails", bundle: nil)
        displayTable.register(nib, forCellReuseIdentifier: "CVCOrderDetails")
    }
    
}
extension VCOrderDetails : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fuel.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CVCOrderDetails", for: indexPath) as! CVCOrderDetails
        cell.laGasType.text=fuel[indexPath.row].fuel_name ?? ""
        cell.laGasQuantity.text="\(fuel[indexPath.row].quantity ?? 0)"
        cell.laPrice.text=fuel[indexPath.row].price ?? ""  + " " + "SR"
        cell.laSize.text=fuel[indexPath.row].size ?? ""
        cell.img.sd_setImage(with:URL(string: fuel[indexPath.row].fuel_image ?? ""))
        
        return cell
    }
    
    
}
extension VCOrderDetails {
    
    
    private func orderDetails(){
        
        let  orderDetails = API_KEYS.getorder_details.withId(id:id )
        Alamofire.request(orderDetails, method: .get, parameters:nil,headers: ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token")!)","Accept-Language": UserDefaults.standard.string(forKey: "language") ?? "en"]).validate().responseJSON { [self] (response) in
            if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
                
                if let parsedMapperString : OrderDetails = Mapper<OrderDetails>().map(JSONString:str){
                    if parsedMapperString.success == true{
                        sdata=parsedMapperString.data
                        fuel=parsedMapperString.data?.fuels ?? []
                        
             
                        laStationName.text=sdata?.supplier?.company_name
                        stationImg.sd_setImage(with:URL(string: sdata?.supplier?.logo ?? ""))
                        laCode.text = "OR#" + "\(sdata?.order_number ?? 0)"
                        laItemNum.text = "\(sdata?.items ?? 0)"
                        laQNum.text = sdata?.size ?? ""  + "ltr"
//                        let dateFormatter = DateFormatter()
//                        dateFormatter.locale = Locale(identifier: "en_us")
//                        dateFormatter.dateFormat = "EEE, dd.MM.yyyy, hh:mm a"
                        laDate.text = sdata?.order_time ?? ""
                        
                        laPrice.text = "\(sdata?.total ?? 0)" + " " + "SR"
                        laSize.text="\(sdata?.size ?? "")"
                        laQuality.text = "\(sdata?.quantity ?? 0)"
                        laCopoun.text = sdata?.coupon ?? ""   + " " + "SR"
                        laTotalPrice.text = "\(sdata?.total ?? 0)" + " " + "SR"
                        txtVNote.text = sdata?.additional_note ?? "THERES NO NOTE"
                        vatValue.text = "\(sdata?.vat ?? 0)" + " "  + "SR"
                        displayTable.delegate=self
                        displayTable.dataSource=self
                        displayTable.reloadData()
                 
                        if sdata?.paying == 0{
                            
                            if sdata?.status_number == 0{
                                orderStstus.text="Pending"
                                laView.backgroundColor=UIColor(named: "Color4")
                                
                                if sdata?.payment == NSLocalizedString("Bank transfer", comment: "")
                                {
                                    buRecorder.backgroundColor=UIColor(named: "Color")
                                    buRecorder.isEnabled=true
                                    buRateOrder.backgroundColor=UIColor(named: "Color13")
                                    test = NSLocalizedString("Canceled", comment: "")
                                    test2 = NSLocalizedString("Pay Now", comment: "")
                                    
                                    buRecorder.setTitle(test2, for: .normal)
                                    buRateOrder.setTitle(test, for: .normal)
                                    
                                }else{
                                    
                                    buRecorder.isEnabled=false
                                    buRecorder.backgroundColor=UIColor(named: "Color12")
                                    buRateOrder.backgroundColor=UIColor(named: "Color13")
                                    test = NSLocalizedString("Canceled", comment: "")
                                    buRateOrder.setTitle(test, for: .normal)

                                    
                                }
                            }else if sdata?.status_number == 1{
                                laView.backgroundColor=UIColor(named: "Color11")
                                orderStstus.text="Accepted"
                                buRecorder.isHidden=true
                                buRateOrder.isHidden=true
                                buRecorder.backgroundColor=UIColor(named: "Color")
                                buRateOrder.backgroundColor=UIColor(named: "Color13")
                                test = NSLocalizedString("Canceled", comment: "")
                                buRateOrder.setTitle(test, for: .normal)

                                
                                
                            }else if sdata?.status_number == 2{
                                laView.backgroundColor=UIColor(named: "Color9")
                                orderStstus.text="Confirmed"
                                
                                buRecorder.isHidden=true
                                buRateOrder.isHidden=true
                                
                            }else if sdata?.status_number == 3{
                                laView.backgroundColor=UIColor(named: "Color")
                                orderStstus.text="Delivering"
                                buRateOrder.backgroundColor=UIColor(named: "Color")
                                buRecorder.isHidden=true
                                buRateOrder.setTitle("Track", for: .normal)
                                test = NSLocalizedString("Track", comment: "")
                                buRateOrder.setTitle(test, for: .normal)

                            }else if sdata?.status_number == 4{
                                laView.backgroundColor=UIColor(named: "Color10")
                                orderStstus.text="Canceled"
                                
                                buRecorder.isHidden=true
                                buRateOrder.isHidden=true
                            }else {
                                laView.backgroundColor=UIColor(named: "Color8")
                                
                                orderStstus.text="Completed"
                                if sdata?.is_rating == false{
                                    buRateOrder.isEnabled=true
                                    laView.backgroundColor=UIColor(named: "Color")
                                    
                                }else{
                                    buRateOrder.isEnabled=false
                                    buRateOrder.backgroundColor=UIColor(named: "Color14")
                                    
                                }
                                
                                laView.backgroundColor=UIColor(named: "Color8")
                                buRateOrder.setTitle(NSLocalizedString("Rate order", comment: ""), for: .normal)
                                buRecorder.setTitle(NSLocalizedString("Reorder", comment: ""), for: .normal)
                                
                                test = NSLocalizedString("Rate order", comment: "")
                                test2 = NSLocalizedString("Reorder", comment: "")
                                buRateOrder.setTitle(test, for: .normal)
                                buRecorder.setTitle(test2, for: .normal)

                                buRecorder.isHidden=false
                                buRateOrder.isHidden=false
                            }
                        }else{
                            buRecorder.isHidden=false
                            buRateOrder.isHidden=false
                            buRecorder.isEnabled=false
                            buRecorder.backgroundColor=UIColor(named: "Color12")

                            buRateOrder.isEnabled=true
                        }

                        
                        
                    }else{
                        showAlertMessage(title: "Error", message: parsedMapperString.message ?? "")
                        
                    }
                    
                    
                }
                
            }
        }
        
        
    }
    
    private func reOrder(id:Int){
        
        
        let  reOrder = API_KEYS.getre_order.withId(id:id )
        
        
        Alamofire.request(reOrder, method: .get, parameters:nil,headers: ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token")!)","Accept-Language": UserDefaults.standard.string(forKey: "Langugee") ?? "en"]).validate().responseJSON { [self] (response) in
            if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
                
                if let parsedMapperString : MyOrder = Mapper<MyOrder>().map(JSONString:str){
                    if parsedMapperString.success == true{
                        
                        showAlertMessage(title: "Fast Fuel", message: parsedMapperString.message ?? "")
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
