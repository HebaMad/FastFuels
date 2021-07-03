//
//  CVCOrderDetails.swift
//  FastFual
//
//  Created by macbook on 5/22/21.
//

import UIKit

class CVCOrderDetails: UITableViewCell {
    static var identifier = "CVCOrderDetails"

    @IBOutlet var img: UIImageView!
    @IBOutlet var laPrice: UILabel!
    @IBOutlet var laGasQuantity: UILabel!
    @IBOutlet var laGasType: UILabel!
    
    @IBOutlet var laSize: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
