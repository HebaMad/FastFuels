//
//  VCCart.swift
//  FastFual
//
//  Created by Basim on 4/9/21.
//

import UIKit
import Alamofire
import ObjectMapper
import SVProgressHUD
class VCCart: UIViewController {
    var datess = Date()
    var dateOrder:String?
    var sdata:[MyCartData]=[]
    var copouns:CopounData?
    var paymentid:Int=1
    var toolBar = UIToolbar()
    var datePicker  = UIDatePicker()
    var year=0
    var month=0
    var day=0
    var hour=0
    var minute=0
    var sec=0

    @IBOutlet var backButton: UIButton!
    @IBAction func BuCancel(_ sender: Any) {
        delete()
    }
    @IBOutlet var copounLabel: UILabel!
    @IBOutlet var bankTransferImg: UIImageView!
    @IBOutlet var cashImg: UIImageView!
    @IBOutlet var visaImg: UIImageView!
    @IBOutlet var laStationName: UILabel!
    @IBOutlet var laPrice: UILabel!
    @IBOutlet var laItemNum: UILabel!
    
    @IBOutlet var displayTable: UITableView!
    @IBOutlet var gasType: UILabel!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var laStationLocation: UILabel!
    @IBOutlet var laSize: UILabel!
    @IBOutlet var laCopoun: UILabel!
    @IBOutlet var laDate: UILabel!
    
    @IBOutlet var vatValue: UILabel!
    @IBOutlet var copoun: UIButton!
    {
        
        didSet {
            copoun.addTarget(self, action: #selector(self.bucopounPressed), for: .touchUpInside)
            
            
        }
        
    }
    
    @objc func bucopounPressed() {
        if txtCopounCode.text?.count != 0{
            
        if copoun.titleLabel?.text! == "Redeem"{
            copoun(code: txtCopounCode.text!, ok: 1)
            copounLabel.isHidden=false

            laCopoun.isHidden=false
            copoun.setTitle("Remove", for: .normal)
            copoun.backgroundColor=UIColor(named: "Color7")

            
        }else{
            copoun(code: txtCopounCode.text!, ok: 0)
            copounLabel.isHidden=true
            laCopoun.isHidden=true
            copoun.setTitle("Redeem", for: .normal)
            copoun.backgroundColor=UIColor(named: "Color")

        }
        }else{
            showAlertMessage(title: "Error", message: "Enter the code firstly")
        }
    }
    
    @IBOutlet var orderTime: UIButton!
    
    @IBAction func setTime(_ sender: Any) {
        datePicker = UIDatePicker.init()
        datePicker.backgroundColor = UIColor.white
                
        datePicker.autoresizingMask = .flexibleWidth
        datePicker.datePickerMode = .dateAndTime
//        datePicker.maximumDate=Date.
        
        let currentCalendar = NSCalendar.current
        let dateComponents = NSDateComponents()
        dateComponents.day = +5
        let daysFromNow = currentCalendar.date(byAdding: .day, value: +5, to: datess)
//        datePicker.minimumDate = Date.init()
        datePicker.maximumDate = daysFromNow

//        UIScreen.main.bounds.size.height - 300
//        datePicker.addTarget(self, action: #selector(self.dateChanged(_:)), for: .valueChanged)
        datePicker.frame = CGRect(x: 0.0, y:UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(datePicker)
                
        toolBar = UIToolbar(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .default
        toolBar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.onDoneButtonClick))]
        toolBar.sizeToFit()
        self.view.addSubview(toolBar)
    }
    
//    @objc func dateChanged(_ sender: UIDatePicker?) {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = .medium
//        dateFormatter.timeStyle = .none
//        dateFormatter.dateFormat = "yyyy-MM-dd  HH:mm:ss "
//        laDate.text = dateFormatter.string(from: -datePicker.date)
//        self.view.endEditing(true)
//        if let date = sender?.date {
//            print("Picked the date \(dateFormatter.string(from: date))")
//        }
//    }

