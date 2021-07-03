////
////  Extentions.swift
////  BASIT
////
////  Created by ahmed on 1/21/19.
////  Copyright © 2019 ahmed. All rights reserved.
////
//
//import UIKit
////import FullMaterialLoader
////import IHProgressHUD
//import SDWebImage
////import SDWebImageFLPlugin
//import Kingfisher
//
//extension UIStoryboard {
//    func instanceVC<T: UIViewController>() -> T {
//        guard let vc = instantiateViewController(withIdentifier: String(describing: T.self)) as? T else {
//            fatalError("Could not locate viewcontroller with with identifier \(String(describing: T.self)) in storyboard.")
//        }
//        return vc
//    }
//    func instanceTabVC<T: UITabBarController>() -> T {
//        guard let vc = instantiateViewController(withIdentifier: String(describing: T.self)) as? T else {
//            fatalError("Could not locate viewcontroller with with identifier \(String(describing: T.self)) in storyboard.")
//        }
//        return vc
//    }
//}
//
//
////UIViewController Extentions
//extension UIViewController {
//    //simple alert
//    func showAlert(title: String, message:String, okAction: String = "Ok".localized, completion: ((UIAlertAction) -> Void)? = nil ) {
//
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: okAction, style: .default, handler: completion))
//
//        present(alert, animated: true, completion: nil)
//    }
//    //with completion
//    func showAlertWithCancel(title: String, message:String, okAction: String = "Ok".localized, completion: ((UIAlertAction) -> Void)? = nil ) {
//
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: okAction, style: .default, handler: completion))
//        alert.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel))
//        present(alert, animated: true, completion: nil)
//    }
//
//}
//
//
//extension String
//{
//
//    var localized: String {
//        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
//    }
//
//    var color: UIColor {
//        let hex = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
//        var int = UInt32()
//        Scanner(string: hex).scanHexInt32(&int)
//        let a, r, g, b: UInt32
//        switch hex.count {
//        case 3: // RGB (12-bit)
//            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
//        case 6: // RGB (24-bit)
//            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
//        case 8: // ARGB (32-bit)
//            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
//        default:
//            return UIColor.clear
//        }
//        return UIColor(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
//    }
//
//    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
//        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
//        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
//
//        return boundingBox.height
//    }
//
//    func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
//        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
//        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
//
//        return boundingBox.width
//    }
//
//}
//extension UITableView{
//
//    func registerCell(id: String) {
//        self.register(UINib(nibName: id, bundle: nil), forCellReuseIdentifier: id)
//    }
//}
//extension UIView {
//    class func fromNib<T: UIView>() -> T {
//        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
//    }
//}
//extension UICollectionView {
//
//    func registerCell(id: String) {
//        self.register(UINib(nibName: id, bundle: nil), forCellWithReuseIdentifier: id)
//    }
//}
//extension UITableView {
//    func dequeueTVCell<T: UITableViewCell>() -> T {
//        guard let cell = dequeueReusableCell(withIdentifier: String(describing: T.self)) as? T else {
//            fatalError("Could not locate viewcontroller with with identifier \(String(describing: T.self)) in storyboard.")
//        }
//        return cell
//    }
//}
////var indicator: IHProgressHUD!
//
////extension UIViewController {
////    func alert(message: String, title: String = "") {
////        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
////        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
////        alertController.addAction(OKAction)
////        self.present(alertController, animated: true, completion: nil)
////    }
////    func showIndicator()
////    {
////        IHProgressHUD.setHUD(backgroundColor: "649AB8".color)
////        IHProgressHUD.set(defaultStyle: .dark)
////
////        self.view.isUserInteractionEnabled = false
////        DispatchQueue.global(qos: .utility).async {
////            IHProgressHUD.show()
////        }
////    }
////
////    func hideIndicator()
////    {
////        self.view.isUserInteractionEnabled = true
////        DispatchQueue.global(qos: .background).async {
////            IHProgressHUD.dismissWithCompletion({
////                print ("Dismissed")
////            })
////        }
////    }
////
////}
//extension UICollectionView {
//    func dequeueCVCell<T: UICollectionViewCell>(indexPath:IndexPath) -> T {
//        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as? T else {
//            fatalError("Could not locate viewcontroller with with identifier \(String(describing: T.self)) in storyboard.")
//        }
//        return cell
//    }
//}
//extension Date {
//
//    var millisecondsSince1970:Int {
//        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
//    }
//
//    init(milliseconds:Int64) {
//        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
//    }
//
//    func toMillis() -> Int64! {
//        return Int64(self.timeIntervalSince1970 * 1000)
//    }
//}
//
//
//extension UIImageView {
//
//
//}
//extension UIImageView {
//
//    func sd_custom(url: String){
//
//        if  url.contains(".gif") {
//            self.kf.indicatorType = .activity
//            self.kf.setImage(
//                with: URL(string: url),
//                placeholder: nil,
//                options: [
//                    .scaleFactor(UIScreen.main.scale),
//                    .transition(.fade(1)),
//                    .cacheOriginalImage
//            ])
//        }else {
//
//            self.sd_setShowActivityIndicatorView(true)
//            self.sd_setIndicatorStyle(.gray)
//
//            //        self.sd_imageIndicator = SDWebImageActivityIndicator.gray
//
//            let imageView = UIImageView(image: UIImage(named: "sold"))
//
//            imageView.image = imageView.image?.imageWithColor(color1: "DDDDDD".color)
//
//
//            self.sd_setImage(with: URL(string: url), placeholderImage: imageView.image)
//        }
//    }
//
//}
//extension UIImage {
//    func imageWithColor(color1: UIColor) -> UIImage {
//        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
//        color1.setFill()
//
//        let context = UIGraphicsGetCurrentContext()
//        context?.translateBy(x: 0, y: self.size.height)
//        context?.scaleBy(x: 1.0, y: -1.0)
//        context?.setBlendMode(CGBlendMode.normal)
//
//        let rect = CGRect(origin: .zero, size: CGSize(width: self.size.width, height: self.size.height))
//        context?.clip(to: rect, mask: self.cgImage!)
//        context?.fill(rect)
//
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//
//        return newImage!
//    }
//}
//extension UIView {
//    func addTopBorderWithColor(color: UIColor, width: CGFloat) {
//        let border = CALayer()
//        border.backgroundColor = color.cgColor
//        border.frame = CGRect(x:0,y: 0, width:self.frame.size.width, height:width)
//        self.layer.addSublayer(border)
//    }
//    func addRightBorderWithColor(color: UIColor, width: CGFloat) {
//        let border = CALayer()
//        border.backgroundColor = color.cgColor
//        border.frame = CGRect(x: self.frame.size.width - width,y: 0, width:width, height:self.frame.size.height)
//        self.layer.addSublayer(border)
//    }
//
//    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
//        let border = CALayer()
//        border.backgroundColor = color.cgColor
//        border.frame = CGRect(x:0, y:self.frame.size.height - width, width:self.frame.size.width, height:width)
//        self.layer.addSublayer(border)
//    }
//
//    func addLeftBorderWithColor(color: UIColor, width: CGFloat) {
//        let border = CALayer()
//        border.backgroundColor = color.cgColor
//        border.frame = CGRect(x:0, y:0, width:width, height:self.frame.size.height)
//        self.layer.addSublayer(border)
//    }
//}
//
//
//// in swift 4 - switch NSUnderlineStyleAttributeName with NSAttributedStringKey.underlineStyle
//
//extension UIButton {
//    func underline() {
//        guard let text = self.titleLabel?.text else { return }
//
//        let attributedString = NSMutableAttributedString(string: text)
//        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
//
//        self.setAttributedTitle(attributedString, for: .normal)
//    }
//}
//
//
//
//
//enum UIUserInterfaceIdiom : Int {
//    case unspecified
//
//    case phone // iPhone and iPod touch style UI
//    case pad // iPad style UI
//}
////
////UIDevice.current.userInterfaceIdiom == .pad
////UIDevice.current.userInterfaceIdiom == .phone
////UIDevice.current.userInterfaceIdiom == .unspecified
////switch UIDevice.current.userInterfaceIdiom {
////case .phone:
////// It's an iPhone
////case .pad:
////// It's an iPad
////case .unspecified:
////    // Uh, oh! What could it be?
////}
//
//
//extension NSMutableAttributedString {
//
//    func setColorForText(textForAttribute: String, withColor color: UIColor) {
//        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)
//
//        // Swift 4.2 and above
//        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
//
//        //        // Swift 4.1 and below
//        //        self.addAttribute(NSAttributedStringKey.foregroundColor, value: color, range: range)
//    }
//
//}


