//
//  VCFResult.swift
//  FastFual
//
//  Created by macbook on 6/11/21.
//

import UIKit
import Alamofire
import ObjectMapper
import SVProgressHUD
class VCFResult: UIViewController {
    var sdata:[MyOrderData]=[]
    @IBOutlet var emptyView: UIView!

    @IBOutlet var filterAction: UIView!{
        didSet {
            filterAction.addGestureRecognizer( UITapGestureRecognizer(target: self, action: #selector(self.filterPreseed(_:))))
            filterAction.isUserInteractionEnabled = true
        }
    }
    @objc func filterPreseed(_ sender: UITapGestureRecognizer) {
        showFilter()

    }
    @IBOutlet var backButton: UIButton!
    @IBAction func buBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBOutlet var display: UITableView!
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
                            SVProgressHUD.show()
                            SVProgressHUD.setBackgroundColor(UIColor.clear)

                            self.myOrder(status: value[1] ?? "-1" , paying: value[2] ?? "-1" , booking: value[3] ?? "-1")

                            
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

    override func viewDidLoad() {
        super.viewDidLoad()
        controlBackItem(backItem: backButton)
        emptyView.isHidden = true
        if sdata.count == 0 {
            self.emptyView.isHidden = false
            
        }else {
            self.emptyView.isHidden = true
            registerNib()
            display.delegate=self
            display.dataSource=self
            display.reloadData()
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
    
    func registerNib(){
        let nib = UINib(nibName: "CVCOrdersCurrent", bundle: nil)
        display.register(nib, forCellReuseIdentifier: "CVCOrdersCurrent")
    }
    func controlBackItem(backItem: UIButton){
       if L102Language.currentAppleLanguage().elementsEqual("ar"){
        if let _img = backItem.imageView{
            backItem.setImage(UIImage(cgImage: (_img.image?.cgImage!)!, scale:_img.image!.scale , orientation: UIImage.Orientation.upMirrored), for: .normal)
            
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
                        }
                        }
                        
                    }
      
            }
  

    }

    @objc func bu1Preesed(_ sender : UIButton ) {
//        let vc=VCBankTransfer()
        if  test2 == NSLocalizedString("Reorder", comment: ""){
            reOrder(id:sdata[sender.tag].id ?? 0)

        }else{
            
        }
        if #available(iOS 13.0, *) {
            let storyboard1 = UIStoryboard(name: "Main", bundle: nil)

            let vc = storyboard1.instantiateViewController(identifier: "VCBankTransfer") as! VCBankTransfer
            vc.orderId=sdata[sender.tag].id ?? 0
            vc.total=sdata[sender.tag].total ?? 0.0
            vc.orderNum=sdata[sender.tag].order_number ?? 0

                navigationController?.pushViewController(vc, animated: false)
            
            
        }else {
            
            
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
                            display.delegate=self
                            display.dataSource=self
                            display.reloadData()
                            if sdata.count == 0 {
                                self.emptyView.isHidden = false
                            }else {
                                self.emptyView.isHidden = true

                            }
                            SVProgressHUD.dismiss()


           
                        }else{
                            showAlertMessage(title: "Error", message: parsedMapperString.message ?? "")
                        }}}}
                        

    }
    
    
}
extension VCFResult:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(sdata.count)
        return sdata.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
                                                    "CVCOrdersCurrent", for: indexPath) as! CVCOrdersCurrent
        cell.bu1.setTitle("Pay Now", for: .normal)
        cell.bu2.setTitle("Canceled", for: .normal)

        cell.name.text=sdata[indexPath.row].supplier?.company_name ?? ""
        cell.orderNum.text = "OR#" + "\(sdata[indexPath.row].diff ?? "" )"
        cell.orderTime.text=sdata[indexPath.row].order_time ?? ""
        cell.status.setTitle(sdata[indexPath.row].status, for: .normal)
        cell.totalPrice.text="\(sdata[indexPath.row].total ?? 0.0)" + " " + "SR"
        cell.fuel=sdata[indexPath.row].fuels ?? []

        if sdata[indexPath.row].paying == 0{
        if sdata[indexPath.row].status_number == 0{
            cell.status.backgroundColor=UIColor(named: "Color4")
            if sdata[indexPath.row].payment == NSLocalizedString("Bank transfer", comment: "")
{
                cell.bu1.backgroundColor=UIColor(named: "Color")
                cell.bu1.isEnabled=true
                cell.bu2.backgroundColor=UIColor(named: "Color13")
                test = NSLocalizedString("Canceled", comment: "")
                test2 = NSLocalizedString("Pay Now", comment: "")

                cell.bu1.setTitle(test2, for: .normal)
                cell.bu2.setTitle(test, for: .normal)

            }else{
                
                cell.bu1.isEnabled=false
                cell.bu1.backgroundColor=UIColor(named: "Color12")
                cell.bu2.backgroundColor=UIColor(named: "Color13")
                test = NSLocalizedString("Canceled", comment: "")
                cell.bu2.setTitle(test, for: .normal)

            }
            
        }else if sdata[indexPath.row].status_number == 1{
            cell.status.backgroundColor=UIColor(named: "Color11")
            cell.bu1.isHidden=true
            cell.bu2.isHidden=true
//            cell.bu1.backgroundColor=UIColor(named: "Color")
//            cell.bu2.backgroundColor=UIColor(named: "Color13")
//            test = NSLocalizedString("Canceled", comment: "")


        }else if sdata[indexPath.row].status_number == 2{
            cell.status.backgroundColor=UIColor(named: "Color9")

            cell.bu1.isHidden=true
            cell.bu2.isHidden=true
        }else if sdata[indexPath.row].status_number == 3{
            cell.status.backgroundColor=UIColor(named: "Color")

            cell.bu2.backgroundColor=UIColor(named: "Color")
            cell.bu1.isHidden=true
            cell.bu2.setTitle("Track", for: .normal)
            test = NSLocalizedString("Track", comment: "")
            cell.bu2.setTitle(test, for: .normal)


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
            cell.bu1.setTitle(NSLocalizedString("Reorder", comment: ""), for: .normal)

            test = NSLocalizedString("Rate order", comment: "")
            test2 = NSLocalizedString("Reorder", comment: "")
            cell.bu2.setTitle(test, for: .normal)
            cell.bu1.setTitle(test2, for: .normal)


            cell.bu1.isHidden=false
            cell.bu2.isHidden=false
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

        return 252.0 + (CGFloat(sdata[indexPath.row].fuels?.count ?? 0) * 70)

    }
    
    
    
    
    
    
    
    
}
