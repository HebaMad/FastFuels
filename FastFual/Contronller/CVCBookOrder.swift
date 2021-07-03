//
//  CVCBookOrder.swift
//  FastFual
//
//  Created by macbook on 5/22/21.
//

import UIKit

class CVCBookOrder: UITableViewCell {
    static var identifier = "CVCBookOrder"

    @IBOutlet var viewNum: UIView!
    @IBOutlet var price: UILabel!
    @IBOutlet var num: UILabel!
    @IBOutlet var plus: UIButton!
    @IBOutlet var miuns: UIButton!
    @IBOutlet var laItem: UILabel!
    @IBOutlet var selestItem: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    
    
    
    
    
}