import UIKit

public extension UIDevice {

    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        func mapToDevice(identifier: String) -> String { // swiftlint:disable:this cyclomatic_complexity
            #if os(iOS)
            switch identifier {
            case "iPod5,1":                                 return "iPod touch (5th generation)"
            case "iPod7,1":                                 return "iPod touch (6th generation)"
            case "iPod9,1":                                 return "iPod touch (7th generation)"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
            case "iPhone4,1":                               return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
            case "iPhone7,2":                               return "iPhone 6"
            case "iPhone7,1":                               return "iPhone 6 Plus"
            case "iPhone8,1":                               return "iPhone 6s"
            case "iPhone8,2":                               return "iPhone 6s Plus"
            case "iPhone8,4":                               return "iPhone SE"
            case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
            case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":                return "iPhone X"
            case "iPhone11,2":                              return "iPhone XS"
            case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
            case "iPhone11,8":                              return "iPhone XR"
            case "iPhone12,1":                              return "iPhone 11"
            case "iPhone12,3":                              return "iPhone 11 Pro"
            case "iPhone12,5":                              return "iPhone 11 Pro Max"
            case "iPhone12,8":                              return "iPhone SE (2nd generation)"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad (3rd generation)"
            case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad (4th generation)"
            case "iPad6,11", "iPad6,12":                    return "iPad (5th generation)"
            case "iPad7,5", "iPad7,6":                      return "iPad (6th generation)"
            case "iPad7,11", "iPad7,12":                    return "iPad (7th generation)"
            case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
            case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
            case "iPad11,4", "iPad11,5":                    return "iPad Air (3rd generation)"
            case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad mini 3"
            case "iPad5,1", "iPad5,2":                      return "iPad mini 4"
            case "iPad11,1", "iPad11,2":                    return "iPad mini (5th generation)"
            case "iPad6,3", "iPad6,4":                      return "iPad Pro (9.7-inch)"
            case "iPad7,3", "iPad7,4":                      return "iPad Pro (10.5-inch)"
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad Pro (11-inch) (1st generation)"
            case "iPad8,9", "iPad8,10":                     return "iPad Pro (11-inch) (2nd generation)"
            case "iPad6,7", "iPad6,8":                      return "iPad Pro (12.9-inch) (1st generation)"
            case "iPad7,1", "iPad7,2":                      return "iPad Pro (12.9-inch) (2nd generation)"
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro (12.9-inch) (3rd generation)"
            case "iPad8,11", "iPad8,12":                    return "iPad Pro (12.9-inch) (4th generation)"
            case "AppleTV5,3":                              return "Apple TV"
            case "AppleTV6,2":                              return "Apple TV 4K"
            case "AudioAccessory1,1":                       return "HomePod"
            case "i386", "x86_64":                          return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                                        return identifier
            }
            #elseif os(tvOS)
            switch identifier {
            case "AppleTV5,3": return "Apple TV 4"
            case "AppleTV6,2": return "Apple TV 4K"
            case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
            default: return identifier
            }
            #endif
        }

