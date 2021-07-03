/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct ValidationData : Mappable {
	var id : Int?
	var name : String?
	var mobile : String?
	var email : String?
	var image : String?
	var type : String?
	var address : String?
	var mobile_update : String?
	var verify : Int?
	var available : Int?
	var locale : String?
	var notification_count : Int?
	var un_reade_notification_count : Int?
	var create : String?
	var access_token : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		id <- map["id"]
		name <- map["name"]
		mobile <- map["mobile"]
		email <- map["email"]
		image <- map["image"]
		type <- map["type"]
		address <- map["address"]
		mobile_update <- map["mobile_update"]
		verify <- map["verify"]
		available <- map["available"]
		locale <- map["locale"]
		notification_count <- map["notification_count"]
		un_reade_notification_count <- map["un_reade_notification_count"]
		create <- map["create"]
		access_token <- map["access_token"]
	}

}