    @objc func onDoneButtonClick() {
        let dateFormatter = DateFormatter()
        let dateFormatters = DateFormatter()

        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "yyyy-MM-dd  HH:mm:ss "
        dateFormatter.locale = Locale(identifier: "en_us")
//        dateFormatter.setLocalizedDateFormatFromTemplate("yyyy-MM-dd  HH:mm:ss ")
        dateFormatters.dateFormat = "dd.MM.yyyy  hh:mm a"
        dateOrder = dateFormatter.string(from: datePicker.date)
        laDate.text = dateFormatters.string(from: datePicker.date)
        
        self.view.endEditing(true)
   
        toolBar.removeFromSuperview()
        datePicker.removeFromSuperview()
    }
    @IBOutlet var txtVNote: UITextView!
    @IBOutlet var txtCopounCode: UITextField!
    @IBOutlet var buPlaceOrder: UIButton!{
        didSet {
            buPlaceOrder.addTarget(self, action: #selector(self.buPlaceOrderPressed), for: .touchUpInside)
        } }
    @objc func buPlaceOrderPressed() {
        SVProgressHUD.show()
        SVProgressHUD.setBackgroundColor(.clear)
        checkOut(coupon: txtCopounCode.text ?? "", additionalNote: txtVNote.text ?? "", payment: paymentid, date: (dateOrder ?? "\(laDate.text ?? "")" )
        )

    }
    

    override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           self.tabBarController?.tabBar.isHidden = false

       }

       override func viewWillAppear(_ animated: Bool) {
                   super.viewWillAppear(animated)
           self.tabBarController?.tabBar.isHidden = true

       }
    
