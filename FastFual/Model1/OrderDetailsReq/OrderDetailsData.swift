/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct OrderDetailsData : Mappable {
	var id : Int?
	var order_number : Int?
	var items : Int?
	var order_time : String?
	var additional_note : String?
	var quantity : Int?
	var size : String?
	var coupon : String?
	var vat : Int?
	var total : Double?
	var status : String?
	var create : String?
	var supplier : Supplier?
	var fuels : [Fuell]?
    var status_number:Int?
    var is_rating : Bool?
    var paying:Int?
    var payment : String?

    
	init?(map: Map) {

	}

	mutating func mapping(map: Map) {
        status_number <- map["status_number"]
        is_rating <- map["is_rating"]
        paying <- map["paying"]
        payment <- map["payment"]

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
		status <- map["status"]
		create <- map["create"]
		supplier <- map["supplier"]
		fuels <- map["fuels"]
	}

}
