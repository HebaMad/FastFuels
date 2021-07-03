/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct Ratess : Mappable {
	var id : Int?
	var user_id : String?
	var supplier_id : Int?
	var order_number : String?
	var text : String?
	var rate : Int?
    var user_name : String?
	var deleted_at : String?
	var created_at : String?
	var updated_at : String?
	var image_user : String?
    var type : String?
    var diff:String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {
        user_name <- map["user_name"]
        type <- map["type"]
        diff <- map["diff"]

		id <- map["id"]
		user_id <- map["user_id"]
		supplier_id <- map["supplier_id"]
		order_number <- map["order_number"]
		text <- map["text"]
		rate <- map["rate"]
		deleted_at <- map["deleted_at"]
		created_at <- map["created_at"]
		updated_at <- map["updated_at"]
		image_user <- map["image_user"]
	}

}
