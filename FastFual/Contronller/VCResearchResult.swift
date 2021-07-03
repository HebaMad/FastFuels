//
//  VCResearchResult.swift
//  FastFual
//
//  Created by macbook on 6/2/21.
//


import UIKit
import Alamofire
import ObjectMapper
import SDWebImage
import  SVProgressHUD
class VCResearchResult: UIViewController {
    var orderNum:[String]=[]
    var supplierId:Int=0
    @IBOutlet var emptyView: UIView!
    var rateVV:[Int]=[]

    var days:[String]=[]
    var fromTime:[String]=[]
    var toTime:[String]=[]
    var comment:[String]=[]
    var name:[String]=[]
    var imgUrl:[String]=[]
    var timess:[String]=[]
    @IBOutlet var backButton: UIButton!
    var trella:[Supplier_trella]=[]
    var trellaNameSize:[String]=[]
    var trellaId:[Int]=[]
    var  sdata:[searchData]=[]
    var workHour:[Working_hours]=[]
    var rateReview:[Rates]=[]

    @IBOutlet var searchBar: SearchView!

    @IBOutlet var displayTable: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        controlBackItem(backItem: backButton)
        emptyView.isHidden=true

        registerNib()
searchBar.startHandler {
        }
        searchBar.endEditingHandler {
            if (self.searchBar.txtSearch.text)?.count != 0{
                SVProgressHUD.show()
                SVProgressHUD.setBackgroundColor(.clear)
                self.search(searchText:self.searchBar.txtSearch.text!)
                self.filter(keyword:self.searchBar.txtSearch.text!)
                self.displayTable.reloadData()
            

            }else{
     
            }
            
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
        let nib = UINib(nibName: "CVCSaved", bundle: nil)
        displayTable.register(nib, forCellWithReuseIdentifier: "CVCSaved")
    }
    func filter(keyword : String) -> [searchData]{
        let result : [searchData] = sdata.filter({ (resl) -> Bool in
                                                    return  (resl.company_name?.lowercased() as AnyObject).contains(keyword.lowercased()) ?? false })
        return result
    }
    func controlBackItem(backItem: UIButton){
       if L102Language.currentAppleLanguage().elementsEqual("ar"){
        if let _img = backItem.imageView{
            backItem.setImage(UIImage(cgImage: (_img.image?.cgImage!)!, scale:_img.image!.scale , orientation: UIImage.Orientation.upMirrored), for: .normal)
            
           }
       }
   }


}
extension VCResearchResult:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sdata.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVCSaved", for: indexPath) as! CVCSaved
        cell.cover.sd_setImage(with:URL(string: sdata[indexPath.row].image ?? ""))
        cell.laName.text=sdata[indexPath.row].company_name ?? ""
        cell.laDistance.text="\(Int(sdata[indexPath.row].distance ?? 0.0))"
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
        UserDefaults.standard.set(rateVV, forKey: "rating")

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
        vc.typeNum=3
        vc.search=sdata[indexPath.row]
        vc.trella=trellaNameSize
        vc.trellaId=trellaId
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension VCResearchResult:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
   
        let vv =  collectionView.frame.width  - 20
        return CGSize(width: vv / 2.0 , height: 220.0)
}
}
extension VCResearchResult{
    
    
    private func search(searchText:String){
        
       
        let parameters: Parameters = [
            "text":searchText,
            "type" : 0
           
            ]

            
            Alamofire.request(API_KEYS.postsearch.url, method: .post, parameters:parameters,headers: ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token")!)","Accept-Language": UserDefaults.standard.string(forKey: "language") ?? "en"]).validate().responseJSON { [self] (response) in
                if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
              print(str)
                    if let parsedMapperString : search = Mapper<search>().map(JSONString:str){
                        if parsedMapperString.success == true{
                            sdata=parsedMapperString.data ?? []
                            displayTable.delegate=self
                            displayTable.dataSource=self
                            if sdata.count == 0 {
                                self.emptyView.isHidden = false
                            }else {
                                self.emptyView.isHidden = true

                            }
                            SVProgressHUD.dismiss()
                        }else{
                            showAlertMessage(title: "Error", message: parsedMapperString.message ?? "")
                        }
                        }
                        
                    }
          
            }
  

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
    
}

