//
//  CVCSaleCalculator.swift
//  FastFual
//
//  Created by macbook on 5/30/21.
//

import UIKit

class CVCSaleCalculator: UITableViewCell {
    static var identifier = "CVCSaleCalculator"

    
    @IBOutlet var laMachineName: UILabel!
    @IBOutlet var img: UIImageView!
    
    @IBOutlet var laPreviosReading: UILabel!
    
    @IBOutlet var currentReadingTxt: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

