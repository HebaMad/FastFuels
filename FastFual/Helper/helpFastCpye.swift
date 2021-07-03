////
//
////
//
////@IBOutlet weak var laLogo: UILabel!
////@IBOutlet weak var stackLogo: UIStackView!
//@IBOutlet weak var laLogo: UILabel!
//@IBOutlet weak var uiimgeLogo: UIImageView!
//@IBOutlet weak var buLogin: UIButton!{
//didSet {
//
//}
//}
//
//@IBOutlet weak var viewUpBackGround: UIView!
//@IBOutlet weak var uiimgeLogo: UIImageView!
//////@IBOutlet weak var laLogo: UILabel!
//////@IBOutlet weak var viewUpBackGround: UIView!
//{
//    didSet {
//        
//    }
//}
//@IBOutlet weak var buCountinue: UIButton! {
//    didSet {
//
//    }
//}
//
/////////
//////@IBOutlet weak var viewUpBackGround: UIView!
//{
//    didSet {
//
//    }
//}
//@IBOutlet weak var stackLogo: UIStackView!{
//    didSet {
//
//    }
//}
////
//@IBOutlet weak var uiimgeLogo: UIImageView!{
//    didSet {
//
//    }
//}
//
//@IBOutlet weak var viewUpBackGround: UIView!
//{
//    didSet {
//
//    }
//}
//@IBOutlet weak var laLogo: UILabel!{
//    didSet {
//
//    }
//}
////
//@IBOutlet weak var txtPhoneNO: UITextField!{
//    didSet {
//
//    }
//}
//
//@IBOutlet weak var buCountinue: UIButton! {
//    didSet {
//
//    }
//}
//
//@IBAction func buVerificationPreseed(_ sender: Any) {
//
//
//}
//
//
//
////
////func shadowBasim (button : UIButton ){
////
////    button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
////    button.layer.shadowOffset = CGSize(width: 0, height: 3)
////    button.layer.shadowOpacity = 1.0
////    button.layer.shadowRadius = 10.0
////    button.layer.masksToBounds = false
////
////}
////
////func changeCornerButton (button: UIButton) {
////    button.layer.cornerRadius = button.frame.size.height / 2
////}
////func changeCornerTextField (textField: UITextField) {
////    textField.layer.cornerRadius = textField.frame.size.height / 2
////}
////func changeCornerLabel (label: UILabel) {
////    label.layer.cornerRadius = label.frame.size.height / 2
////}
////
////
//
//
//
//func gradientColor()  {
//    let gradient = CAGradientLayer()
//    let sizeLength = UIScreen.main.bounds.size.height * 2
//    let defaultNavigationBarFrame = CGRect(x: 0, y: 0, width: sizeLength, height: 64)
//
//    gradient.frame = defaultNavigationBarFrame
//
//    gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
//    // gradient.endPoint = CGPoint(x: 1.0, y: 0.0)
//
//    let color1 = hexStringToUIColor(hex: "B08A38").cgColor
//    let color2 = hexStringToUIColor(hex: "0002FF").cgColor
//
//    gradient.colors = [color1,color2]
//
//    self.navigationController?.navigationBar.setBackgroundImage(self.image(fromLayer: gradient), for: .default)
//}
//func image(fromLayer layer: CALayer) -> UIImage {
//    UIGraphicsBeginImageContext(layer.frame.size)
//
//    layer.render(in: UIGraphicsGetCurrentContext()!)
//
//    let outputImage = UIGraphicsGetImageFromCurrentImageContext()
//
//    UIGraphicsEndImageContext()
//
//
//    return outputImage!
//}
//
//
//func hexStringToUIColor (hex:String) -> UIColor {
//    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
//
//    if (cString.hasPrefix("#")) {
//        cString.remove(at: cString.startIndex)
//    }
//
//    if ((cString.count) != 6) {
//        return UIColor.gray
//    }
//
//    var rgbValue:UInt32 = 0
//    Scanner(string: cString).scanHexInt32(&rgbValue)
//
//    return UIColor(
//        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
//        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
//        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
//        alpha: CGFloat(1.0)
//    )
//}
//
//////////////////////////////////////////////////
////


/// to connect with api ////

//func setFcmToken() {
//
//    if UserDefaults.standard.string(forKey: "userId") != nil {
//        let userIdGetting =  UserDefaults.standard.string(forKey: "userId")!
//        //  let api_tokenGetting = UserDefaults.standard.string(forKey: "api_token")!
//        let fcmToken = UserDefaults.standard.string(forKey: "fcmToken")!
//        URLCache.shared.removeAllCachedResponses()
//        Alamofire.request(SET_FCM_TOKEN + userIdGetting + "/" + fcmToken , method: .get , parameters: nil , encoding: URLEncoding.default, headers: nil).validate().responseSwiftyJSON { (response) in
//
//            switch response.result {
//
//            case .success:
//
//                let data = response.value
//                print (data ?? "")
//
//            case .failure(_):
//
//                print("faild setFcmToken")
//
//            } }  }
//}


//////////////////////// .get  function ////////////////////

