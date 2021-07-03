//
//  VCBankTransfer.swift
//  FastFual
//
//  Created by Basim on 5/8/21.
//

import UIKit
import Alamofire
import ObjectMapper
import SDWebImage
import DropDown
import SVProgressHUD
class VCBankTransfer: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet var backButton: UIButton!
    var toolBar = UIToolbar()
    var datePicker  = UIDatePicker()
    var orderId:Int=0
    var orderNum:Int=0

    var total:Double=0.0
    var datess = Date()

    @IBAction func buBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    

    @IBAction func setDate(_ sender: Any) {
        createDatePicker()
//        datePicker = UIDatePicker.init()
//        datePicker.backgroundColor = UIColor.white
//
//        datePicker.autoresizingMask = .flexibleWidth
//        datePicker.datePickerMode = .date
////        datePicker.maximumDate=Date.
//
//        let currentCalendar = NSCalendar.current
//        let dateComponents = NSDateComponents()
//        dateComponents.day = +5
//        let daysFromNow = currentCalendar.date(byAdding: .day, value: +5, to: datess)
////        datePicker.minimumDate = Date.init()
//        datePicker.maximumDate = daysFromNow
//
////        UIScreen.main.bounds.size.height - 300
////        datePicker.addTarget(self, action: #selector(self.dateChanged(_:)), for: .valueChanged)
//        datePicker.frame = CGRect(x: 0.0, y:UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
//        self.view.addSubview(datePicker)
////
//        toolBar = UIToolbar(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
//        toolBar.barStyle = .default
//        toolBar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.onDoneButtonClick))]
//        toolBar.sizeToFit()
//        self.view.addSubview(toolBar)
//    }
//    @objc func onDoneButtonClick() {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = .medium
//        dateFormatter.timeStyle = .none
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        dateFormatter.locale = Locale(identifier: "en_us")
////        dateFormatter.setLocalizedDateFormatFromTemplate("dd-MM-yyyy")
//        dateTxt.text = dateFormatter.string(from: datePicker.date)
//        self.view.endEditing(true)
//
//        toolBar.removeFromSuperview()
//        datePicker.removeFromSuperview()
    }

    
    @IBOutlet var send: UIButton!{
        didSet {
            send.addTarget(self, action: #selector(self.buSendPressed), for: .touchUpInside)
        
    }
    }
    @objc func buSendPressed() {
        if checkData(){
//            getBankID()
            bankTransfer(order_id:orderId , bank_id: "\(idBank)", amount: total , account_name: accountNameTxt.text!, attachment: transferImage,  date: dateTxt.text ?? "")
        }else{
            showAlertMessage(title: "fast Fuel", message: "All data is required")
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
    let dropDown = DropDown()
    var transferImage:UIImage=UIImage()
    var sdata:[BanksData]=[]
   var banksName:[String]=[]
    var id:[Int]=[]
    var idBank:Int=0
    @IBOutlet var upload: UIButton!{
        didSet {
        upload.addTarget(self, action: #selector(self.buUploadPressed), for: .touchUpInside)
        
    }
        
    }
    
    @objc func buUploadPressed() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        
        self.present(picker, animated: true, completion: nil)
    }
        

        
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            guard let image = info[.editedImage] as? UIImage else{
                return
            }
            transferImage=image
            
            picker.dismiss(animated: true, completion: nil)
        }
        
        
        
        
        
    @IBOutlet var img: UIImageView!
    @IBOutlet var dateTxt: UITextField!
    @IBOutlet var accountNameTxt: UITextField!
    @IBOutlet var amoutTxt: UITextField!
    @IBOutlet var orderidTxt: UITextField!
    @IBOutlet var displayTable: UITableView!
        
    
    @IBOutlet var bankTxt: UITextField!
    
    @IBOutlet var bubank: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        controlBackItem(backItem: backButton)

        print(orderId)
        print(total)

        orderidTxt.text="\(orderId)"
        amoutTxt.text="\(total)"
        SVProgressHUD.show()
        SVProgressHUD.setBackgroundColor(.clear)

        registerNib()
        getBank()
    }
    
    @IBAction func selectBank(_ sender: Any) {
            self.dropDown.anchorView = self.bubank
            self.dropDown.dataSource = self.banksName
            self.dropDown.cellNib = UINib(nibName: "DropDownView", bundle: nil)
            
            self.dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            }
            self.dropDown.selectionAction = { [self] (index: Int, item: String) in
                print("Selected item: \(item) at index: \(index)")
                self.bankTxt.textColor = UIColor.black
                self.bankTxt.text = item
                getBankID()

            }
            self.dropDown.width = self.bankTxt.frame.size.width
            self.dropDown.bottomOffset = CGPoint(x: 0, y:(self.dropDown.anchorView?.plainView.bounds.height)!)
            self.dropDown.show()
    }
    
    func registerNib(){
        let nib = UINib(nibName: "CVCBanks", bundle: nil)
        displayTable.register(nib, forCellReuseIdentifier: "CVCBanks")
    }
 

}
extension VCBankTransfer : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sdata.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CVCBanks", for: indexPath) as! CVCBanks

        cell.iban.text=sdata[indexPath.row].ipan_number ?? ""
        cell.userName.text=sdata[indexPath.row].account_name ?? ""
        cell.accountNum.text=sdata[indexPath.row].account_number ?? ""
        cell.logo.sd_setImage(with:URL(string: sdata[indexPath.row].logo ?? ""))
        banksName.append(sdata[indexPath.row].name ?? "")
        id.append(sdata[indexPath.row].id ?? 0)
