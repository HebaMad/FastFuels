//
//  CVCOrderDetailsTrack.swift
//  FastFual
//
//  Created by macbook on 5/22/21.
//

import UIKit

class CVCOrderDetailsTrack: UITableViewCell {
    static var identifier = "CVCOrderDetailsTrack"

    @IBOutlet var status2: UILabel!
    @IBOutlet var status1: UILabel!
    @IBOutlet var img: UIImageView!
    @IBOutlet var laTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
