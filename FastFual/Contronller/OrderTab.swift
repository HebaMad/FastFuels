//
//  OrderTab.swift
//  FastFual
//
//  Created by macbook on 5/23/21.
//

import UIKit
import XLPagerTabStrip



class OrderTab: ButtonBarPagerTabStripViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        buttonBarView.backgroundColor = UIColor.white
        settings.style.buttonBarBackgroundColor = UIColor.init(named: "Color2")!
        settings.style.buttonBarItemBackgroundColor = UIColor.white
        settings.style.selectedBarBackgroundColor = UIColor.init(named: "Color")!
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.selectedBarHeight = 2.0
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
        // Do any additional setup after loading the view.
    }

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
  
        let second = VCCurrunt()
//        UIStoryboard.mainStoryBoard.instantiateViewController(withIdentifier: "VCSPProfileDetails")

           
        (second as? VCCurrunt)?.itemInfo.title =  NSLocalizedString("Currunt", comment: "")
       
     
        let first = VCHistory()
        
//        UIStoryboard.mainStoryBoard.instantiateViewController(withIdentifier: "VCSPProfileReviews")

        (first as? VCHistory)?.itemInfo.title =  NSLocalizedString("History", comment: "")
        
         return [first, second]
     }

}