    @IBOutlet var cashPaymentMethod: UIView!
    {
        didSet {
            cashPaymentMethod.addGestureRecognizer( UITapGestureRecognizer(target: self, action: #selector(self.viewCashPreseed(_:))))
            cashPaymentMethod.isUserInteractionEnabled = true
        }
    }
    @objc func viewCashPreseed(_ sender: UITapGestureRecognizer) {
        cashImg.image=UIImage(named: "p012")
        bankTransferImg.image=UIImage(named: "p00")
        
        
        
        paymentid=2
        
    }
    
    @IBOutlet var bankTransferPaymentMethod: UIView!
    {
        didSet {
            bankTransferPaymentMethod.addGestureRecognizer( UITapGestureRecognizer(target: self, action: #selector(self.viewBankTransPreseed(_:))))
            bankTransferPaymentMethod.isUserInteractionEnabled = true
        }
    }
    @objc func viewBankTransPreseed(_ sender: UITapGestureRecognizer) {
        cashImg.image=UIImage(named: "p00")
        bankTransferImg.image=UIImage(named: "p012")
        
        
        paymentid=3
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        date()
        copounLabel.isHidden=true
        laCopoun.isHidden=true
        controlBackItem(backItem: backButton)

        registerNib()
        getMyCart()
        displayTable.reloadData()
        
    }
    func registerNib(){
        let nib = UINib(nibName: "CVCGasType", bundle: nil)
        displayTable.register(nib, forCellReuseIdentifier: "CVCGasType")
    }
    
}
extension VCCart : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sdata.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CVCGasType", for: indexPath) as! CVCGasType
        cell.fuelName.text=sdata[indexPath.row].fule_name ?? ""
        cell.price.text="\(sdata[indexPath.row].fule_price ?? 0.0)" + " " + NSLocalizedString("SR", comment: "")
        cell.QuantityNum.text="\(sdata[indexPath.row].count_trella ?? 0)"
        
        return cell
    }
    
    
}
extension VCCart{
    
    private func getMyCart(){
        sdata=[]
        let parameters: Parameters = [:]
        
        
        Alamofire.request(API_KEYS.getMyCart.url, method: .get, parameters:parameters,headers: ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token")!)","Accept-Language": UserDefaults.standard.string(forKey: "language") ?? "en"]).validate().responseJSON { [self] (response) in
            if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
                print(str)
                if let parsedMapperString : MyCart = Mapper<MyCart>().map(JSONString:str){
                    if parsedMapperString.success == true{
                        
                        sdata=parsedMapperString.data ?? []
                        print(sdata)
//                              laStationName.text=sdata[0].supplier_name ?? ""
                           profileImage.sd_setImage(with:URL(string:sdata[0].supplier_image ?? ""))
                          laStationLocation.text=sdata[0].supplier_address ?? ""
                        gasType.text=sdata[0].trella_size ?? "" + sdata[0].trella_name!
                        displayTable.delegate=self
                        displayTable.dataSource=self
                        displayTable.reloadData()

                        getCost()
                    }else{
                        showAlertMessage(title: "Error", message: parsedMapperString.message ?? "")
                    }
                }
                
            }
        }
    }
    private func copoun(code:String,ok:Double){
        
        let parameters: Parameters = [
            "code":code ,
            "ok":ok
        ]
        
        
        Alamofire.request(API_KEYS.postcoupon.url, method: .post, parameters:parameters,headers: ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token")!)","Accept-Language": UserDefaults.standard.string(forKey: "Langugee") ?? "en"]).validate().responseJSON { [self] (response) in
            if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
                print(str)
                if let parsedMapperString : Copoun = Mapper<Copoun>().map(JSONString:str){
                    if parsedMapperString.success == true{
                        copouns = parsedMapperString.data
                        laCopoun.text="\(copouns?.total ?? 0.0)" + "SR"
                        
                    }else{
                        showAlertMessage(title: "Error", message: parsedMapperString.message ?? "")
                    }
                }
                
            }
        }
    }
    
    private func checkOut(coupon:String,additionalNote:String,payment:Int,date:String){
        
        let parameters: Parameters = [
            "orderTime":date ,
            "coupon":coupon,
            "additionalNote":additionalNote,
            "payment":payment
        ]
        
        
        Alamofire.request(API_KEYS.postCheckOut.url, method: .post, parameters:parameters,headers: ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token")!)","Accept-Language": UserDefaults.standard.string(forKey: "Langugee") ?? "en"]).validate().responseJSON { [self] (response) in
            if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
                print(str)
                if let parsedMapperString : CheckOutReq = Mapper<CheckOutReq>().map(JSONString:str){
                    if parsedMapperString.success == true{
                     //   self.showAlertMessage(title: "Fast Fuel", message: parsedMapperString.message ?? "")
                        let vc = VCOrderSent()
                        vc.orderNumber="\(parsedMapperString.order_number ?? 0)"

                        SVProgressHUD.dismiss()
                          
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                          //  getTopViewController()?.navigationController?.pushViewController(vc, animated: false)

                            self.navigationController?.pushViewController(vc, animated: false)

                        }
   
   
                    }else{
                        showAlertMessage(title: "Error", message: parsedMapperString.message ?? "")
                    }
                }
                
            }
        }
    }
    
    private func delete(){
        
        
        Alamofire.request(API_KEYS.getDeleteMyCart.url, method: .get, parameters:nil,headers: ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token")!)","Accept-Language": UserDefaults.standard.string(forKey: "Langugee") ?? "en"]).validate().responseJSON { [self] (response) in
            if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
                print(str)
                if let parsedMapperString : login = Mapper<login>().map(JSONString:str){
                    if parsedMapperString.success == true{
                        navigationController?.popViewController(animated: true)
                    }else{
                        showAlertMessage(title: "Error", message: parsedMapperString.message ?? "")
                    }
                }
                
            }
        }
    }
    
    
    private func getCost(){
        
        
        Alamofire.request(API_KEYS.getCosts.url, method: .get, parameters:nil,headers: ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token")!)"]).validate().responseJSON { [self] (response) in
            if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
                print(str)
   if let parsedMapperString : GetCost = Mapper<GetCost>().map(JSONString:str){
                    if parsedMapperString.success == true{
                        laItemNum.text="\(parsedMapperString.data?.quantity ?? 0)"
                        laSize.text=parsedMapperString.data?.size ?? ""
                      
                        vatValue.text="\(parsedMapperString.data?.vat ?? 0)"
                        laPrice.text="\(parsedMapperString.data?.total ?? 0.0)" + " " + "SR"

                    }else{
                        showAlertMessage(title: "Error", message: parsedMapperString.message ?? "")
                    }
                }
                
            }
        }
    }
    func date(){
        let date = Date()
       // "yyyy-MM-dd  HH:mm:ss "
        let calendar = Calendar.current
        year = calendar.component(.year, from: date)
        month = calendar.component(.month, from: date)
        day = calendar.component(.day, from: date)
        hour = calendar.component(.hour, from: date)
        minute = calendar.component(.minute, from: date)
        sec = calendar.component(.second, from: date)
        laDate.text="\(year)-\(month)-\(day)" + " " + "\(hour):\(minute):\(sec)"
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_us")
//        formatter.setLocalizedDateFormatFromTemplate("dd-MM-yyyy")
        formatter.dateFormat = "dd-MM-yyyy"
        datess = formatter.date(from: "\(date)") ?? Date()
    }
    func controlBackItem(backItem: UIButton){
       if L102Language.currentAppleLanguage().elementsEqual("ar"){
        if let _img = backItem.imageView{
            backItem.setImage(UIImage(cgImage: (_img.image?.cgImage!)!, scale:_img.image!.scale , orientation: UIImage.Orientation.upMirrored), for: .normal)
            
           }
       }
   }

    
}
