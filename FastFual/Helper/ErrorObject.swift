//
//  ErrorObject.swift
//  Tahadi
//
//  Created by iOS Developer on 7/27/19.
//  Copyright © 2019 iOS Developer. All rights reserved.
//

import Foundation
class ErrorObject: ResponseProtocol, Decodable {
    
    var status : Int?
    var name : String?
    var _description :String?
    var details :[String]?

    required init(dictionary : Dictionary<String, Any>) {
        
        if let _status = dictionary["status"] as? Int {
            self.status = _status
        }
        if let _name = dictionary["name"] as? String {
            self.name = _name
        }
        if let _description = dictionary["description"] as? String {
            self._description = _description
        }
        
        if let _details = dictionary["details"] as? [String] {
            self.details = _details
        }
        else{
            self.details = []
        }
    }
    
}
