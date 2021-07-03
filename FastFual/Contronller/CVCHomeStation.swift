//
//  CVCHomeStation.swift
//  FastFual
//
//  Created by Basim on 1/18/21.
//

import UIKit

class CVCHomeStation: UICollectionViewCell {
    static var identifier = "CVCHomeStation"

    @IBOutlet var laNum: UILabel!
    @IBOutlet var rate: UILabel!
    @IBOutlet var calender: UIImageView!
    @IBOutlet var coverPhoto: UIImageView!
    @IBOutlet var laStationName: UILabel!
    @IBOutlet var laStatus: UILabel!
    @IBOutlet var laLocation: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