//
//func  getOfficeServants(){
//
//    let userIdGetting =  UserDefaults.standard.string(forKey: "userId")!
//    let header = [
//        // "token": api_tokenGetting,
//        "Content-Type": "application/json"
//        //  "cache-control": "no-cache" ,
//        // "Postman-Token": "786d7878-78f7-4362-884c-8b751a4894de"
//    ]
//
//    URLCache.shared.removeAllCachedResponses()
//
//    Alamofire.request(GET_OFFICE_SERVANTS + userIdGetting , method: .get , parameters: nil , encoding: URLEncoding.default, headers: header).validate().responseSwiftyJSON { (response) in
//
//        switch response.result {
//
//        case .success:
//            let data = response.value
//            //  //  //print(data ?? "" )
//            let orderArray = data?.dictionary!["servants"]?.array!
//            self.allServantsArray.removeAll()
//            for curentOrder in orderArray!{
//
//                self.allServantsArray.append(servants.init(curentOrder))
//
//            }
//            self.tableVieww.reloadData()
//
//        case .failure(_):
//            print("faild GET_OFFICE_SERVANTS")
//        }}
//}



//////////////////////// .post  function ////////////////////
//
//func makeOrder(servant_id: String ) {
//
//    let userIdGetting =  UserDefaults.standard.string(forKey: "userId")!
//
//    let parameters = [
//        "client_id" : userIdGetting,
//        "servant_id": servant_id
//
//        ] as [String : Any]
//
//    MyTools.tool.showIndicator()
//
//    Alamofire.request(MAKE_ORDER , method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).validate().responseSwiftyJSON { (response) in
//
//        MyTools.tool.hideIndicator()
//
//        switch response.result {
//
//        case .success:
//
//            let data = response.value
//            //  //  //print(data ?? "" )
//
//
//            let status = data!["servants"].string
//            if  status == "تم استلام الطلب" {
//                // self.navigationController?.popToRootViewController(animated: true)
//
//                let alert = UIAlertController(title: "رسالة تنبيه", message: data!["servants"].string , preferredStyle: UIAlertControllerStyle.alert)
//                // add an action (button)
//                alert.addAction(UIAlertAction(title: "موافق", style: UIAlertActionStyle.default, handler: nil))
//
//                // show the alert
//                self.present(alert, animated: true, completion: nil)
//
//            }else {
//
//
//            }
//
//        case .failure(let error):
//
//            print(error)
//
//
//        }           }  }






/////////////////////////////// in this Porject ////////////////////////////////////////////





//
//func  clientProfile(){
//
//    if  UserDefaults.standard.string(forKey: "userId") != nil {
//    let userIdGetting =  UserDefaults.standard.string(forKey: "userId")!
//    let header = [
//        // "token": api_tokenGetting,
//        "Content-Type": "application/json"
//        //  "cache-control": "no-cache" ,

//        // "Postman-Token": "786d7878-78f7-4362-884c-8b751a4894de"
//    ]
//
//    URLCache.shared.removeAllCachedResponses()
//
//    Alamofire.request(CLIENTP_ROFILE + userIdGetting , method: .get , parameters: nil , encoding: URLEncoding.default, headers: header).validate().responseSwiftyJSON { (response) in
//
//        switch response.result {
//
//        case .success:
//            let data = response.value
//            //  //  //print(data ?? "" )
////            let orderArray = data?.dictionary!["servants"]?.array!
////            self.allServantsArray.removeAll()
////            for curentOrder in orderArray!{
////
////                self.allServantsArray.append(servants.init(curentOrder))
////
////            }
////            self.tableVieww.reloadData()
//
//        case .failure(_):
//            print("faild GET_OFFICE_SERVANTS")
//        }
//
//    }
//}
//
//}




//func  getDepartments(){
//
//    let userIdGetting =  UserDefaults.standard.string(forKey: "userId")!
//    let header = [
//        // "token": api_tokenGetting,
//        "Content-Type": "application/json"
//        //  "cache-control": "no-cache" ,
   // "X-Oc-Image-Dimension" : "250x250",
//        // "Postman-Token": "786d7878-78f7-4362-884c-8b751a4894de"
//    ]
//
//    URLCache.shared.removeAllCachedResponses()
//
//    Alamofire.request(DEPARTMENTS , method: .get , parameters: nil , encoding: URLEncoding.default, headers: header).validate().responseSwiftyJSON { (response) in
//
//        switch response.result {
//
//        case .success:
//            let data = response.value
//              //  //print(data ?? "" )
//
//            let orderArray = data?.dictionary!["departments"]?.array!
//            self.allServantsArray.removeAll()
//            for curentOrder in orderArray!{
//
//                self.allServantsArray.append(departments.init(curentOrder))
//
//            }
//         //   self.tableVieww.reloadData()
//            //   self.collectionVieww.reloadData()
//
//
//        case .failure(_):
//            print("faild GETD_EPARTMENTS")
//        }
//
//    }
//}


//
//func  getCATEGORIES(){
//
//    let userIdGetting =  UserDefaults.standard.string(forKey: "userId")!
//    let header = [
//        // "token": api_tokenGetting,
//        "Content-Type": "application/json"
//        //  "cache-control": "no-cache" ,
   // "X-Oc-Image-Dimension" : "250x250",
//        // "Postman-Token": "786d7878-78f7-4362-884c-8b751a4894de"
//    ]
//
//    URLCache.shared.removeAllCachedResponses()
//
//    Alamofire.request(CATEGORIES , method: .get , parameters: nil , encoding: URLEncoding.default, headers: header).validate().responseSwiftyJSON { (response) in
//
//        switch response.result {
//
//        case .success:
//            let data = response.value
//              //  //print(data ?? "" )
//
//            let orderArray = data?.dictionary!["categories"]?.array!
//            self.allServantsArray.removeAll()
//            for curentOrder in orderArray!{
//
//                self.allServantsArray.append(categories.init(curentOrder))
//
//            }
//         //   self.tableVieww.reloadData()
//            //   self.collectionVieww.reloadData()
//
//
//        case .failure(_):
//            print("faild GET_CATEGORIES")
//        }
//
//    }
//}



