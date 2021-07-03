//
//  VCSPProfileDetails.swift
//  FastFual
//
//  Created by Basim on 4/5/21.
//

import UIKit
import XLPagerTabStrip

class VCSPProfileDetails: UIViewController,IndicatorInfoProvider   {
    var itemInfo: IndicatorInfo = "Details"
    var day:[String]=[]
    var fromTime:[String]=[]
    var toTime:[String]=[]

   var mobile=0
    var email=""

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
    
    @IBOutlet weak var layHightTable: NSLayoutConstraint!
    
    @IBOutlet var mapImg: UIImageView!
    @IBOutlet var laEmail: UILabel!
    @IBOutlet var laMobile: UILabel!
    @IBOutlet var displayTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        displayTable.height = CGFloat(day.count*100)

        day = UserDefaults.standard.stringArray(forKey: "days") ?? []
        fromTime = UserDefaults.standard.stringArray(forKey: "from") ?? []
        toTime = UserDefaults.standard.stringArray(forKey: "to") ?? []

        laMobile.text = " +966 \(UserDefaults.standard.integer(forKey: "mobile") ?? 0)"
        laEmail.text = UserDefaults.standard.string( forKey: "email") ?? ""

        registerNib()
        
        displayTable.delegate=self
        displayTable.dataSource=self
        
        
    }

    func registerNib(){
        let nib = UINib(nibName: "CVCProfileDetails", bundle: nil)
        displayTable.register(nib, forCellReuseIdentifier: "CVCProfileDetails")
    }




}
extension VCSPProfileDetails : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return day.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CVCProfileDetails", for: indexPath) as! CVCProfileDetails
        cell.laDate.text=day[indexPath.row]
        cell.laTime.text=fromTime[indexPath.row] + "-" + toTime[indexPath.row]

return cell
    }
    
    
    
}
