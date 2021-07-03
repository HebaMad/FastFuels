//
//  VCSaved.swift
//  FastFual
//
//  Created by Basim on 4/5/21.
//

import UIKit
import Alamofire
import ObjectMapper
import SVProgressHUD
class VCSaved: UIViewController {
    @IBOutlet var emptyView: UIView!
    var rateVV:[Int]=[]

    var orderNum:[String]=[]
    var supplierId:Int=0
    var workHour:[Working_hours]=[]
    var rateReview:[Rates]=[]
    var days:[String]=[]
    var fromTime:[String]=[]
    var toTime:[String]=[]
    var comment:[String]=[]
    var name:[String]=[]
    var imgUrl:[String]=[]
    var timess:[String]=[]
    var trella:[Supplier_trella]=[]
    var trellaNameSize:[String]=[]
    var trellaId:[Int]=[]
    @IBOutlet var icon: UIImageView!
    var sdata:[MyFavoriteData]=[]
    @IBOutlet var displayTable: UICollectionView!
    @IBOutlet var laGaz: UILabel!
    var fuel:[Fuels]=[]
    var showPrices:String=""
    var year=0
    var month=0
    @IBOutlet var fuelResult: UILabel!
    @IBAction func buNotifier(_ sender: Any) {
        let vc = VCNotifications()
                navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func gazPrice(_ sender: Any) {
        let vc = VCGasPrices()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBOutlet var unCountNum: UILabel!
    
    @IBOutlet var unCountView: UIView!
    @IBAction func buMap(_ sender: Any) {
        let vc=VCMapKitMaker()
        navigationController?.pushViewController(vc, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()
        SVProgressHUD.setBackgroundColor(.clear)
        emptyView.isHidden=true

        trella=[]
        rateReview=[]
        workHour=[]

        controlBackItem(backItem: icon)
        
        registerNib()
        favoriteReq()
        displayTable.reloadData()
    
    }
    func trell(){
        
        if sdata.count != 0 {
            for index in 0 ... sdata.count-1{
                trella.append(sdata[index].supplier_trella ?? [])
                rateReview.append(sdata[index].rates ?? [])
                workHour.append(sdata[index].working_hours ?? [])
            }
        }
      
    }
    func controlBackItem(backItem: UIImageView){
       if L102Language.currentAppleLanguage().elementsEqual("ar"){
           if let _img = backItem.image {
               backItem.image =  UIImage(cgImage: _img.cgImage!, scale:_img.scale , orientation: UIImage.Orientation.upMirrored)
           }
       }
   }
    
    @IBAction func buSearch(_ sender: Any) {
                let vc=VCResearchResult()
        
                self.navigationController?.pushViewController(vc, animated: true)
                self.view.endEditing(true)
    }

    func registerNib(){
        let nib = UINib(nibName: "CVCSaved", bundle: nil)
        displayTable.register(nib, forCellWithReuseIdentifier: "CVCSaved")
    }

    @IBAction func buMyLocation(_ sender: Any) {
    }
    
    
    @IBAction func buGazType(_ sender: Any) {
        
    }
}
extension VCSaved:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sdata.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVCSaved", for: indexPath) as! CVCSaved

        cell.cover.sd_setImage(with:URL(string: sdata[indexPath.row].image ?? ""))
        cell.laName.text=sdata[indexPath.row].company_name ?? ""
        cell.laDistance.text="\(Int(sdata[indexPath.row].distance_lat_lng ?? 0.0))"
        if (sdata[indexPath.row].open == "1"){
            cell.laStatus.text="open Now"

        }else{
            cell.laStatus.text="closed"
            cell.laStatus.textColor = UIColor(named: "Color7")
            cell.calender.image=UIImage(named: "calendar2")
        }
        cell.laNum.text="\(sdata[indexPath.row].rate_count ?? 0)"
        cell.laEvaluation.text="\(sdata[indexPath.row].rate ?? 0)"

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
        
        UserDefaults.standard.set(sdata[indexPath.row].rate_value, forKey: "preview")
        UserDefaults.standard.setValue(sdata[indexPath.row].rate_count, forKey: "COUNT")
        UserDefaults.standard.setValue(sdata[indexPath.row].rate, forKey: "NUM")
        UserDefaults.standard.set(days, forKey: "days")
        UserDefaults.standard.set(fromTime, forKey: "from")
        UserDefaults.standard.set(toTime, forKey: "to")
        UserDefaults.standard.set(comment, forKey: "comment")
        UserDefaults.standard.set(imgUrl, forKey: "imgUrl")
        UserDefaults.standard.set(timess, forKey: "time")
        UserDefaults.standard.set(name, forKey: "name")
        UserDefaults.standard.set(orderNum, forKey: "orderNum")
        UserDefaults.standard.set(trellaNameSize, forKey: "trellaName")

        supplierId =  sdata[indexPath.row].supplier_trella?.first?.supplier_id ?? 0
        UserDefaults.standard.set(sdata[indexPath.row].company_mobile, forKey: "mobile")
        UserDefaults.standard.set(sdata[indexPath.row].email, forKey: "email")
        UserDefaults.standard.set(supplierId, forKey: "supplierId")
        UserDefaults.standard.set(trellaId, forKey: "trellaId")
        UserDefaults.standard.set(rateVV, forKey: "rating")

        vc.typeNum=5
        vc.saves=sdata[indexPath.row]
        vc.trella=trellaNameSize
        vc.trellaId=trellaId
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}
extension VCSaved:UICollectionViewDelegateFlowLayout{
    
   
    
    
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
extension VCSaved {
    private func favoriteReq(){
        
       
        let parameters: Parameters = [:]

            
            Alamofire.request(API_KEYS.getMyFavorite.url, method: .get, parameters:parameters,headers: ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token")!)","Accept-Language": UserDefaults.standard.string(forKey: "Langugee") ?? "en"]).validate().responseJSON { [self] (response) in
                if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
              print(str)
                    if let parsedMapperString : MyFavorite = Mapper<MyFavorite>().map(JSONString:str){
                        if parsedMapperString.success == true{
                            sdata=parsedMapperString.data ?? []
                            print(sdata.count)
                            SVProgressHUD.dismiss()
                            displayTable.delegate=self
                            displayTable.dataSource=self
                            if sdata.count == 0 {
                                self.emptyView.isHidden = false
                            }else {
                                self.emptyView.isHidden = true

                            }
                            date()
                            profile()
                            trell()

                        }else{
                            showAlertMessage(title: "Error", message: parsedMapperString.message ?? "")

                        }
                        }
                        
                    }
          
            }
  

    }
    private func gazPrice(month:Int,year:Int){
        
        
        let parameters: Parameters = [
            "month" : month,
            "year":year]
        
        Alamofire.request(API_KEYS.get_prices.url, method: .post, parameters:parameters,headers: ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token")!)","Accept-Language": UserDefaults.standard.string(forKey: "Langugee") ?? "en"]).validate().responseJSON { [self] (response) in
            if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
              
                if let parsedMapperString : getPrice = Mapper<getPrice>().map(JSONString:str){
                    if parsedMapperString.success == true{
                        
                   
                    fuel=(parsedMapperString.data?.fuels)!
                    showPrice()
                    }else{
                        showAlertMessage(title: "Error", message: parsedMapperString.message ?? "")

                    }
                }
                
            }}}
    
    
    func showPrice(){
        if fuel.count != 0 {
            for index in 0 ... fuel.count-1{
                showPrices += "\(fuel[index].name ?? "") \(fuel[index].price ?? 0.0) " + "||"
            }
            fuelResult.text=showPrices
        }
   
    }
    func date(){
        let date = Date()

        let calendar = Calendar.current
        year = calendar.component(.year, from: date)
        month = calendar.component(.month, from: date)
        gazPrice(month: month, year: year)

    }
    private func profile(){
        
        Alamofire.request(API_KEYS.getProfile.url, method: .get, parameters:nil,headers: ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token")!)","Accept-Language": UserDefaults.standard.string(forKey: "language") ?? "en"]).validate().responseJSON { [self] (response) in
            if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
              
                if let parsedMapperString : Profile = Mapper<Profile>().map(JSONString:str){
                    if parsedMapperString .success == true{
                        
                    
                    if parsedMapperString.data?.un_reade_notification_count != 0{
                        unCountView.isHidden=false
                   unCountNum.text = "\(parsedMapperString.data?.un_reade_notification_count ?? 0)"

                    }else{
                        unCountView.isHidden=true
                    }
                    }else{
                        showAlertMessage(title: "Error", message: parsedMapperString.message ?? "")

                    }
                }
            }}}
}


