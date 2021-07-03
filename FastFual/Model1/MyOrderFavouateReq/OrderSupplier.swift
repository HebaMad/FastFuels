/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct OrderSupplier : Mappable {
	var id : Int?
	var name : String?
	var email : String?
	var mobile : String?
	var company_name : String?
	var company_mobile : String?
	var logo : String?
	var image : String?
	var address : String?
	var lat : Double?
	var lng : Int?
	var commercial_registry : String?
	var license : String?
	var active : Int?
	var notification : Int?
	var locale : String?
	var created_at : String?
	var updated_at : String?
	var deleted_at : String?
	var rate : Int?
	var rate_value : Rate_value?
	var rate_count : Int?
	var open : String?
	var is_favourite : String?
	var distance : Double?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		id <- map["id"]
		name <- map["name"]
		email <- map["email"]
		mobile <- map["mobile"]
		company_name <- map["company_name"]
		company_mobile <- map["company_mobile"]
		logo <- map["logo"]
		image <- map["image"]
		address <- map["address"]
		lat <- map["lat"]
		lng <- map["lng"]
		commercial_registry <- map["commercial_registry"]
		license <- map["license"]
		active <- map["active"]
		notification <- map["notification"]
		locale <- map["locale"]
		created_at <- map["created_at"]
		updated_at <- map["updated_at"]
		deleted_at <- map["deleted_at"]
		rate <- map["rate"]
		rate_value <- map["rate_value"]
		rate_count <- map["rate_count"]
		open <- map["open"]
		is_favourite <- map["is_favourite"]
		distance <- map["distance"]
	}

}
