//
//  VCGasPrices.swift
//  FastFual
//
//  Created by Basim on 4/5/21.
//

import UIKit
import Alamofire
import ObjectMapper
import SDWebImage
import MonthYearPicker
class VCGasPrices: UIViewController {
    var expiryDatePicker = MonthYearPickerView()
    var toolBar = UIToolbar()
    var datess = Date()

    @IBOutlet var fuelDate: UIView!{
        didSet {
            fuelDate.addGestureRecognizer( UITapGestureRecognizer(target: self, action: #selector(self.viewDatePreseed(_:))))
            fuelDate.isUserInteractionEnabled = true
        }
    }
    @objc func viewDatePreseed(_ sender: UITapGestureRecognizer) {
        expiryDatePicker = MonthYearPickerView.init()
        expiryDatePicker.frame = CGRect(x: 0.0, y:UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        expiryDatePicker.backgroundColor = UIColor.white
        expiryDatePicker.tintColor = UIColor.black
        expiryDatePicker.contentMode = .redraw
        expiryDatePicker.autoresizingMask = .flexibleHeight
        
        expiryDatePicker.minimumDate = Calendar.current.date(byAdding: .month, value: -(datess.month), to: Date())
        expiryDatePicker.maximumDate = Calendar.current.date(byAdding: .year, value: 1, to: Date())

//        expiryDatePicker.addTarget(self, action:#selector(dateChanged(_:)), for: .valueChanged)
        self.view.addSubview(expiryDatePicker)
                
        toolBar = UIToolbar(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .default
        toolBar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.onDoneButtonClick))]
        toolBar.sizeToFit()
        self.view.addSubview(toolBar)
//        expiryDatePicker.onDateSelected = { (month: Int, year: Int) in
//            let string = String(format: "%02d/%d", month, year)
//            NSLog(string) // should show something like 05/2015
//        }
    }

    @objc func onDoneButtonClick() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "MMMM yyyy"
        laDate.text = dateFormatter.string(from: expiryDatePicker.date)
        self.view.endEditing(true)
        gazPrice(month: expiryDatePicker.date.month, year: expiryDatePicker.date.year)
     
        toolBar.removeFromSuperview()
        expiryDatePicker.removeFromSuperview()

        
    }


    var currentYear:Int=0
    var currentMonth:Int=0
    var data:PriceData?
    var prices:[Prices]=[Prices]()
    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(
        top: 8,
        left: 20,
        bottom: 0,
        right: 20)
    var year=0
    var month=0
    var fuel:[Fuels]=[]
    
    //CVCGasPrice
    @IBOutlet var laStationName: UILabel!
    @IBOutlet var price: UILabel!
    
    @IBOutlet var dropDown: UIImageView!
    @IBOutlet var laDate: UILabel!
    @IBOutlet var buBack: UIButton!
    @IBOutlet var stationImg :  UIImageView!
    
    @IBOutlet var displayCollectionTable: UICollectionView!
    @IBOutlet var latitle: UILabel!
    @IBOutlet var txtVdescription:UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()
        date()
        controlBackItem(backItem: buBack)

 
    }
    
    
    @IBAction func back(_ sender: Any) {
//        let vc=VCHomeStation()
        navigationController?.popViewController(animated: true)
    }
    func date(){
        let date = Date()
        
        let calendar = Calendar.current
        year = calendar.component(.year, from: date)
        month = calendar.component(.month, from: date)
        gazPrice(month: month, year: year)
        
    }
    func registerNib(){
        let nib = UINib(nibName: "CVCGasPrice", bundle: nil)
        displayCollectionTable.register(nib, forCellWithReuseIdentifier: "CVCGasPrice")
        displayCollectionTable.register(UINib(nibName: "HeaderCRV", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "HeaderCRV")
        displayCollectionTable.register(UINib(nibName: "FooterCRV", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "FooterCRV")
    }
    
}
extension VCGasPrices:UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fuel.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVCGasPrice", for: indexPath) as! CVCGasPrice
        if fuel.count != 0 {
        cell.latitle.text=fuel[indexPath.row].name ?? ""
        cell.laQuality.text="\(fuel[indexPath.row].price ?? 0.0)" + "SR"
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let vv =  collectionView.frame.width  - 10.0
        return CGSize(width: vv / 2.0 , height: 100)
        
        
    }
    
    

func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        
        case UICollectionView.elementKindSectionHeader:
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCRV", for: indexPath) as! HeaderCRV
 
            return header
            
        case UICollectionView.elementKindSectionFooter:
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FooterCRV", for: indexPath) as! FooterCRV

            return footer
            
        default:
            
            print("anything")
        }
        
       return UICollectionReusableView()
    }
    
    
    
}
extension VCGasPrices{
    
    private func gazPrice(month:Int,year:Int){
        
        
        let parameters: Parameters = [
            "month" : month,
            "year":year]
        
        print("Bearer \(UserDefaults.standard.string(forKey: "token")!)")
        Alamofire.request(API_KEYS.get_prices.url, method: .post, parameters:parameters,headers: ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token")!)","Accept-Language": UserDefaults.standard.string(forKey: "language") ?? "en"]).validate().responseJSON { [self] (response) in
            if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
                
                if let parsedMapperString : getPrice = Mapper<getPrice>().map(JSONString:str){
                    if parsedMapperString.success == true{
                        if parsedMapperString.data?.fuels?.count != 0 {
                            
                        
                    print(parsedMapperString.data?.fuels?[0].name ?? "")
                    laStationName.text!=(parsedMapperString.data?.fuels?[0].name)!
                    price.text! = "\(parsedMapperString.data?.fuels?[0].price ?? 0.0)"
                    if let urlimg = parsedMapperString.data?.fuels?[0].logo{
                        stationImg.sd_setImage(with:URL(string: urlimg))
                    }
                        }
                    fuel=(parsedMapperString.data?.fuels ?? [])
                        print(fuel.count)
                    displayCollectionTable.delegate=self
                    displayCollectionTable.dataSource=self
                      
                    }else{
                        showAlertMessage(title: "Error", message: parsedMapperString.message ?? "")
                    }
                    
                }}}
        
    }
    func controlBackItem(backItem: UIButton){
       if L102Language.currentAppleLanguage().elementsEqual("ar"){
        if let _img = backItem.imageView{
            backItem.setImage(UIImage(cgImage: (_img.image?.cgImage!)!, scale:_img.image!.scale , orientation: UIImage.Orientation.upMirrored), for: .normal)
            
           }
       }
   }
}

