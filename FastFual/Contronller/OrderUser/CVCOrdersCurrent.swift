//
//  CVCOrdersCurrent.swift
//  FastFual
//
//  Created by macbook on 5/22/21.
//

import UIKit
import SDWebImage
class CVCOrdersCurrent: UITableViewCell {
    static var identifier = "CVCOrdersCurrent"
    
    var fuel:[Fuell]=[]


 var sdata:[MyOrderData]=[]


    @IBOutlet var bu1: UIButton!
    @IBOutlet var bu2: UIButton!
    @IBOutlet var displayTable: UITableView!
    
    @IBOutlet var name: UILabel!
    @IBOutlet var status: UIButton!
    @IBOutlet var orderNum: UILabel!
    @IBOutlet var orderTime: UILabel!
    @IBOutlet var totalPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerNib()
        displayTable.delegate = self
        displayTable.dataSource = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func registerNib(){
        let nib = UINib(nibName: "CVCOrderDetails", bundle: nil)
        displayTable.register(nib, forCellReuseIdentifier: "CVCOrderDetails")
    }
    
}

extension CVCOrdersCurrent :  UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return fuel.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  
         var cell = tableView.dequeueReusableCell(withIdentifier: "CVCOrderDetails") as! CVCOrderDetails
        cell.laGasType.text=fuel[indexPath.row].fuel_name ?? ""
        cell.laGasQuantity.text="\(fuel[indexPath.row].quantity ?? 0)"
        cell.laSize.text=fuel[indexPath.row].size ?? ""
        cell.laPrice.text=fuel[indexPath.row].price ?? "" + NSLocalizedString("SR", comment: "")
        cell.img.sd_setImage(with:URL(string: fuel[indexPath.row].fuel_image ?? ""))

                 return cell
        

    }
    
}


