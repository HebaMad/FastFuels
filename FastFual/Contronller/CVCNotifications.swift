//
//  CVCNotifications.swift
//  FastFual
//
//  Created by macbook on 5/31/21.
//

import UIKit

class CVCNotifications: UITableViewCell {
    static var identifier = "CVCNotifications"

    @IBOutlet var orderTime: UILabel!
   
    @IBOutlet var orderNum: UILabel!

    @IBOutlet var body: UILabel!
    @IBOutlet var tiltle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
