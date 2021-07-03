//
//  VCFilterResults.swift
//  FastFual
//
//  Created by macbook on 5/25/21.
//

import UIKit

import Alamofire
import ObjectMapper
import SVProgressHUD
class VCFilterResults: UIViewController {
    
    @IBAction func buF(_ sender: Any) {
        showFilter()

    }
    var parameters: Parameters = [:]
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
    @IBOutlet var emptyView: UIView!

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
    private let itemsPerRow: CGFloat = 2
        private let sectionInsets = UIEdgeInsets(
          top: 0,
          left: 10,
          bottom: 0,
          right: 10)
    
    var sdata:[FilterData]=[]
    
    @IBOutlet var displayTable: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()
        print(sdata)
        print(sdata.count)
        if sdata.count == 0 {
            self.emptyView.isHidden = false
        }else {
            self.emptyView.isHidden = true

        }
        trella=[]
        rateReview=[]
        workHour=[]
        controlBackItem(backItem: backButton)
        trell()

        registerNib()
        displayTable.delegate=self
        displayTable.dataSource=self
        SVProgressHUD.dismiss()
        displayTable.reloadData()

print(sdata)

    }
    func controlBackItem(backItem: UIButton){
       if L102Language.currentAppleLanguage().elementsEqual("ar"){
        if let _img = backItem.imageView{
            backItem.setImage(UIImage(cgImage: (_img.image?.cgImage!)!, scale:_img.image!.scale , orientation: UIImage.Orientation.upMirrored), for: .normal)
            
           }
       }
   }
    
    @IBAction func buBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    func registerNib(){
        let nib = UINib(nibName: "CVCSaved", bundle: nil)
        displayTable.register(nib, forCellWithReuseIdentifier: "CVCSaved")
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
extension VCFilterResults:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(sdata.count)
        return sdata.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVCSaved", for: indexPath) as! CVCSaved
        cell.cover.sd_setImage(with:URL(string: sdata[indexPath.row].image ?? ""))
        cell.laName.text=sdata[indexPath.row].company_name!
        cell.laDistance.text="\(Int(sdata[indexPath.row].distance_lat_lng ?? 0.0))" + "km"
        if (sdata[indexPath.row].open == "1"){
            cell.laStatus.text="open Now"

        }else{
            cell.laStatus.text="closed"
            cell.laStatus.textColor = UIColor(named: "Color7")
            cell.calender.image=UIImage(named: "calendar2")

        }
        cell.laNum.text="\(sdata[indexPath.row].rate_count!)"
        cell.laEvaluation.text="\(sdata[indexPath.row].rate!)"

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
        }
        }
        if trella.count != 0 {
            
        
        for ind in 0 ... trella.count-1{
            trellaNameSize.append(trella[ind].size! + " " + trella[ind].name!)
            trellaId.append(trella[ind].trella_id ?? 0)
        }
        }
        
        
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
        vc.typeNum=4
        vc.filter=sdata[indexPath.row]
        vc.trella=trellaNameSize
        vc.trellaId=trellaId
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
}
extension VCFilterResults:UICollectionViewDelegateFlowLayout{
    
        
       
        
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

            let vv =  collectionView.frame.width  - 10.0
            return CGSize(width: vv / 2.0 , height: 220.0)
           
        }
        
//        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//            
//           
//                return 0
//           
//            
//        }
//        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//            
//       
//                return 0
//           
//            
//        }
        
        
}


extension VCFilterResults{
    func showFilter()  {
        let  viewController =  VCFilter()

                viewController.popBlock = {
                    value in
                    if  value.first == "goToFilterList"
                    {

                        DispatchQueue.main.async
                        {
                            SVProgressHUD.show()
                            SVProgressHUD.setBackgroundColor(.clear)
                            self.filtering(lat: Double(value[3])!, lag: Double(value[4])!, filter:  (value[2]))


                        }

                    }

                    print("Hi basem \(value)")

                }
        //

        let sheetController = SheetViewController(controller: viewController , sizes: [SheetSize.fixed(440)])
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
    private func filtering(lat:Double,lag:Double,filter:String){
        if filter.elementsEqual("Most Ordered"){
            parameters = [
                "lat":lat,
                "lng" : lag,
                "mostOrdered" : 1
                ]
        }else if filter.elementsEqual("Near by") {
           parameters=[
                "lat":lat,
                "lng" : lag,
                "nearBy" : 1
                ]
        }else{
        parameters=[
                "lat":lat,
                "lng" : lag,
                "openingNow" : 1
                ]
        }



            Alamofire.request(API_KEYS.postSuppliers.url, method: .post, parameters:parameters,headers: ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token")!)"]).validate().responseJSON { [self] (response) in
                if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
              print(str)
                    if let parsedMapperString : Filter = Mapper<Filter>().map(JSONString:str){
                        if parsedMapperString.success == true{
                            sdata = parsedMapperString.data ?? []
                            print(sdata.count)
                            SVProgressHUD.dismiss()
                            displayTable.delegate=self
                            displayTable.dataSource=self
                            displayTable.reloadData()
                        }
                        }

                    }

            }


    }
}
