/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct MyCartData : Mappable {
	var id : Int?
	var trella_name : String?
	var trella_size : String?
	var count_trella : Int?
	var fule_name : String?
	var fule_price : Double?
	var supplier_name : String?
	var supplier_image : String?
	var supplier_address : String?
	var create : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		id <- map["id"]
		trella_name <- map["trella_name"]
		trella_size <- map["trella_size"]
		count_trella <- map["count_trella"]
		fule_name <- map["fule_name"]
		fule_price <- map["fule_price"]
		supplier_name <- map["supplier_name"]
		supplier_image <- map["supplier_image"]
		supplier_address <- map["supplier_address"]
		create <- map["create"]
	}

}