return cell
    }

        
    }
extension VCBankTransfer {
    private func getBank(){
        sdata=[]
        banksName=[]
        id=[]
        let parameters: Parameters = [:]

            
            Alamofire.request(API_KEYS.getBanks.url, method: .get, parameters:nil,headers: ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token")!)","Accept-Language": UserDefaults.standard.string(forKey: "Langugee") ?? "en"]).validate().responseJSON { [self] (response) in
                if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
              print(str)
                    if let parsedMapperString : Banks = Mapper<Banks>().map(JSONString:str){
                        if parsedMapperString.success == true{
                            sdata=parsedMapperString.data ?? []
                            displayTable.reloadData()
                            SVProgressHUD.dismiss()
                            displayTable.delegate=self
                            displayTable.dataSource=self
                        }else{
                            showAlertMessage(title: "Error", message: parsedMapperString.message ?? "")
                        }
                        }
                        
                    }
          
            }
  

    }
    
   func getBankID(){
    
    for index in 0 ... id.count-1{
        if ((bankTxt.text?.elementsEqual(banksName[index])) != nil){
            idBank=id[index]
        }
    }
        
    }
    
    private func bankTransfer(order_id:Int,bank_id:String,amount:Double,account_name:String,attachment:UIImage,date:String){
        print(order_id)
        print(bank_id)
        print(amount)
        print(account_name)
        print(attachment)




        let parameters: Parameters = [
            "order_id":order_id,
            "bank_id" : bank_id,
            "amount" : amount,
            "account_name" : account_name,
            "attachment" : attachment,
            "date" : date
  
        ]

            
            Alamofire.request(API_KEYS.postBankTransfer.url, method: .post, parameters:parameters,headers: ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token")!)","Accept-Language": UserDefaults.standard.string(forKey: "language") ?? "en"]).validate().responseJSON { [self] (response) in
                if let data : Data = response.data,let str : String = String(data: data, encoding: .utf8){
              print(str)
                    if let parsedMapperString : login = Mapper<login>().map(JSONString:str){
                        if parsedMapperString.success == true{
//                            showAlertMessage(title: "Fast Fuel", message: parsedMapperString.message ?? "")
                            let vc = VCPaymentConfirmed()
                            vc.orderNumber = orderNum

                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                self.navigationController?.pushViewController(vc, animated: false)

                            }


                        }else{
                            showAlertMessage(title: "Error", message: parsedMapperString.message ?? "")
                        }
                        }
                        
                    }
          
            }
  

    }
    func checkData() -> Bool{
        if !orderidTxt.text!.isEmpty && idBank != 0 && !amoutTxt.text!.isEmpty && !accountNameTxt.text!.isEmpty{
          return true
        }else{
            if orderidTxt.text!.isEmpty{
                showAlertMessage(title: "Fast Fuel", message: "Enter your order id")
            }else if amoutTxt.text!.isEmpty{
                showAlertMessage(title: "Fast Fuel", message: "Enter your Amount ")

            }else if accountNameTxt.text!.isEmpty{
                showAlertMessage(title: "Fast Fuel", message: "Enter your Account Name ")

            }else if idBank == 0{
                showAlertMessage(title: "Fast Fuel", message: "Select your Bank")

            }
            return false

        }

    }
    func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let donebtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donepressed))
        toolbar.setItems([donebtn], animated: true)
        dateTxt.inputAccessoryView = toolbar
        dateTxt.inputView = datePicker
        
        datePicker.datePickerMode = .dateAndTime
    }
    @objc func donepressed() {
        let dateformator = DateFormatter()
        dateformator.dateStyle = .medium
        dateformator.timeStyle = .medium
        dateformator.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateformator.locale = Locale(identifier: "en_us")
//        dateformator.setLocalizedDateFormatFromTemplate("yyyy-MM-dd HH:mm:ss")
        dateTxt.text = dateformator.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    func controlBackItem(backItem: UIButton){
       if L102Language.currentAppleLanguage().elementsEqual("ar"){
        if let _img = backItem.imageView{
            backItem.setImage(UIImage(cgImage: (_img.image?.cgImage!)!, scale:_img.image!.scale , orientation: UIImage.Orientation.upMirrored), for: .normal)
            
           }
       }
   }
    
    
}
