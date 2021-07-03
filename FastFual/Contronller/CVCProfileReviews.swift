//
//  CVCProfileReviews.swift
//  FastFual
//
//  Created by macbook on 5/22/21.
//

import UIKit
import Cosmos
class CVCProfileReviews: UITableViewCell {
    static var identifier = "CVCProfileReviews"

    @IBOutlet var rateView: CosmosView!
    @IBOutlet var laDescription: UILabel!
    @IBOutlet var evaluation: UIView!
    @IBOutlet var laTimeOrder: UILabel!
    @IBOutlet var userName: UILabel!
    @IBOutlet var userImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