        return mapToDevice(identifier: identifier)
    }()

}


extension UITextView :UITextViewDelegate
{

    /// Resize the placeholder when the UITextView bounds change
    override open var bounds: CGRect {
        didSet {
            self.resizePlaceholder()
        }
    }

    /// The UITextView placeholder text
    public var placeholder: String? {
        get {
            var placeholderText: String?

            if let placeholderLabel = self.viewWithTag(100) as? UILabel {
                placeholderText = placeholderLabel.text
            }

            return placeholderText
        }
        set {
            if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
                placeholderLabel.text = newValue
//                placeholderLabel.sizeToFit()
            } else {
                self.addPlaceholder(newValue!)
            }
        }
    }

    /// When the UITextView did change, show or hide the label based on if the UITextView is empty or not
    ///
    /// - Parameter textView: The UITextView that got updated
    public func textViewDidChange(_ textView: UITextView) {
        if let placeholderLabel = self.viewWithTag(100) as? UILabel {
            placeholderLabel.isHidden = self.text.count > 0
        }
    }

    /// Resize the placeholder UILabel to make sure it's in the same position as the UITextView text
    private func resizePlaceholder() {
        if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
            let labelX = self.textContainer.lineFragmentPadding
            let labelY = self.textContainerInset.top - 2
            let labelWidth = self.frame.width - (labelX * 2)
            let labelHeight = placeholderLabel.frame.height

            placeholderLabel.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
        }
    }

    /// Adds a placeholder UILabel to this UITextView
    private func addPlaceholder(_ placeholderText: String) {
        let placeholderLabel = UILabel()

        placeholderLabel.text = placeholderText
        placeholderLabel.sizeToFit()

        placeholderLabel.font = self.font
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.tag = 100

        placeholderLabel.isHidden = self.text.count > 0

        self.addSubview(placeholderLabel)
        self.resizePlaceholder()
        self.delegate = self
    }
}
