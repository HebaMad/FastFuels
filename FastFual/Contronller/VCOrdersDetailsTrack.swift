//
//  VCOrdersDetailsTrack.swift
//  FastFual
//
//  Created by Basim on 5/7/21.
//

import UIKit
import Alamofire
import ObjectMapper
import SDWebImage
class VCOrdersDetailsTrack: UIViewController {
    
    @IBOutlet var trackImg: UIImageView!
    
    var sdata:[OrderProperty]=[]
var id=0
    @IBOutlet var trackAction: UIView!
    @IBOutlet var buBack: UIButton!{
        didSet {
            buBack.addTarget(self, action: #selector(self.buBackPressed), for: .touchUpInside)
           } }
           @objc func buBackPressed() {
    }
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var Date: UILabel!
    @IBOutlet var status: UILabel!
    @IBOutlet var laStationName: UILabel!

    @IBOutlet var laDistance: UILabel!
    
    @IBOutlet var statusOpen: UILabel!
    @IBOutlet var displayTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controlBackItem(backItem:trackImg)
        registerNib()
        orderDetailsTracks()
        displayTable.reloadData()
        controlBackItem(backItem: buBack)

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
        let nib = UINib(nibName: "CVCOrdersNew", bundle: nil)
        displayTable.register(nib, forCellReuseIdentifier: "CVCOrdersNew")
    }
}

extension VCOrdersDetailsTrack : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sdata.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CVCOrderDetailsTrack", for: indexPath) as! CVCOrderDetailsTrack
    
        if sdata[indexPath.row].status_number == 0{
            
            cell.status1.text=sdata[indexPath.row].status ?? ""
            cell.status2.text="order sent to service provider"
            cell.img.image=UIImage(named: "selectS")
            

        }else if sdata[indexPath.row].status_number == 1{
            cell.status1.text=sdata[indexPath.row].status ?? ""
            cell.status2.text="SP accept order now"
            cell.img.image=UIImage(named: "selectS")

            

        }else if sdata[indexPath.row].status_number == 2{
            cell.status1.text=sdata[indexPath.row].status ?? ""
            cell.status2.text="you pay sucessfully"
            cell.img.image=UIImage(named: "selectS")

        }else if sdata[indexPath.row].status_number == 3{
            cell.status1.text=sdata[indexPath.row].status ?? ""
            cell.status2.text="agent now on way"
            cell.img.image=UIImage(named: "selectS")


        }else if sdata[indexPath.row].status_number == 4{
            cell.status1.text=sdata[indexPath.row].status ?? ""
            cell.status2.text="order delivered to you"
            cell.img.image=UIImage(named: "selectS")

        }else {
          


        }
        
        
return cell
    }
    
    
}
extension VCOrdersDetailsTrack{
    func controlBackItem(backItem: UIImageView){
       if L102Language.currentAppleLanguage().elementsEqual("ar"){
           if let _img = backItem.image {
               backItem.image =  UIImage(cgImage: _img.cgImage!, scale:_img.scale , orientation: UIImage.Orientation.upMirrored)
           }
       }
   }

    private func orderDetailsTracks(){
        let  orderDetailsTrack = API_KEYS.getOrderStatus.withId(id:id )

        Alamofire.request(orderDetailsTrack, method: .get, parameters:nil,headers: ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token")!)","Accept-Language": UserDefaults.standard.string(forKey: "language") ?? "en"]).validate().responseJSON { [self] (response) in
            if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
                print(str)
   if let parsedMapperString : OrderStatus = Mapper<OrderStatus>().map(JSONString:str){
                    if parsedMapperString.success == true{
                        sdata=parsedMapperString.data?.order_status ?? []
                        profileImage.sd_setImage(with:URL(string: parsedMapperString.data?.supplier?.logo ?? ""))
                        laStationName.text=parsedMapperString.data?.supplier?.company_name ?? ""
                        laDistance.text="\(parsedMapperString.data?.supplier?.distance_lat_lng ?? 0.0)"
                        if parsedMapperString.data?.supplier?.open == "1"{
                            statusOpen.text = "open Now"

                        }else{
                            statusOpen.text = "closed Now"

                        }
                        displayTable.delegate=self
                        displayTable.dataSource=self

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

