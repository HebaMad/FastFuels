//
//  VCSP.swift
//  FastFual
//
//  Created by Basim on 4/5/21.
//

import UIKit
import SDWebImage
import Alamofire
import ObjectMapper
class VCSP: UIViewController {
    var id:Int=0
    var stationId:[Int]=[]
    var trella:[String]=[]
    var workhourr:[Working_hours]=[]
    var count:Int=0
    var totalH :Int=0
    var popBlocktrella:(([String])->Void)?
    var trellaId:[Int]=[]
    var filter:FilterData?

    @IBOutlet var calender: UIImageView!
    @IBOutlet var containerHeight: NSLayoutConstraint!
    @IBOutlet var fav: UIButton!{
        didSet {
            fav.addTarget(self, action: #selector(self.favPressed), for: .touchUpInside)
           } }
           @objc func favPressed() {
          if  fav.currentImage == UIImage(named: "save1"){
            fav.setImage(UIImage(named: "save2"), for: .normal)
            favourite(supplier_id: id, type: 1)

          }else{
            fav.setImage(UIImage(named: "save1"), for: .normal)
            favourite(supplier_id: id, type: 0)

          }
            
            
            
    }

    var typeNum:Int=0
    var favourite:Featured_providers?
    var nearaby:Nearby_providers?
    var search:searchData?
    var saves:MyFavoriteData?
    @IBOutlet var stationCover:UIImageView!
    @IBOutlet var laNumOfEvaluation: UILabel!
    @IBOutlet var laEvaluation: UILabel!
    @IBOutlet var stationPhoto:UIImageView!
    @IBOutlet var buBack: UIButton!{
        didSet {
            buBack.addTarget(self, action: #selector(self.buBackPressed), for: .touchUpInside)
           } }
           @objc func buBackPressed() {
            navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBOutlet var laStationLocation: UILabel!
    @IBOutlet var laStationName: UILabel!
    @IBOutlet var laLength: UILabel!
    @IBOutlet var laStatus: UILabel!
    @IBOutlet var buOrderNow: UIButton!{
        didSet {
            buOrderNow.addTarget(self, action: #selector(self.buOrderNowPressed), for: .touchUpInside)
           } }
           @objc func buOrderNowPressed() {
            if typeNum == 1{
                
                if ((favourite?.open?.elementsEqual("1")) != nil){
                    laStatus.text="open Now"
                    buOrderNow.isEnabled = true

                    let  vc =  VCBookOrder()
        //            navigationController?.pushViewController(vc, animated: true)
        //
                            vc.popBlocktrella = {
                                value in
                                if  value.first == "goCart"
                                {




                                    DispatchQueue.main.async
                                    {
                                        let vc = VCCart()
                                        self.navigationController?.pushViewController(vc, animated: true)


                                    }

                                }


                            }

                    vc.trellaId=trellaId
                    vc.trella=trella
                    let sheetController = SheetViewController(controller: vc , sizes: [SheetSize.fixed(700)])
                    sheetController.overlayColor = UIColor.black.withAlphaComponent(0.33)

                    sheetController.pullBarView.backgroundColor = .clear
                    sheetController.handleColor = UIColor.clear
                    sheetController.adjustForBottomSafeArea = true
                    sheetController.blurBottomSafeArea = false
                    sheetController.dismissOnBackgroundTap = true
                    sheetController.extendBackgroundBehindHandle = false
                    sheetController.topCornersRadius = 12.0


                    sheetController.willDismiss = { _ in


                    }
                    sheetController.didDismiss = { _ in




                    }
                    self.present(sheetController, animated: false, completion: nil)
                    
                }else{
                    laStatus.text="closed"
                    buOrderNow.isEnabled = false
                    buOrderNow.backgroundColor = UIColor(named: "Color12")
                }
                
                
                
                
                
            }else{
                if ((nearaby?.open?.elementsEqual("1")) != nil){
                    laStatus.text="open Now"
                    buOrderNow.isEnabled = true

                    let  vc =  VCBookOrder()
        //            navigationController?.pushViewController(vc, animated: true)
        //
                            vc.popBlocktrella = {
                                value in
                                if  value.first == "goCart"
                                {




                                    DispatchQueue.main.async
                                    {
                                        let vc = VCCart()
                                        self.navigationController?.pushViewController(vc, animated: true)


                                    }

                                }


                            }

                    vc.trellaId=trellaId
                    vc.trella=trella
                    let sheetController = SheetViewController(controller: vc , sizes: [SheetSize.fixed(700)])
                    sheetController.overlayColor = UIColor.black.withAlphaComponent(0.33)

                    sheetController.pullBarView.backgroundColor = .clear
                    sheetController.handleColor = UIColor.clear
                    sheetController.adjustForBottomSafeArea = true
                    sheetController.blurBottomSafeArea = false
                    sheetController.dismissOnBackgroundTap = true
                    sheetController.extendBackgroundBehindHandle = false
                    sheetController.topCornersRadius = 12.0


                    sheetController.willDismiss = { _ in


                    }
                    sheetController.didDismiss = { _ in




                    }
                    self.present(sheetController, animated: false, completion: nil)
                }else{
                    laStatus.text="closed"
                    buOrderNow.isEnabled = false
                    buOrderNow.backgroundColor = UIColor(named: "Color12")


                }
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
    override func viewDidLoad() {
        super.viewDidLoad()
        controlBackItem(backItem: buBack)

//        workhourr=(favourite?.working_hours)!
        count = UserDefaults.standard.stringArray(forKey: "comment")?.count ?? 5
totalH = (count*180)+(100)
        containerHeight.constant = CGFloat(totalH)


        if typeNum == 1{

            stationCover.sd_setImage(with:URL(string:(favourite?.image!)!))
            stationPhoto.sd_setImage(with:URL(string:(favourite?.logo!)!))
            laEvaluation.text="\(favourite?.rate ?? 0)"
            laNumOfEvaluation.text="(\(Int((favourite?.rate_count)!))+)"

            laStationName.text=favourite?.company_name
            laStationLocation.text=favourite?.address!
            laLength.text="\(Int((favourite?.distance_lat_lng ?? 0.0)!))"
            
            
            
            
            id=favourite?.id ?? 0
            if (favourite?.open == "1"){
                laStatus.text=NSLocalizedString("open Now", comment: "")
                buOrderNow.isEnabled = true

            }else{
                buOrderNow.isEnabled = false
                buOrderNow.backgroundColor = UIColor(named: "Color12")

                laStatus.text="closed"
                laStatus.textColor = UIColor(named: "Color7")
                calender.image=UIImage(named: "calendar2")

            }
            if favourite?.is_favourite == "1"{
                fav.setImage(UIImage(named: "save2"), for: .normal)
            }
            
        }else if typeNum == 2{
            stationCover.sd_setImage(with:URL(string:(nearaby?.image!)!))
            stationPhoto.sd_setImage(with:URL(string:(nearaby?.logo!)!))
            laEvaluation.text="\(nearaby?.rate ?? 0)"
            laNumOfEvaluation.text="(\(Int((nearaby?.rate_count)!))+)"

            laStationName.text=nearaby?.company_name
            laStationLocation.text=nearaby?.address!
            laLength.text="\(Int((nearaby?.distance_lat_lng!)!))"
            id=nearaby?.id ?? 0

            if (nearaby?.open == "1"){
                laStatus.text="open Now"

            }else{
                buOrderNow.isEnabled = false
                buOrderNow.backgroundColor = UIColor(named: "Color12")

                laStatus.text="closed"
                laStatus.textColor = UIColor(named: "Color7")
                calender.image=UIImage(named: "calendar2")


            }
            if nearaby?.is_favourite == "1"{
                fav.setImage(UIImage(named: "save2"), for: .normal)
            }
        }else if typeNum == 3{
            stationCover.sd_setImage(with:URL(string:(search?.image!)!))
            stationPhoto.sd_setImage(with:URL(string:(search?.logo!)!))
            laEvaluation.text="\(search?.rate ?? 0)"
            laNumOfEvaluation.text="(\(Int((search?.rate_count)!))+)"

            laStationName.text=search?.company_name
            laStationLocation.text=search?.address!
            laLength.text="\(Int((search?.distance_lat_lng!)!))"
            id=search?.id ?? 0

            if (search?.open == "1"){
                laStatus.text="open Now"

            }else{
                buOrderNow.isEnabled = false
                buOrderNow.backgroundColor = UIColor(named: "Color12")

                laStatus.text="closed"
                laStatus.textColor = UIColor(named: "Color7")
                calender.image=UIImage(named: "calendar2")


            }
            if search?.is_favourite == "1"{
                fav.setImage(UIImage(named: "save2"), for: .normal)
            }

        }else if typeNum == 4{
            stationCover.sd_setImage(with:URL(string:(filter?.image!)!))
            stationPhoto.sd_setImage(with:URL(string:(filter?.logo!)!))
            laEvaluation.text="\(filter?.rate ?? 0)"
            laNumOfEvaluation.text="(\(Int((filter?.rate_count)!))+)"

            laStationName.text=filter?.company_name
            laStationLocation.text=filter?.address!
            laLength.text="\(Int((filter?.distance_lat_lng!)!))"
            id=filter?.id ?? 0
            if (filter?.open == "1"){

                laStatus.text="open Now"

            }else{
                buOrderNow.isEnabled = false
                buOrderNow.backgroundColor = UIColor(named: "Color12")

                laStatus.text="closed"
                laStatus.textColor = UIColor(named: "Color7")
                calender.image=UIImage(named: "calendar2")


            }
            if filter?.is_favourite == "1"{
                fav.setImage(UIImage(named: "save2"), for: .normal)
            }
        }else{
            stationCover.sd_setImage(with:URL(string:(saves?.image!)!))
            stationPhoto.sd_setImage(with:URL(string:(saves?.logo!)!))
            laEvaluation.text="\(saves?.rate ?? 0)"
            laNumOfEvaluation.text="(\(Int((saves?.rate_count)!))+)"

            laStationName.text=saves?.company_name
            laStationLocation.text=saves?.address!
            laLength.text="\(Int((saves?.distance_lat_lng!)!))"
            id=saves?.id ?? 0

            if (saves?.open == "1"){
                laStatus.text="open Now"

            }else{
                buOrderNow.isEnabled = false
                buOrderNow.backgroundColor = UIColor(named: "Color12")

                laStatus.text="closed"
                laStatus.textColor = UIColor(named: "Color7")
                calender.image=UIImage(named: "calendar2")


            }
            if saves?.is_favourite == "1"{
                fav.setImage(UIImage(named: "save2"), for: .normal)
            }
        }

    }

}
extension VCSP{
    

    private func favourite(supplier_id:Int,type:Int){
        
    
        let parameters: Parameters = [
            "supplier_id":supplier_id,
            "type" : type
            ]

            
            Alamofire.request(API_KEYS.postFavorite.url, method: .post, parameters:parameters,headers: ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token")!)","Accept-Language": UserDefaults.standard.string(forKey: "language") ?? "en"]).validate().responseJSON { [self] (response) in
                if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
              print(str)
                    if let parsedMapperString : login = Mapper<login>().map(JSONString:str){
                        if parsedMapperString.success == true{
                            if type == 1{
                                self.showAlertMessage(title: "Fast Fuel", message: parsedMapperString.message ?? "")

                            }else{
                                self.showAlertMessage(title: "Fast Fuel", message: parsedMapperString.message ?? "")

                            }
                            
                        }
                        showAlertMessage(title: "ERROR", message: parsedMapperString.message ?? "")
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
