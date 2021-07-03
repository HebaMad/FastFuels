//
//  CVCTanks.swift
//  FastFual
//
//  Created by macbook on 5/30/21.
//

import UIKit

class CVCTanks: UITableViewCell {
    static var identifier = "CVCTanks"
    @IBOutlet var laTankName: UILabel!
    @IBOutlet var laFuelType: UILabel!
    @IBOutlet var laPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
