//
//  CVCOrdersNew.swift
//  FastFual
//
//  Created by macbook on 5/20/21.
//

import UIKit

class CVCOrdersNew: UITableViewCell {
    static var identifier = "CVCOrdersNew"
    @IBOutlet var logo: UIImageView!

    @IBOutlet var laDate: UILabel!
    @IBOutlet var buStatus: UIButton!
    @IBOutlet var laStationName: UILabel!
    
    @IBOutlet var laOpenStatus: UILabel!
    @IBOutlet var laLength: UILabel!
    
    @IBOutlet var laFrom: UILabel!
    @IBOutlet var laFromLocation: UILabel!
    
    
    @IBOutlet var laTo: UILabel!
    @IBOutlet var laToLocation: UILabel!
    

    @IBOutlet var buComplete: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
