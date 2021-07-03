//
//  CheckOutReq.swift
//  FastFual
//
//  Created by macbook on 6/4/21.
//

import Foundation
import ObjectMapper

struct CheckOutReq : Mappable {
    var success : Bool?
    var data : [String]?
    var message : String?
    var status : Int?
    var order_number : Int?
    
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        order_number <- map["order_number"]

        success <- map["success"]
        data <- map["data"]
        message <- map["message"]
        status <- map["status"]
    }

}
