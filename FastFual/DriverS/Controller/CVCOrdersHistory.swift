//
//  CVCOrdersHistory.swift
//  FastFual
//
//  Created by macbook on 5/27/21.
//

import UIKit
class CVCOrdersHistory: UITableViewCell {
    static var identifier = "CVCOrdersHistory"

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
     
    
    @IBOutlet var buRateOrder: UIButton!{
        didSet {
            buRateOrder.addTarget(self, action: #selector(self.buRateOrderPressed), for: .touchUpInside)
           } }
           @objc func buRateOrderPressed() {
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
