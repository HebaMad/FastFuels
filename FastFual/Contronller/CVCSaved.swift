//
//  SavedCollectionViewCell.swift
//  FastFual
//
//  Created by macbook on 5/22/21.
//

import UIKit

class CVCSaved: UICollectionViewCell {
    static var identifier = "CVCSaved"

    @IBOutlet var calender: UIImageView!
    @IBOutlet var laEvaluation: UILabel!
    @IBOutlet var laNum: UILabel!
    @IBOutlet var laDistance: UILabel!
    @IBOutlet var laStatus: UILabel!
    @IBOutlet var laName: UILabel!
    @IBOutlet var cover: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
