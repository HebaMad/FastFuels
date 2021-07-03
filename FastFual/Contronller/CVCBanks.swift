//
//  CVCBanks.swift
//  FastFual
//
//  Created by macbook on 5/31/21.
//

import UIKit

class CVCBanks: UITableViewCell {
    static var identifier = "CVCBanks"

    @IBOutlet var logo: UIImageView!
    @IBOutlet var userName: UILabel!
    
    @IBOutlet var accountNum: UILabel!
    @IBOutlet var iban: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
