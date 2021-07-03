//
//  VCSPTab.swift
//  FastFual
//
//  Created by macbook on 5/22/21.
//


import UIKit
import XLPagerTabStrip

class VCSPTab: ButtonBarPagerTabStripViewController {

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
            UserDefaults.standard.set(1, forKey: "tab")
        }
        // Do any additional setup after loading the view.
    }

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
  
        let second = VCSPProfileDetails()
//        UIStoryboard.mainStoryBoard.instantiateViewController(withIdentifier: "VCSPProfileDetails")

           
        (second as? VCSPProfileDetails)?.itemInfo = "Details"
        
     
        let first = VCSPProfileReviews()
        
//        UIStoryboard.mainStoryBoard.instantiateViewController(withIdentifier: "VCSPProfileReviews")

           
        (first as? VCSPProfileReviews)?.itemInfo = "Reviews"
        
         return [first, second]
     }

}
