//
//  CVCGasType.swift
//  FastFual
//
//  Created by macbook on 5/22/21.
//

import UIKit

class CVCGasType: UITableViewCell {
    static var identifier = "CVCGasType"

    @IBOutlet var fuelName: UILabel!
    
    @IBOutlet var QuantityNum: UILabel!
    @IBOutlet var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
