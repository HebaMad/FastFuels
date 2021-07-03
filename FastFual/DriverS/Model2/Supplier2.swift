/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct Supplier2 : Mappable {
	var id : Int?
	var company_name : String?
	var email : String?
	var logo : String?
	var image : String?
	var rate : Int?
	var rate_count : Int?
	var address : String?
	var lat : Double?
	var lng : Double?
	var open : String?
	var distance : Int?
	var is_favourite : String?
	var rate_value : [Int]?
	var company_mobile : String?
	var working_hours : [String]?
	var supplier_trella : [SupplierTrella2]?
	var rates : [String]?
	var order_count : Int?
	var create : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		id <- map["id"]
		company_name <- map["company_name"]
		email <- map["email"]
		logo <- map["logo"]
		image <- map["image"]
		rate <- map["rate"]
		rate_count <- map["rate_count"]
		address <- map["address"]
		lat <- map["lat"]
		lng <- map["lng"]
		open <- map["open"]
		distance <- map["distance"]
		is_favourite <- map["is_favourite"]
		rate_value <- map["rate_value"]
		company_mobile <- map["company_mobile"]
		working_hours <- map["working_hours"]
		supplier_trella <- map["supplier_trella"]
		rates <- map["rates"]
		order_count <- map["order_count"]
		create <- map["create"]
	}

}
