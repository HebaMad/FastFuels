//
//  ResponseObject.swift
//  Tahadi
//
//  Created by iOS Developer on 7/27/19.
//  Copyright © 2019 iOS Developer. All rights reserved.
//

import Foundation

class ResponseObject <T:ResponseProtocol> {
    
    fileprivate(set) var status:Int?

    fileprivate(set) var success:Bool?
    fileprivate(set) var items:[T]?
    fileprivate(set) var item:T?
    fileprivate(set) var message_ar:String?
    fileprivate(set) var message_en:String?
    fileprivate(set) var errors:[ErrorObject]?
    fileprivate(set) var data:Any?
    
    
    var keyResult:String = "result"
    
    init(dictionary:Dictionary<String, Any>,isRoot:Bool = false) {
        
        self.paresData(dictionary as NSDictionary)
        
    }
    
    convenience init(dictionary:Dictionary<String, Any>,otherKey:String = "result" , isRoot:Bool = false , isFromBasim : Bool   ) {
        
        self.init(dictionary: dictionary,isRoot:isRoot)
        
        if let respponse_ = dictionary[otherKey] as? Dictionary<String, Any>{
            
            let item = T(dictionary: respponse_)
            self.item = item
        }
        else if let items_ = dictionary[otherKey] as? Array<Dictionary<String, Any>> {
            items = []
            for itemDic in items_ {
                let item = T(dictionary: itemDic)
                items?.append(item)
            }
        } else if let respponse_ = dictionary["data"] as? Dictionary<String, Any> {
            
            
            let item = T(dictionary: respponse_)
            self.item = item
            
           // basim
            if isFromBasim == true {
                if   let resppon1 = respponse_["items"] as? Array<Dictionary<String, Any>> {
                    items = []
                             for itemDic in resppon1 {
                                 let item = T(dictionary: itemDic)
                                 items?.append(item)
                             }
                    
                   
                  
                }
                
               
            }
            
        }else if isRoot == true {
            let item = T(dictionary: dictionary)
            self.item = item
        }
    }
    
    
    func paresData(_ dictionary: NSDictionary){
        
        if let success_ = dictionary["success"] as? Bool {
            success = success_
        }else{
            success = false
        }
        //    }else{
        //      success = false
        //    }
        
        
        if let status_ = dictionary["status"] as? Int {
            status = status_
        }else{
            status = 0
        }
        
        if let items_ = dictionary[keyResult] as? Array<Dictionary<String, Any>> {
            items = []
            for itemDic in items_ {
                let item = T(dictionary: itemDic)
                items?.append(item)
            }
        }else if let respponse_ = dictionary[keyResult] as? Dictionary<String, Any>{
            
            let item = T(dictionary: respponse_)
            self.item = item
            items = [item]
        }
        else {
            self.items = []
        }
        if let _errors = dictionary["error"] as? Array<Dictionary<String, AnyObject>> {
            errors = []
            for itemDic in _errors {
                let item = ErrorObject(dictionary: itemDic)
                errors?.append(item)
            }
        }else if let respponse_ = dictionary["error"] as? Dictionary<String, Any>{
            
            let item = ErrorObject(dictionary: respponse_)
            errors = [item]
        }
        else {
            self.errors = []
        }
        
        if let message_ = dictionary["message_en"] as? String {
            
            message_en = message_
        }
        else if let message_ = dictionary["message"] as? String {
            
            message_en = message_
            message_ar = message_
        }
        else if let detail = dictionary["msg"] as? String {
            
            message_en = detail
            message_ar = detail
            print(detail)
            
        }
        if let message_ = dictionary["message_ar"] as? String {
            message_ar = message_
        }
    }
    
    func localizedError()->BaseError?{
        if let error = self.errors?.first {
            if error.name == "AuthenticationException" {
                UserDefaults.standard.removeObject(forKey: "user")
                UserDefaults.standard.removeObject(forKey: "access_token")
                UserDefaults.standard.synchronize()
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "logout"), object: nil)
                return BaseError.authLogin
            }
            return BaseError.other(title: error.details?.first ?? "")
        }
        else if let message = self.message_ar {
            return BaseError.other(title: message)

        }
        return nil
    }
}



