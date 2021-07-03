//
//  VCNotifications.swift
//  FastFual
//
//  Created by Basim on 5/10/21.
//

import UIKit
import Alamofire
import ObjectMapper
class VCNotifications: UIViewController {
    var sdata:[ NotifierData]=[]


    
     @IBOutlet weak var buBack: UIButton!
            { didSet {
                buBack.addTarget(self, action: #selector(self.buBackPressed), for: .touchUpInside)
            }        }
      
        @objc func buBackPressed() {
            self.navigationController?.popViewController(animated: true)
        }

    @IBOutlet var displayTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()
        getNotifier()
        controlBackItem(backItem: buBack)

    }

    func registerNib(){
        let nib = UINib(nibName: "CVCNotifications", bundle: nil)
        displayTable.register(nib, forCellReuseIdentifier: "CVCNotifications")
    }

     @IBAction func buBack(_ sender: Any) {
         navigationController?.popViewController(animated: true)
     }
    
    
     override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            self.tabBarController?.tabBar.isHidden = false

        }

        override func viewWillAppear(_ animated: Bool) {
                    super.viewWillAppear(animated)
            self.tabBarController?.tabBar.isHidden = true

        }

 
}

 extension VCNotifications : UITableViewDataSource,UITableViewDelegate{
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return sdata.count
         
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "CVCNotifications", for: indexPath) as! CVCNotifications
       print(sdata[indexPath.row].order_number)
        if ("\(sdata[indexPath.row].order_number)" != "" && sdata[indexPath.row].order_number != nil ){
//        if ("\(sdata[indexPath.row].order_number)".count != 0){

            cell.orderNum.text =  "OR#" + "\(sdata[indexPath.row].order_number ?? 0)"

        }else{
            
        }
        cell.orderTime.text=sdata[indexPath.row].diff ?? ""
        cell.tiltle.text=sdata[indexPath.row].title ?? ""
        cell.body.text =  sdata[indexPath.row].data! ?? ""


 return cell
     }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if sdata[indexPath.row].read_at == 0{
        
            readNotification(id: sdata[indexPath.row].id ?? 0)
        }else{
      


        }
        if "\(sdata[indexPath.row].order_number)" != "" && sdata[indexPath.row].order_number != nil {
            let vc=VCOrderDetails()
            vc.id=sdata[indexPath.row].order_id ?? 0
            navigationController?.pushViewController(vc, animated: true)
        }else{
        
        }
    }

     
     
 }

 extension VCNotifications {
     private func getNotifier(){
         
        
         let parameters: Parameters = [:]

             
             Alamofire.request(API_KEYS.getNotification.url, method: .get, parameters:parameters,headers: ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token")!)","Accept-Language": UserDefaults.standard.string(forKey: "language") ?? "en"]).validate().responseJSON { [self] (response) in
                 if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
               print(str)
                     if let parsedMapperString : Notifier = Mapper<Notifier>().map(JSONString:str){
                         if parsedMapperString.success == true{
                             sdata=parsedMapperString.data ?? []
                             displayTable.reloadData()
                             displayTable.delegate=self
                             displayTable.dataSource=self
                         }else{
                            showAlertMessage(title: "Error", message: parsedMapperString.message ?? "")

                         }
                         }
                         
                     }
           
             }
   

     }
    private func readNotification(id:Int){
        
       
        let  readNotificaion = API_KEYS.getorder_details.withId(id:id )

            
            Alamofire.request(readNotificaion, method: .get, parameters:nil,headers: ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token")!)","Accept-Language": UserDefaults.standard.string(forKey: "Langugee") ?? "en"]).validate().responseJSON { [self] (response) in
                if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
              print(str)
                    if let parsedMapperString : Notifier = Mapper<Notifier>().map(JSONString:str){
                        if parsedMapperString.success == true{
                  
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
