/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct SettingData : Mappable {
	var name : String?
	var email : String?
	var mobile : String?
	var logo : String?
	var description_price : String?
	var whatsApp : String?
	var facebook : String?
	var twitter : String?
	var instagram : String?
	var youtube : String?
	var create : String?
    var privacy : String?
    var updated_android : Double?
    var updated_ios : Double?
    var about:String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {
        about <- map["about"]
        privacy <- map["privacy"]

		name <- map["name"]
		email <- map["email"]
		mobile <- map["mobile"]
		logo <- map["logo"]
		description_price <- map["description_price"]
		whatsApp <- map["whatsApp"]
		facebook <- map["facebook"]
		twitter <- map["twitter"]
		instagram <- map["instagram"]
		youtube <- map["youtube"]
		create <- map["create"]
        updated_android <- map["updated_android"]
        updated_ios <- map["updated_ios"]

	}

}
