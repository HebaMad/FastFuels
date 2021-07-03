//
//  CVCProfileDetails.swift
//  FastFual
//
//  Created by macbook on 5/22/21.
//

import UIKit

class CVCProfileDetails: UITableViewCell {
    static var identifier = "CVCProfileDetails"

    @IBOutlet weak var laDate: UILabel!
    @IBOutlet weak var laTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
