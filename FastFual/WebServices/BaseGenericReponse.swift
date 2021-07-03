//
//  BaseGenericReponse.swift
//  Notes-API
//
//  Created by Momen Reyad Sisalem on 5/31/20.
//  Copyright © 2020 Momen Reyad Sisalem. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseGenericReponse<T: Mappable> : BaseResponse {
    
    var object : T?
    var list: [T]?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        object <- map["object"]
        list <- map["list"]
    }
}
