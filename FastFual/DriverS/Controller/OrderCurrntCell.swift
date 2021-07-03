//
//  OrderCurrntCell.swift
//  FastFual
//
//  Created by macbook on 5/27/21.
//

import UIKit

class OrderCurrntCell: UITableViewCell {
    static var identifier = "OrderCurrntCell"
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
     
    
    @IBOutlet var delieveringAction: UIButton!{
        
        didSet {
            delieveringAction.addTarget(self, action: #selector(self.budelieveringPressed), for: .touchUpInside)
           } }
           @objc func budelieveringPressed() {
    }
    
    @IBOutlet var googleMapTrack: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
