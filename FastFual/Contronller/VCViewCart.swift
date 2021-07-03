//
//  VCViewCart.swift
//  FastFual
//
//  Created by macbook on 6/2/21.
//

import UIKit
import Alamofire
import ObjectMapper
class VCViewCart: UIViewController {
    var nearbyProviderId:[Int]=[]
    var featuredProviderId:[Int]=[]
    var rateVV:[Int]=[]

    var orderNum:[String]=[]
    var supplierId:Int=0
    var workHour:[Working_hours]=[]
    var rateReview:[Ratess]=[]
    var days:[String]=[]
    var fromTime:[String]=[]
    var toTime:[String]=[]
    var comment:[String]=[]
    var name:[String]=[]
    var imgUrl:[String]=[]
    var timess:[String]=[]
    var trella:[Supplier_trellaa]=[]
    var trellaNameSize:[String]=[]
    var trellaId:[Int]=[]
    @IBOutlet var backButton: UIButton!

    @IBOutlet var displayTable: UICollectionView!
    var titleS=""
    @IBOutlet var supplierTitle: UILabel!
    var favourite:[Featured_providers]=[]
    
    var nearaby:[Nearby_providers]=[]
    var id=0
    override func viewDidLoad() {
        super.viewDidLoad()
        controlBackItem(backItem: backButton)
        idprovide()
        supplierTitle.text=titleS
        registerNib()
        displayTable.delegate=self
        displayTable.dataSource=self
        displayTable.reloadData()

    }
    func idprovide (){
        featuredProviderId=[]
        nearbyProviderId=[]
        if id == 1 {
            if favourite.count != 0 {
                for index in 0 ... ((favourite.count)-1){
                    featuredProviderId.append((favourite[index].id)!)
                    
                }
            }
            
         
         
        }else{
            if nearaby.count != 0 {

            for indexx in 0 ... ((nearaby.count)-1){
                nearbyProviderId.append((nearaby[indexx].id)!)


            }
        }
        }
    }

    func registerNib(){
        let nib = UINib(nibName: "CVCSaved", bundle: nil)
        displayTable.register(nib, forCellWithReuseIdentifier: "CVCSaved")
    }
    


    @IBAction func back(_ sender: Any) {
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
    func controlBackItem(backItem: UIButton){
       if L102Language.currentAppleLanguage().elementsEqual("ar"){
        if let _img = backItem.imageView{
            backItem.setImage(UIImage(cgImage: (_img.image?.cgImage!)!, scale:_img.image!.scale , orientation: UIImage.Orientation.upMirrored), for: .normal)
            
           }
       }
   }
}

extension VCViewCart:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if id == 1{
            return favourite.count

        }else{
            return nearaby.count

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVCSaved", for: indexPath) as! CVCSaved
        if id == 1{

        cell.cover.sd_setImage(with:URL(string: favourite[indexPath.row].image ?? ""))
        cell.laName.text=favourite[indexPath.row].company_name ?? ""
        cell.laDistance.text="\(Int(favourite[indexPath.row].distance ?? 0.0))"
        if (favourite[indexPath.row].open == "1"){
            cell.laStatus.text="open Now"

        }else{
            cell.laStatus.text="closed"
            cell.laStatus.textColor = UIColor(named: "Color7")
            cell.calender.image=UIImage(named: "calendar2")
        }
        cell.laNum.text="\(favourite[indexPath.row].rate_count ?? 0)"
        cell.laEvaluation.text="\(favourite[indexPath.row].rate ?? 0)"
        }else{
            cell.cover.sd_setImage(with:URL(string: nearaby[indexPath.row].image ?? ""))
            cell.laName.text=nearaby[indexPath.row].company_name ?? ""
            cell.laDistance.text="\(Int(nearaby[indexPath.row].distance ?? 0.0))"
            if (nearaby[indexPath.row].open == "1"){
                cell.laStatus.text="open Now"

            }else{
                cell.laStatus.text="closed"
                cell.laStatus.textColor = UIColor(named: "Color7")
                cell.calender.image=UIImage(named: "calendar2")
            }
            cell.laNum.text="\(nearaby[indexPath.row].rate_count ?? 0)"
            cell.laEvaluation.text="\(nearaby[indexPath.row].rate ?? 0)"
        }
            return cell
}
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc=UIStoryboard.mainStoryBoard.instantiateViewController(withIdentifier: "VCSP") as! VCSP

        comment=[]
        imgUrl=[]
        timess=[]
        name=[]
        orderNum=[]
        days=[]
        fromTime=[]
        toTime=[]
        trellaId=[]
        trellaNameSize=[]
        rateVV=[]

        
        
