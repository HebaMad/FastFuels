//
//  VCTanks.swift
//  FastFual
//
//  Created by macbook on 5/30/21.
//

import UIKit
import Alamofire
import ObjectMapper
import SVProgressHUD
class VCTanks: UIViewController {
    @IBOutlet var backButton: UIButton!
    @IBOutlet var emptyView: UIView!

    var sdata:[TanksData]=[]
    @IBOutlet var displayTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emptyView.isHidden = true

        controlBackItem(backItem: backButton)
        SVProgressHUD.show()
        SVProgressHUD.setBackgroundColor(.clear)
        registerNib()
        getTank()

        // Do any additional setup after loading the view.
    }
    @IBAction func buBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func registerNib(){
        let nib = UINib(nibName: "CVCTanks", bundle: nil)
        displayTable.register(nib, forCellReuseIdentifier: "CVCTanks")
    }


}
extension VCTanks : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sdata.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CVCTanks", for: indexPath) as! CVCTanks
        cell.laPrice.text="\(sdata[indexPath.row].fuel_price ?? 0)" + " " + "SR"
        cell.laFuelType.text=sdata[indexPath.row].fuel_name ?? ""
        cell.laTankName.text=sdata[indexPath.row].name ?? ""


return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if #available(iOS 13.0, *) {
            let vc = UIStoryboard.mainStoryBoard.instantiateViewController(identifier: "VCSaleCalculator") as! VCSaleCalculator
            vc.id=sdata[indexPath.row].id ?? 0
            vc.tankName=sdata[indexPath.row].name ?? ""
            vc.tankPrice=sdata[indexPath.row].fuel_price ?? 0.0
            vc.tankFuel=sdata[indexPath.row].fuel_name ?? ""
            navigationController?.pushViewController(vc, animated: true)
        } else {
            // Fallback on earlier versions
        }


        
        
        
    }
    
    
}
extension VCTanks {
    private func getTank(){
        
       
        let parameters: Parameters = [:]

            
            Alamofire.request(API_KEYS.getTanks.url, method: .get, parameters:parameters,headers: ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token")!)","Accept-Language": UserDefaults.standard.string(forKey: "language") ?? "en"]).validate().responseJSON { [self] (response) in
                if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
              print(str)
                    if let parsedMapperString : Tanks = Mapper<Tanks>().map(JSONString:str){
                        if parsedMapperString.success == true{
                            sdata=parsedMapperString.data ?? []
                            displayTable.reloadData()
                            displayTable.delegate=self
                            displayTable.dataSource=self
                            SVProgressHUD.dismiss()
                            if sdata.count == 0 {
                                self.emptyView.isHidden = false
                            }else {
                                self.emptyView.isHidden = true

                            }
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
