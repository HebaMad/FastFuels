//
//  OrderProperty.swift
//  FastFual
//
//  Created by macbook on 5/28/21.
//

import Foundation
import ObjectMapper

struct OrderProperty : Mappable {
    var id :Int?
    var status :String?
    var status_number :Int?
    var order_id :Int?
    var items :Int?
    var qty :String?
    var price :Double?
    var driver :String?
    var created :String?
    var isSelect:Bool?
init?(map: Map) {

}

mutating func mapping(map: Map) {

    id <- map["id"]
    status <- map["status"]
    status_number <- map["status_number"]
    order_id <- map["order_id"]
    items <- map["items"]
    qty <- map["qty"]
    price <- map["price"]
    driver <- map["driver"]
    created <- map["created"]


}

}