        if id == 1{
        vc.favourite=favourite[indexPath.row]
        rateReview=favourite[indexPath.row].rates ?? []
        workHour=favourite[indexPath.row].working_hours ?? []
        trella=favourite[indexPath.row].supplier_trella ?? []
        if workHour.count != 0 {

        for index in 0 ... workHour.count-1 {
            days.append(workHour[index].day ?? "")
            fromTime.append(workHour[index].from_hours ?? "")
            toTime.append(workHour[index].to_hours ?? "")
        }
        }
        if rateReview.count != 0 {

        for indexx in 0 ... rateReview.count-1{
            comment.append(rateReview[indexx].text ?? "")
            imgUrl.append(rateReview[indexx].image_user ?? "")
            timess.append(rateReview[indexx].created_at ?? "")
            name.append(rateReview[indexx].user_name ?? "")
            orderNum.append(rateReview[indexx].order_number ?? "")
            rateVV.append(rateReview[indexx].rate ?? 0)

        }
        }
        if trella.count != 0 {
            
        
        for ind in 0 ... trella.count-1{
            trellaNameSize.append(trella[ind].size! + " " + trella[ind].name!)
            trellaId.append(trella[ind].trella_id ?? 0)
        }
        }
     
            vc.typeNum=1
            vc.stationId=featuredProviderId
            vc.trella=trellaNameSize
            vc.trellaId=trellaId
            supplierId =  favourite[indexPath.row].supplier_trella?.first?.supplier_id ?? 0
            UserDefaults.standard.set(rateVV, forKey: "rating")

            UserDefaults.standard.set(favourite[indexPath.row].rate_value, forKey: "preview")
            UserDefaults.standard.setValue(favourite[indexPath.row].rate_count, forKey: "COUNT")
            UserDefaults.standard.setValue(favourite[indexPath.row].rate, forKey: "NUM")
            UserDefaults.standard.set(favourite[indexPath.row].company_mobile, forKey: "mobile")
            UserDefaults.standard.set(favourite[indexPath.row].email, forKey: "email")
        }else{
            
            vc.nearaby=nearaby[indexPath.row]
            rateReview=nearaby[indexPath.row].rates ?? []
            workHour=nearaby[indexPath.row].working_hours ?? []
            trella=nearaby[indexPath.row].supplier_trella ?? []

              supplierId = trella[indexPath.row].supplier_id ?? 0
            
            if workHour.count != 0 {

            for index in 0 ... workHour.count-1 {
                days.append(workHour[index].day ?? "")
                fromTime.append(workHour[index].from_hours ?? "")
                toTime.append(workHour[index].to_hours ?? "")
            }
            }
            if rateReview.count != 0 {

            for indexx in 0 ... rateReview.count-1{
                comment.append(rateReview[indexx].text ?? "")
                imgUrl.append(rateReview[indexx].image_user ?? "")
                timess.append(rateReview[indexx].created_at ?? "")
                name.append(rateReview[indexx].user_name ?? "")
                orderNum.append(rateReview[indexx].order_number ?? "")
                rateVV.append(rateReview[indexx].rate ?? 0)

            }
            }
            if trella.count != 0 {
                
            
            for ind in 0 ... trella.count-1{
                trellaNameSize.append(trella[ind].size! + " " + trella[ind].name!)
                trellaId.append(trella[ind].trella_id ?? 0)
            }
            }
            
            
            supplierId =  nearaby[indexPath.row].supplier_trella?.first?.supplier_id ?? 0
            UserDefaults.standard.set(rateVV, forKey: "rating")

            UserDefaults.standard.set(nearaby[indexPath.row].rate_value, forKey: "preview")
            UserDefaults.standard.setValue(nearaby[indexPath.row].rate_count, forKey: "COUNT")
            UserDefaults.standard.setValue(nearaby[indexPath.row].rate, forKey: "NUM")
            UserDefaults.standard.set(nearaby[indexPath.row].company_mobile, forKey: "mobile")
            UserDefaults.standard.set(nearaby[indexPath.row].email, forKey: "email")
            vc.typeNum=2
            vc.stationId=nearbyProviderId
            vc.trella=trellaNameSize
            vc.trellaId=trellaId

        }
        
        UserDefaults.standard.set(supplierId, forKey: "supplierId")
        UserDefaults.standard.set(trellaId, forKey: "trellaId")
        UserDefaults.standard.set(days, forKey: "days")
        UserDefaults.standard.set(fromTime, forKey: "from")
        UserDefaults.standard.set(toTime, forKey: "to")
        UserDefaults.standard.set(comment, forKey: "comment")
        UserDefaults.standard.set(imgUrl, forKey: "imgUrl")
        UserDefaults.standard.set(timess, forKey: "time")
        UserDefaults.standard.set(name, forKey: "name")
        UserDefaults.standard.set(orderNum, forKey: "orderNum")
        UserDefaults.standard.set(trellaNameSize, forKey: "trellaName")
        navigationController?.pushViewController(vc, animated: true)

        navigationController?.pushViewController(vc, animated: true)

            
    }
    
    
}
extension VCViewCart:UICollectionViewDelegateFlowLayout{
    
   
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
      
            
        let vv =  collectionView.frame.width  - 10.0
        return CGSize(width: vv / 2.0 , height: 220.0)
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
       
            return 0
       
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
   
            return 0
       
        
    }
    
    
}
