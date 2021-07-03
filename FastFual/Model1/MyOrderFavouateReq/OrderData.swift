/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com



For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct OrderData : Mappable {
	var id : Int?
	var order_number : Int?
	var items : Int?
	var order_time : String?
	var additional_note : String?
	var quantity : Int?
	var size : String?
	var coupon : String?
	var vat : Int?
	var total : Int?
	var create : String?
	var supplier : Supplier?
	var fuels : [Fuell]?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		id <- map["id"]
		order_number <- map["order_number"]
		items <- map["items"]
		order_time <- map["order_time"]
		additional_note <- map["additional_note"]
		quantity <- map["quantity"]
		size <- map["size"]
		coupon <- map["coupon"]
		vat <- map["vat"]
		total <- map["total"]
		create <- map["create"]
		supplier <- map["supplier"]
		fuels <- map["fuels"]
	}

}
