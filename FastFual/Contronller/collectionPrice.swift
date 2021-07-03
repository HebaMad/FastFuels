//
//  collectionPrice.swift
//  FastFual
//
//  Created by macbook on 6/12/21.
//

import UIKit

class collectionPrice: UITableViewController {
    @IBOutlet var displayTable: UITableView!
    var id:Int=0
    var stationId:[Int]=[]
    var trella:[String]=[]
    var workhourr:[Working_hours]=[]
    var count:Int=0
    var totalH :Int=0
    var popBlocktrella:(([String])->Void)?
    var trellaId:[Int]=[]
    var comment:[String]=[]
    var imgUrl:[String]=[]
    var time:[String]=[]
    var name:[String]=[]
    var orderNum:[String]=[]
    var typeNum:Int=0
    var favourite:Featured_providers?
    var nearaby:Nearby_providers?
    var days:[String]=[]
    var fromTime:[String]=[]
    var toTime:[String]=[]

    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()
        
        comment = UserDefaults.standard.stringArray( forKey: "comment") ?? []
        imgUrl =  UserDefaults.standard.stringArray(forKey: "imgUrl") ?? []
        time =   UserDefaults.standard.stringArray(forKey: "time") ?? []
        name =  UserDefaults.standard.stringArray(forKey: "name") ?? []
        orderNum =   UserDefaults.standard.stringArray(forKey: "orderNum") ?? []
        days = UserDefaults.standard.stringArray(forKey: "days") ?? []
        fromTime = UserDefaults.standard.stringArray(forKey: "from") ?? []
        toTime = UserDefaults.standard.stringArray(forKey: "to") ?? []
        displayTable.delegate=self
        displayTable.dataSource=self
        displayTable.reloadData()

    }


    func registerNib(){
        let nib = UINib(nibName: "CVCProfileReviews", bundle: nil)
        displayTable.register(nib, forCellReuseIdentifier: "CVCProfileReviews")
        let nib2 = UINib(nibName: "CVCProfileDetails", bundle: nil)
        displayTable.register(nib2, forCellReuseIdentifier: "CVCProfileDetails")
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return comment.count
        case 1:
            return 1
       
        default:
            print("")
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = nil
        switch indexPath.section {
        case 0:
            var cells = tableView.dequeueReusableCell(withIdentifier: "CVCProfileReviews", for: indexPath) as! CVCProfileReviews
//            cells.laOrderCode.text=orderNum[indexPath.row]
            cells.laTimeOrder.text=time[indexPath.row]
            cells.userName.text=name[indexPath.row]
            cells.laDescription.text=comment[indexPath.row]
            cells.userImg.sd_setImage(with:URL(string: imgUrl[indexPath.row]))

             cell = cells
        
        
        case 1:
        
            let cells2 = tableView.dequeueReusableCell(withIdentifier: "CVCProfileDetails", for: indexPath) as! CVCProfileDetails
//            cells2.laDate.text=days[indexPath.row]
//            cells2.laTime.text=fromTime[indexPath.row] + "-" + toTime[indexPath.row]
            cell = CVCProfileDetails()

            cell = cells2

        default:
            print("")
        }

        return cell!
    }
    
    
    

    
}
