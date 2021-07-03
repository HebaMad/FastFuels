//
//  UIFont+Swizzel.swift
//  SadaAlmustaqbal
//
//  Created by Khaled Khaldi on 11/1/19.
//  Copyright © 2019 SaDyKhAlEd. All rights reserved.
//

import UIKit

/*
 Better way to do it:
 https://gist.github.com/nikans/5993c41470174f51e17aba032ae4f046
 
 But does not work with this cairo font
 */

struct AppFontName {
    static let extreLight = "Poppins-ExtraLight"
    static let light      = "Poppins-Light"
    static let regular    = "Poppins-Regular"
    static let medium     = "Poppins-Medium"
    static let bold       = "Poppins-Bold"
    static let black      = "Poppins-Black"
    static let semiBold      = "Poppins-SemiBold"

}

//
//<string>Poppins-Black.ttf</string>
//<string>Poppins-BlackItalic.ttf</string>
//<string>Poppins-Bold.ttf</string>
//<string>Poppins-BoldItalic.ttf</string>
//<string>Poppins-ExtraBold.ttf</string>
//<string>Poppins-ExtraBoldItalic.ttf</string>
//<string>Poppins-ExtraLight.ttf</string>
//<string>Poppins-ExtraLightItalic.ttf</string>
//<string>Poppins-Italic.ttf</string>
//<string>Poppins-Light.ttf</string>
//<string>Poppins-LightItalic.ttf</string>
//<string>Poppins-Medium.ttf</string>
//<string>Poppins-MediumItalic.ttf</string>
//<string>Poppins-Regular.ttf</string>
//<string>Poppins-SemiBold.ttf</string>
//<string>Poppins-SemiBoldItalic.ttf</string>
//<string>Poppins-Thin.ttf</string>
//<string>Poppins-ThinItalic.ttf</string>

extension UIFontDescriptor.AttributeName {
    static let nsctFontUIUsage = UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")
}

extension UIFont {
    
    @objc class func mySystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.regular, size: size)!
    }
    
    @objc class func myBoldSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.bold, size: size)!
    }
    @objc class func mySemiBoldSystemFont(ofSize size: CGFloat) -> UIFont {
           return UIFont(name: AppFontName.semiBold, size: size)!
       }
    
    
    @objc convenience init(myCoder aDecoder: NSCoder) {
        guard
            let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor,
            
            let fontAttribute = fontDescriptor.fontAttributes[.nsctFontUIUsage] as? String else {
                self.init(myCoder: aDecoder)
                return
        }
        
        let fontName: String
        
        
        /*
         print("fontAttribute: \(fontAttribute)")
         fontAttribute: CTFontUltraLightUsage
         fontAttribute: CTFontThinUsage
         fontAttribute: CTFontLightUsage
         fontAttribute: CTFontRegularUsage
         fontAttribute: CTFontMediumUsage
         fontAttribute: CTFontDemiUsage
         fontAttribute: CTFontBoldUsage
         fontAttribute: CTFontHeavyUsage
         fontAttribute: CTFontBlackUsage
         */
        
        switch fontAttribute {
        case "CTFontUltraLightUsage", "CTFontThinUsage":
            fontName = AppFontName.extreLight
            
        case "CTFontLightUsage":
            fontName = AppFontName.light
            
        case "CTFontRegularUsage":
            fontName = AppFontName.regular
            
        case "CTFontMediumUsage", "CTFontDemiUsage":
            fontName = AppFontName.medium
            
        case "CTFontEmphasizedUsage", "CTFontBoldUsage":
            fontName = AppFontName.bold
            
        case "CTFontHeavyUsage", "CTFontBlackUsage":
            fontName = AppFontName.black
            
        default:
            fontName = AppFontName.regular
        }
        
        self.init(name: fontName, size: fontDescriptor.pointSize)!
    }
    
    class func overrideInitialize() {
        guard self == UIFont.self else { return }
        
        if let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:))),
            let mySystemFontMethod = class_getClassMethod(self, #selector(mySystemFont(ofSize:))) {
            method_exchangeImplementations(systemFontMethod, mySystemFontMethod)
        }
        
        if let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:))),
            let myBoldSystemFontMethod = class_getClassMethod(self, #selector(myBoldSystemFont(ofSize:))) {
            method_exchangeImplementations(boldSystemFontMethod, myBoldSystemFontMethod)
        }
        
        
        if let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:))), // Trick to get over the lack of UIFont.init(coder:))
            let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:))) {
            method_exchangeImplementations(initCoderMethod, myInitCoderMethod)
        }
    }
}

