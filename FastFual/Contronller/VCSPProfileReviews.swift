//
//  VCSPProfileReviews.swift
//  FastFual
//
//  Created by Basim on 4/5/21.
//

import UIKit
import XLPagerTabStrip
import SDWebImage
class VCSPProfileReviews: UIViewController,IndicatorInfoProvider  {
    var rating:[Int]?

    var rateValue:[Int]?
    var rateC:Int?
    var ratee:Int?

    @IBOutlet var five: UILabel!
    @IBOutlet var four: UILabel!
    @IBOutlet var three: UILabel!
    @IBOutlet var two: UILabel!
    @IBOutlet var one: UILabel!
    @IBOutlet var rate: UILabel!
    @IBOutlet var numberr: UILabel!
    @IBOutlet var ProgView: UIProgressView!
    @IBOutlet var ProgView2: UIProgressView!
    @IBOutlet var ProgView3: UIProgressView!
    @IBOutlet var ProgView4: UIProgressView!
    @IBOutlet var ProgView5: UIProgressView!

    static var identifier = "VCSPProfileReviews"
    var itemInfo: IndicatorInfo = "Reviews"
    var comment:[String]=[]
    var imgUrl:[String]=[]
    var time:[String]=[]
    var name:[String]=[]
    var orderNum:[String]=[]

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    @IBOutlet var evaluation: UIView!
    
    
    @IBOutlet var displayTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        comment=[]
        imgUrl=[]
        time=[]
        name=[]
        orderNum=[]
        rateValue=[]
        rating=[]

        ProgView.barHeight=0.8
        ProgView2.barHeight=0.8
        ProgView3.barHeight=0.8
        ProgView4.barHeight=0.8
        ProgView5.barHeight=0.8
        print(UserDefaults.standard.integer(forKey: "COUNT"))
        numberr.text="\(UserDefaults.standard.integer(forKey: "COUNT"))"
        rate.text="\(UserDefaults.standard.float(forKey: "NUM"))"

        comment = UserDefaults.standard.stringArray( forKey: "comment") ?? []
        imgUrl =  UserDefaults.standard.stringArray(forKey: "imgUrl") ?? []
        time =   UserDefaults.standard.stringArray(forKey: "time") ?? []
        name =  UserDefaults.standard.stringArray(forKey: "name") ?? []
        orderNum =   UserDefaults.standard.stringArray(forKey: "orderNum") ?? []
        displayTable.height = CGFloat(comment.count*130)
        rateValue = UserDefaults.standard.array(forKey: "preview") as? [Int] ?? []
        
        rating = UserDefaults.standard.array(forKey: "rating") as? [Int] ?? []
        print(rating)

        one.text = "\(rateValue?[0] ?? 0) "
        two.text = "\(rateValue?[1] ?? 0) "
        three.text = "\(rateValue?[2] ?? 0) "
        four.text = "\(rateValue?[3] ?? 0) "
        five.text = "\(rateValue?[4] ?? 0) "

        ProgView.progress = Float(Float(rateValue?[4] ?? 0)/100.0)
        ProgView2.progress = Float(Float(rateValue?[3] ?? 0)/100.0)
        ProgView3.progress = Float(Float(rateValue?[2] ?? 0)/100.0)
        ProgView4.progress = Float(Float(rateValue?[1] ?? 0)/100.0)
        ProgView5.progress = Float(Float(rateValue?[0] ?? 0)/100.0)

        registerNib()
        displayTable.delegate=self
        displayTable.dataSource=self
        // Do any additional setup after loading the view.
    }

    func registerNib(){
        let nib = UINib(nibName: "CVCProfileReviews", bundle: nil)
        displayTable.register(nib, forCellReuseIdentifier: "CVCProfileReviews")
    }


}
extension VCSPProfileReviews : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comment.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CVCProfileReviews", for: indexPath) as! CVCProfileReviews
        cell.laTimeOrder.text=time[indexPath.row]
        cell.userName.text=name[indexPath.row]
        cell.laDescription.text=comment[indexPath.row]
        cell.userImg.sd_setImage(with:URL(string: imgUrl[indexPath.row]))
        cell.rateView.rating = Double(rating?[indexPath.row] ?? 0) ?? 0.0


return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 136
 
    }
}
extension UIProgressView {

    @IBInspectable var barHeight : CGFloat {
        get {
            return transform.d * 2.0
        }
        set {
            // 2.0 Refers to the default height of 2
            let heightScale = newValue / 2.0
            let c = center
            transform = CGAffineTransform(scaleX: 1.0, y: heightScale)
            center = c
        }
    }
}
