//
//  CVCOrderF.swift
//  FastFual
//
//  Created by macbook on 6/10/21.
//

import UIKit

class CVCOrderF: UITableViewCell {
    static var identifier = "CVCOrderF"

    @IBOutlet weak var laType: UILabel!
    
   @IBOutlet weak var buSelect: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
