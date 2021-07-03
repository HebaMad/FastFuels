//
//  VCHomeStation.swift
//  FastFual
//
//  Created by Basim on 1/16/21.
//

import UIKit
import FSPagerView
import Alamofire
import ObjectMapper
import SVProgressHUD
import SDWebImage
import MapKit
import GoogleMaps
import CoreLocation
class VCHomeStation: UIViewController, CLLocationManagerDelegate  {
    var supplierId:Int=0
    var rateVV:[Int] = []
    @IBOutlet var icon2: UIImageView!
    @IBOutlet var icon: UIImageView!
    @IBAction func mapAction(_ sender: Any) {
        let vc=VCMapLoc()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func buNotification(_ sender: Any) {
        let vc = VCNotifications()
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBOutlet var unCountNum: UILabel!
    
    @IBOutlet var unCountView: UIView!
    var loc:Bool=false
    var centerMapCoordinate:CLLocationCoordinate2D!
    var showPrices:String=""
    var fuel:[Fuels]=[]
private let locationManager = CLLocationManager()
var marker: GMSMarker!
var countryCode:String=""
var country:String=""
var address:String=""
    var userLat = 0.0
    var userLng = 0.0
    var year=0
    var month=0
    var featuredProviderId:[Int]=[]
    var nearbyProviderId:[Int]=[]
    var workHour:[Working_hours]=[]
    var workHournearaby:[String]=[]
    var trella:[Supplier_trellaa]=[]
    var trellaNameSize:[String]=[]
    var trellaId:[Int]=[]
var addressMap = ""

    var trellanearaby:[String]=[]
    var trellaName:String=""
    var days:[String]=[]
    var fromTime:[String]=[]
    var toTime:[String]=[]
    var comment:[String]=[]
    var name:[String]=[]
    var imgUrl:[String]=[]
    var time:[String]=[]
    var rateReview:[Ratess]=[]
    var orderNum:[String]=[]


    @IBAction func buMap(_ sender: Any) {
        let vc=VCMapKitMaker()
        navigationController?.pushViewController(vc, animated: true)
    }
    var parameters: Parameters = [:]

    var favourite:[Featured_providers]=[]
    
    var nearaby:[Nearby_providers]=[]
    @IBOutlet var searchBar: SearchView!

    
    @IBOutlet var laAddress: UILabel!
    @IBOutlet weak var collectionViewMe1: UICollectionView!
    @IBOutlet weak var collectionViewMe2: UICollectionView!
    var  slideData:[SliderData]?
    var img:[Data]=[]
    var url:[String]=[]
    
    @IBOutlet var fuelResult: UILabel!
    
    @IBAction func gazPrice(_ sender: Any) {
        let vc = VCGasPrices()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBOutlet var pagerViews: FSPagerView!{
        didSet {

            self.pagerViews.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.pagerViews.itemSize = FSPagerView.automaticSize
        }
        
    }
    
    @IBOutlet var pagerControls: FSPageControl!{
        didSet {
            self.pagerControls.numberOfPages = img.count
            self.pagerControls.contentHorizontalAlignment = .center
        }
    }
    
    // new 

    @IBAction func filterPreesed(_ sender: Any) {
        self.showFilter()
    }
    
    func showFilter()  {
        let  viewController =  VCFilter()
        
                viewController.popBlock = {
                    value in
                    if  value.first == "goToFilterList"
                    {
        
        
                        
                        let index =  (value[1])
        
                        print ((value[0]))
                        print ((value[1]))
                        print ((value[2]))
                        print ((value[3]))
                        print ((value[4]))
                        
                        DispatchQueue.main.async
                        {
                            self.filtering(lat: self.userLat, lag: self.userLng, filter:  (value[2]))

                            
                        }
        
                    }
        
                    print("Hi basem \(value)")
        
                }
        //
        
        let sheetController = SheetViewController(controller: viewController , sizes: [SheetSize.fixed(460)])
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
    

    
    @IBOutlet weak var viewLocation: UIView!
    {
        didSet {
            viewLocation.addGestureRecognizer( UITapGestureRecognizer(target: self, action: #selector(self.viewLocationPreseed)))
            viewLocation.isUserInteractionEnabled = true
        }
    }
    @objc func viewLocationPreseed(_ sender: UITapGestureRecognizer) {
        
        //
        //        let vc = VCMyLocation()
        //        vc.comeFromHomeToShowListLocation = true
        //        self.navigationController?.pushViewController(vc, animated: true)
        //
    }
    @objc func myTargetFunction(textField: UITextField) {

        let vc=VCResearchResult()

        self.navigationController?.pushViewController(vc, animated: true)
        self.view.endEditing(true)
        
    }
    
    @IBAction func viewAllFeatured(_ sender: Any) {
        let vc=VCViewCart()
        vc.favourite=favourite
        vc.id=1
        vc.titleS="Featured Suppliers"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func viewAllNearby(_ sender: Any) {
        let vc=VCViewCart()
        vc.nearaby=nearaby
        vc.id=2
        vc.titleS = "Nearaby Suppliers"
        navigationController?.pushViewController(vc, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        unCountView.isHidden=true

        controlBackItem(backItem: icon)
        controlBackItem(backItem: icon2)

        loc = UserDefaults.standard.bool(forKey: "loc")
        self.getSetting()
        date()
        if loc == false{
//            self.searchBar.txtSearch.addTarget(self, action: #selector(myTargetFunction), for: .editingDidBegin)

            locationManager.delegate = self

            locationManager.requestWhenInUseAuthorization()

  //             locationManager.desiredAccuracy = kCLLocationAccuracyBest
               locationManager.startUpdatingLocation()

            guard let locValue = CLLocationManager.init().location?.coordinate  else { return }
            print("locations = \(locValue.latitude) \(locValue.latitude)")
          userLat=locValue.latitude
          userLng=locValue.longitude
            getAddressFromLatLon(pdblLatitude:"\(userLat)", withLongitude: "\(userLng)")

        }else{
//            self.searchBar.txtSearch.addTarget(self, action: #selector(myTargetFunction), for: .editingDidBegin)

            userLat=UserDefaults.standard.double(forKey: "latitude")
            userLng=UserDefaults.standard.double(forKey: "longitude")
            laAddress.text="\(UserDefaults.standard.string(forKey: "address") ?? "")"
        }


        self.searchBar.txtSearch.addTarget(self, action: #selector(myTargetFunction), for: .editingDidBegin)

            SVProgressHUD.show()
            self.getSlider()
            self.FavouriteNearaby(lat:userLat,lag:userLng)
            self.setSetting()
        profile()
       
    
        
   
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userLat=UserDefaults.standard.double(forKey: "latitude")
        userLng=UserDefaults.standard.double(forKey: "longitude")
        laAddress.text="\(UserDefaults.standard.string(forKey: "address") ?? "")"
        self.getSlider()
        self.FavouriteNearaby(lat:userLat,lag:userLng)
        self.setSetting()
    }
    func controlBackItem(backItem: UIImageView){
       if L102Language.currentAppleLanguage().elementsEqual("ar"){
           if let _img = backItem.image {
               backItem.image =  UIImage(cgImage: _img.cgImage!, scale:_img.scale , orientation: UIImage.Orientation.upMirrored)
           }
       }
   }

    func setSetting(){
        collectionViewMe1.delegate = self
        collectionViewMe1.dataSource = self
        let nibName1 = UINib(nibName: "CVCHomeStation", bundle:nil)
        
        collectionViewMe1.register(nibName1, forCellWithReuseIdentifier: "CVCHomeStation")
      
        
        collectionViewMe2.delegate = self
        collectionViewMe2.dataSource = self
        let nibName2 = UINib(nibName: "CVCHomeStation", bundle:nil)
        
        collectionViewMe2.register(nibName2, forCellWithReuseIdentifier: "CVCHomeStation")
    
        
        
    }

    func setPagerView(){
  
        pagerViews.isInfinite = true
        pagerViews.automaticSlidingInterval = 3.0
        self.pagerViews.transformer = FSPagerViewTransformer(type: .crossFading)

        self.pagerViews.decelerationDistance = FSPagerView.automaticDistance;
        print(img.count ?? 0)
        pagerControls.numberOfPages=img.count ?? 0
        pagerControls.contentHorizontalAlignment = .center
        
        pagerControls.setImage(UIImage(named:"unselected"), for: .normal)
        pagerControls.setImage(UIImage(named:"selected"), for: .selected)
    }
    func date(){
        let date = Date()

        let calendar = Calendar.current
        year = calendar.component(.year, from: date)
        month = calendar.component(.month, from: date)
        gazPrice(month: month, year: year)

    }
    
}



extension VCHomeStation :  UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
  
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if collectionView == self.collectionViewMe1 {

            let vc=UIStoryboard.mainStoryBoard.instantiateViewController(withIdentifier: "VCSP") as! VCSP
       
            vc.favourite=favourite[indexPath.row]
            rateReview=favourite[indexPath.row].rates ?? []
            workHour=favourite[indexPath.row].working_hours ?? []
            trella=favourite[indexPath.row].supplier_trella ?? []
            supplierId =  favourite[indexPath.row].supplier_trella?.first?.supplier_id ?? 0
            print(favourite[indexPath.row].rate_value ?? [])
            UserDefaults.standard.set(favourite[indexPath.row].rate_value, forKey: "preview")
            UserDefaults.standard.setValue(favourite[indexPath.row].rate_count, forKey: "COUNT")
            UserDefaults.standard.setValue(favourite[indexPath.row].rate, forKey: "NUM")

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
                time.append(rateReview[indexx].diff ?? "")
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
            UserDefaults.standard.set(days, forKey: "days")
            UserDefaults.standard.set(fromTime, forKey: "from")
            UserDefaults.standard.set(toTime, forKey: "to")

            UserDefaults.standard.set(comment, forKey: "comment")
            UserDefaults.standard.set(imgUrl, forKey: "imgUrl")
            UserDefaults.standard.set(rateVV, forKey: "rating")
            print(rateVV)

            UserDefaults.standard.set(time, forKey: "time")
            UserDefaults.standard.set(name, forKey: "name")
            UserDefaults.standard.set(orderNum, forKey: "orderNum")
            UserDefaults.standard.set(trellaNameSize, forKey: "trellaName")

            

            UserDefaults.standard.set(favourite[indexPath.row].company_mobile, forKey: "mobile")
            UserDefaults.standard.set(favourite[indexPath.row].email, forKey: "email")
            UserDefaults.standard.set(supplierId, forKey: "supplierId")
            UserDefaults.standard.set(trellaId, forKey: "trellaId")

            vc.typeNum=1
            vc.stationId=featuredProviderId
            vc.trella=trellaNameSize
            vc.trellaId=trellaId
            navigationController?.pushViewController(vc, animated: true)
            
            
        } else if collectionView == self.collectionViewMe2 {
            let vc=UIStoryboard.mainStoryBoard.instantiateViewController(withIdentifier: "VCSP") as! VCSP
            print(nearaby[indexPath.row])
            print(nearbyProviderId)

            vc.nearaby=nearaby[indexPath.row]
            rateReview=nearaby[indexPath.row].rates ?? []
            workHour=nearaby[indexPath.row].working_hours ?? []
            trella=nearaby[indexPath.row].supplier_trella ?? []
            UserDefaults.standard.set(nearaby[indexPath.row].rate_value, forKey: "preview")
            UserDefaults.standard.setValue(nearaby[indexPath.row].rate_count, forKey: "COUNT")
            UserDefaults.standard.setValue(nearaby[indexPath.row].rate, forKey: "NUM")
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
                time.append(rateReview[indexx].diff ?? "")
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
            UserDefaults.standard.set(time, forKey: "time")
            UserDefaults.standard.set(name, forKey: "name")
            UserDefaults.standard.set(orderNum, forKey: "orderNum")
            UserDefaults.standard.set(supplierId, forKey: "supplierId")
            UserDefaults.standard.set(trellaId, forKey: "trellaId")


            UserDefaults.standard.set(nearaby[indexPath.row].company_mobile, forKey: "mobile")
            UserDefaults.standard.set(nearaby[indexPath.row].email, forKey: "email")
            vc.typeNum=2
            vc.stationId=nearbyProviderId
            vc.trella=trellaNameSize
            vc.trellaId=trellaId
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionViewMe1 {
            return  favourite.count //self.categoriesArry.count
            
            
        }else {
            
            return  nearaby.count//self.barnchArry.count
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        
        if collectionView == self.collectionViewMe1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVCHomeStation", for: indexPath) as! CVCHomeStation
            cell.coverPhoto.sd_setImage(with:URL(string: nearaby[indexPath.row].image ?? ""))
            cell.laLocation.text="\(Int(nearaby[indexPath.row].distance_lat_lng ?? 0.0))"
            cell.laNum.text="(\(nearaby[indexPath.row].rate_count ?? 0) +)"
            cell.rate.text="\(nearaby[indexPath.row].rate ?? 0)"

            cell.laStationName.text=nearaby[indexPath.row].company_name ?? ""

            if (nearaby[indexPath.row].open == "1"){
                cell.laStatus.text="open Now"
                cell.laStatus.textColor = UIColor(named: "Color8")
                cell.calender.image=UIImage(named: "calendar")


            }else{
                cell.laStatus.text="closed"
                cell.laStatus.textColor = UIColor(named: "Color7")
                cell.calender.image=UIImage(named: "calendar2")
            }
            
            
            
            return cell
            
            
        }else {
            
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVCHomeStation", for: indexPath) as! CVCHomeStation
          
            cell.coverPhoto.sd_setImage(with:URL(string: favourite[indexPath.row].image ?? ""))
            cell.laLocation.text="\(Int(favourite[indexPath.row].distance_lat_lng ?? 0.0))"

            cell.laStationName.text=favourite[indexPath.row].company_name ?? ""
            cell.laNum.text="(\(favourite[indexPath.row].rate_count ?? 0)+)"
            cell.rate.text="\(favourite[indexPath.row].rate ?? 0)"

//            if ((favourite[indexPath.row].open?.elementsEqual("1")) == nil){
            
            
            if favourite[indexPath.row].open == "1" {
                cell.laStatus.text="open Now"
                cell.laStatus.textColor = UIColor(named: "Color8")
                cell.calender.image=UIImage(named: "calendar")


            }else{
                cell.laStatus.text="closed"
                cell.laStatus.textColor = UIColor(named: "Color7")
                cell.calender.image=UIImage(named: "calendar2")
            }

            return cell
            
        }
        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.collectionViewMe1 {
            
            let vv =  collectionView.frame.width  - 0.0
            
            return CGSize(width: vv / 1.6 , height: 225.0)
        }else {
            // self.collectionViewMe
            
            //        let vv = WIDTH  - 10.0
            let vv =  collectionView.frame.width  - 0.0
            
            return CGSize(width: vv / 1.6 , height: 225.0)
            
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        if collectionView == self.collectionViewMe1 {
            return 8
        }else {
            return 8
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        if collectionView == self.collectionViewMe1 {
            return 8
        }else {
            return 8
        }
        
    }
    
    
}


extension String
{
    func widthWithConstrainedHeight(_ height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.width
    }
}

extension VCHomeStation:FSPagerViewDelegate,FSPagerViewDataSource{

    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return img.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(data: img[index])
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        SVProgressHUD.dismiss()

        return cell
    }
    
    // MARK:- FSPagerView Delegate
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
        guard let urlm = URL(string: url[index] ) else{return}
        UIApplication.shared.open(urlm)
        
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.pagerControls.currentPage = targetIndex
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.pagerControls.currentPage = pagerView.currentIndex
    }
 

    
    
    func showVCNewUpdate()  {
        let  viewController =  VCNewUpdate()
       
        
        let sheetController = SheetViewController(controller: viewController , sizes: [SheetSize.fixed(475)])
        sheetController.overlayColor = UIColor.black.withAlphaComponent(0.33)
        
        sheetController.pullBarView.backgroundColor = .clear
        sheetController.handleColor = UIColor.clear
        sheetController.adjustForBottomSafeArea = true
        sheetController.blurBottomSafeArea = false
        sheetController.dismissOnBackgroundTap = false
        sheetController.extendBackgroundBehindHandle = false
        sheetController.topCornersRadius = 12.0
        sheetController.makedissmWhencahngeBackGoud = false


       
        self.present(sheetController, animated: false, completion: nil)
    }
    
}
extension VCHomeStation{
    
    private func getSetting(){
        SVProgressHUD.show(withStatus: "Please wait..")

        
        let parameters: Parameters = [:]
        
        
        Alamofire.request(API_KEYS.getSetting.url, method: .get, parameters:parameters,headers: ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token")!)","Accept-Language": UserDefaults.standard.string(forKey: "language") ?? "en"]).validate().responseJSON { [self] (response) in
            if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
                print(str)
                if let parsedMapperString : Setting = Mapper<Setting>().map(JSONString:str){
                    if parsedMapperString.success == true{
                        
                    
                    if let slideData = parsedMapperString.data{
                      print(slideData.updated_ios)
                        
                        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
                        
                        if slideData.updated_ios != nil {
                            
                        if slideData.updated_ios!.description == version {
                            
                        }else {
                            DispatchQueue.main.async {
                                
//                                let vc = VCNewUpdate()
//
////                                vc.modalPresentationStyle = .fullScreen
//
//                                UIApplication.topViewController?.present(vc, animated: true, completion: {
//
//                                })
                                self.showVCNewUpdate()
                            }
                            
                        }
                        }
                        
                    }
                    }else{
                        showAlertMessage(title: "Error", message: parsedMapperString.message ?? "")
                    }
                }
                
            }}}
    
    
    
    private func getSlider(){
        SVProgressHUD.show()

        
        let parameters: Parameters = [:]
        
        
        Alamofire.request(API_KEYS.getSliders.url, method: .get, parameters:parameters,headers: ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token")!)","Accept-Language": UserDefaults.standard.string(forKey: "language") ?? "en"]).validate().responseJSON { [self] (response) in
            if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
                print(str)
                if let parsedMapperString : Slider = Mapper<Slider>().map(JSONString:str){
                    if parsedMapperString.success == true{
                        
                  
                    if let slideData = parsedMapperString.data{
                        
                        self.url.removeAll()
                        self.img.removeAll()
                        for index in 0 ... slideData.count-1 {
                            if let data = try? Data(contentsOf:URL(string:slideData[index].image ?? "")!)
                            {
                                img.append(data)
                            }
                            url.append(slideData[index].url ?? "")
                            
                        }
                        
                    }
                   print(img.count)
                    print(url.count)
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        pagerViews.delegate = self
                        pagerViews.dataSource = self
                        setPagerView()
                                          
//                    }
                   
                    }else{
                        showAlertMessage(title: "Error", message: parsedMapperString.message ?? "")

                    }
                }
            }}}
}
extension VCHomeStation{
    
    private func FavouriteNearaby(lat:Double,lag:Double){
        featuredProviderId=[]
        favourite=[]
        nearaby = []
        nearbyProviderId=[]
        let parameters: Parameters = [
            "lat":lat,
            "lng" : lag,
            "featuredProviders" : 1 ,
            "nearbyProviders" :1
            ]

            
        Alamofire.request(API_KEYS.postSuppliers.url, method: .post, parameters:parameters,headers: ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token")!)","Accept-Language": UserDefaults.standard.string(forKey: "language") ?? "en"]).validate().responseJSON { [self] (response) in
                if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
              print(str)
                    if let parsedMapperString : Suplierr = Mapper<Suplierr>().map(JSONString:str){
                        if parsedMapperString.success == true{
                            favourite=(parsedMapperString.data?.featured_providers)!
                            nearaby=(parsedMapperString.data?.nearby_providers)!
                            for index in 0 ... ((parsedMapperString.data?.featured_providers!.count)!-1){
                                featuredProviderId.append((parsedMapperString.data?.featured_providers![index].id)!)
                                
                            }
                            for indexx in 0 ... ((parsedMapperString.data?.nearby_providers!.count)!-1){
                                nearbyProviderId.append((parsedMapperString.data?.nearby_providers![indexx].id)!)


                            }
                            
                         
                        }else{
                            showAlertMessage(title: "Error", message: parsedMapperString.message ?? "")

                        }
                        }
                        
                    }

                collectionViewMe1.reloadData()
                collectionViewMe2.reloadData()
            }
  

    }
    
    
    private func filtering(lat:Double,lag:Double,filter:String){
        if filter.elementsEqual(NSLocalizedString("Most Ordered", comment: "")){
            parameters = [
                "lat":lat,
                "lng" : lag,
                "mostOrdered" : 1
                ]
        }else if filter.elementsEqual(NSLocalizedString("Near by", comment: "")) {
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
     


            
            Alamofire.request(API_KEYS.postSuppliers.url, method: .post, parameters:parameters,headers: ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token")!)","Accept-Language": UserDefaults.standard.string(forKey: "language") ?? "en"]).validate().responseJSON { [self] (response) in
                if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
              print(str)
                    if let parsedMapperString : Filter = Mapper<Filter>().map(JSONString:str){
                        if parsedMapperString.success == true{
                            
                            let vc = UIStoryboard.mainStoryBoard.instantiateViewController(withIdentifier: "VCFilterResults") as! VCFilterResults
                            vc.sdata=parsedMapperString.data ?? []
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                        }
                        
                    }
         
            }
  

    }
            
     
}
extension VCHomeStation{
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
            var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
            //21.228124
            let lon: Double = Double("\(pdblLongitude)")!
            //72.833770
            let ceo: CLGeocoder = CLGeocoder()
            center.latitude = lat
            center.longitude = lon

            let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)


            ceo.reverseGeocodeLocation(loc, completionHandler:
                {(placemarks, error) in
                    if (error != nil)
                    {
                        print("reverse geodcode fail: \(error!.localizedDescription)")
                    }
                    let pm = placemarks! as [CLPlacemark]

                    if pm.count > 0 {
                        let pm = placemarks![0]
     
                        var addressString : String = ""
                        
                         if pm.isoCountryCode != nil {
                             addressString = addressString + pm.isoCountryCode! + ""
                             self.countryCode = pm.isoCountryCode!
                            print("Country Code \(self.countryCode)")
                         }
                        if pm.subLocality != nil {
                            addressString = addressString + pm.subLocality! + ""
                        }
                        if pm.thoroughfare != nil {
                            addressString =  addressString + pm.thoroughfare! + ""
                        }
                        if pm.locality != nil {
                            addressString =  addressString + pm.locality! + ""
                        }
                        if pm.country != nil {
                            addressString =  addressString + pm.country! + ""
                            self.country = pm.country!
                            print("Country \(pm.country!)")
                        }
                        if pm.postalCode != nil {
                            addressString = addressString + pm.postalCode! + " "
                        }


                        
                       self.address = addressString
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            self.laAddress.text=self.address

//                                                }

                

                    }
            })

        }
    private func gazPrice(month:Int,year:Int){
        
        
        let parameters: Parameters = [
            "month" : month,
            "year":year]
        
        Alamofire.request(API_KEYS.get_prices.url, method: .post, parameters:parameters,headers: ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token")!)","Accept-Language":"en"]).validate().responseJSON { [self] (response) in
            if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
              
                if let parsedMapperString : getPrice = Mapper<getPrice>().map(JSONString:str){
                    fuel=(parsedMapperString.data?.fuels)!
                    showPrice()

                }
                
            }}}
    private func profile(){
        
        
  
        
        Alamofire.request(API_KEYS.getProfile.url, method: .get, parameters:nil,headers: ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token")!)","Accept-Language":"en"]).validate().responseJSON { [self] (response) in
            if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
              
                if let parsedMapperString : Profile = Mapper<Profile>().map(JSONString:str){
                    if parsedMapperString.data?.un_reade_notification_count != 0{
                        unCountView.isHidden=false
                   unCountNum.text = "\(parsedMapperString.data?.un_reade_notification_count ?? 0)"

                    }else{
                        unCountView.isHidden=true
                    }
                }
                
            }}}
    
    func showPrice(){
        if fuel.count != 0 {
            for index in 0 ... fuel.count-1{
                     showPrices += "\(fuel[index].name ?? "") \(fuel[index].price ?? 0.0) " + "||"
                 }
        }
                    self.fuelResult.text=self.showPrices

    }
}









