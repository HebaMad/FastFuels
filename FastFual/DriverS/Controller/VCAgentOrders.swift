//
//  VCAgentOrders.swift
//  FastFual
//
//  Created by macbook on 5/20/21.
//

import UIKit
import XLPagerTabStrip
extension UIStoryboard{
    
    static let mainStoryBoard = UIStoryboard.init(name: "Main", bundle: nil)
}
class VCAgentOrders: ButtonBarPagerTabStripViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        buttonBarView.backgroundColor = UIColor.white
        settings.style.buttonBarBackgroundColor = UIColor.init(named: "Color2")!
        settings.style.buttonBarItemBackgroundColor = UIColor.white
        settings.style.selectedBarBackgroundColor = UIColor.init(named: "Color")!
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.selectedBarHeight = 1.5
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = UIColor.init(named: "Color")
        settings.style.selectedBarBackgroundColor=UIColor.init(named: "Color") ?? UIColor.white
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = UIColor.init(named: "Color")!
            newCell?.label.textColor = UIColor.init(named: "Color")!
        }
    }

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
    
        let third = TVCAgentOrdersNew()
            
            

           
        (third as? TVCAgentOrdersNew)?.itemInfo = "New"

        
        let second = TVCAgentOrdersCurrent()
            
            
            
     
           
        (second as? TVCAgentOrdersCurrent)?.itemInfo = "Current"
        
     
        let first = TVCAgentOrdersHistory()
//            UIStoryboard.mainStoryBoard.instantiateViewController(withIdentifier: "TVCAgentOrdersHistory")

           
        (first as? TVCAgentOrdersHistory)?.itemInfo = "History"
        
        
        
        
         return [third, second,first]
     }

}
