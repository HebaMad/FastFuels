//
//  VCOrderFilter.swift
//  FastFual
//
//  Created by macbook on 6/9/21.
//

import UIKit
import Alamofire
import ObjectMapper
class VCOrderFilter: UIViewController {
    var popBlocks:(([String])->Void)?
    var sdata:[MyOrderData]=[]
    @IBOutlet var displayTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerNib()
        displayTable.delegate=self
        displayTable.dataSource=self

    }
    
    @IBAction func buClose(_ sender: Any) {
        self.sheetViewController?.dismissTapped()
        
    }
    var selectIndx:(Int,Int)?
var selectSection = -1
    var selectRow = -1
    var OrderStatus:Int?
    var PaymentStatus:Int?
    var Ordertype:Int?
    let headerTitles = [NSLocalizedString("Order Status", comment: ""),NSLocalizedString("Payment Status", comment: "")
,    NSLocalizedString("Order type", comment: "")]
    
    let sectionOneItems = [NSLocalizedString("Pending", comment: ""),
                           
                           NSLocalizedString("Confirmed", comment: ""),
                           NSLocalizedString("Delivering", comment: ""),
                           NSLocalizedString("Canceled", comment: ""),
                           NSLocalizedString("Completed", comment: ""),

    ]
    let sectionTwoItems = [NSLocalizedString("not paid", comment: ""),
                           NSLocalizedString("payment done", comment: ""),
                           NSLocalizedString("approved for payment", comment: "")]
    
    let sectionThreeItems = [ NSLocalizedString("order", comment: ""),
                              NSLocalizedString("booking", comment: ""),
        ]
    
    func registerNib(){
        let nib = UINib(nibName: "CVCOrderF", bundle: nil)
        displayTable.register(nib, forCellReuseIdentifier: "CVCOrderF")
    }
    
    @IBAction func buFilter(_ sender: Any) {
        DispatchQueue.main.async
        {
            print(self.OrderStatus)
            print(self.PaymentStatus)
            print(self.Ordertype)

           self.sheetViewController?.dismissTapped()
            self.popBlocks?(["goToFilterList", "\(self.OrderStatus)" , "\(self.PaymentStatus)" ,"\(self.Ordertype)"])
            
        }
    }

    

}

extension VCOrderFilter: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 55
//        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return sectionOneItems.count
        case 1:
            return sectionTwoItems.count
            case 2:
            return sectionThreeItems.count
        default:
            print("")
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        headerView.backgroundColor = UIColor(named: "Color")
        
        let headerName = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        headerName.text = headerTitles[section]
        headerName.textColor = UIColor.white
        headerName.font = .systemFont(ofSize: 15, weight: .semibold)
        headerName.textAlignment = .natural
        headerView.addSubview(headerName)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CVCOrderF", for: indexPath) as! CVCOrderF
   
        switch indexPath.section {
        case 0:
            cell.laType.text = sectionOneItems[indexPath.row]
        case 1:
            cell.laType.text = sectionTwoItems[indexPath.row]
        case 2:
            cell.laType.text = sectionThreeItems[indexPath.row]
        default:
            print("")
        }
        
        
        
        if indexPath.section == selectSection{
            if selectRow==indexPath.row{
               cell.buSelect.setImage(UIImage.init(named:"p012" ), for: .normal)

            }else{
                cell.buSelect.setImage(UIImage.init(named:"p00"), for: .normal)
            }
            
        }else{

        }
           

        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectIndx = (indexPath.section,indexPath.row)
        selectSection = indexPath.section
        selectRow = indexPath.row
//        displayTable.reloadData()
        displayTable.reloadSections(IndexSet(selectSection...selectSection), with: .automatic)
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CVCOrderF", for: indexPath) as! CVCOrderF
        
        switch indexPath.section {
         case 0:
             switch indexPath.row {
             case 0:
                OrderStatus=indexPath.row
             case 1:
                OrderStatus=indexPath.row+1

             case 2:
                OrderStatus=indexPath.row+1
             case 3:
                OrderStatus=indexPath.row+1
             case 4:
                OrderStatus=indexPath.row+1
             case 5:
                OrderStatus=indexPath.row+1
             default:
                break
             }
         
            
         case 1:
             switch indexPath.row {
             case 0:
                PaymentStatus=indexPath.row
             case 1:
                PaymentStatus=indexPath.row

             case 2:
                PaymentStatus=indexPath.row

             default:
                 break
         
     
     }
        case 2:
            switch indexPath.row {
            case 0:
                Ordertype=indexPath.row
            case 1:
                Ordertype=indexPath.row

            case 2:
                Ordertype=indexPath.row

            default:
                break
    
    }
   
        default:
            break
        }

    }
}
