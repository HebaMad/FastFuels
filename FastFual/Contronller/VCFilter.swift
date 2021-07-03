//
//  VCFilter.swift
//  FastFual
//
//  Created by Basim on 1/21/21.
//

import UIKit
//import KOLocalizedString
import Alamofire
import ObjectMapper

class VCFilter: UIViewController {
    var parameters: Parameters = [:]
    var popBlock:(([String])->Void)?
    //
    var sdata:[FilterData]=[]
    
    @IBOutlet weak var la0SortBy: UILabel!
    { didSet {
        //  la0SortBy.text = KOLocalizedString("KeySortBy")
    } }
    
    
    @IBOutlet weak var laSelected: UILabel!
    
    
    
    
    
    
    @IBOutlet weak var buExit: UIButton!
    { didSet {
        buExit.addTarget(self, action: #selector(self.buExitPressed), for: .touchUpInside)
        
    }        }
    
    @objc func buExitPressed() {
        self.sheetViewController?.dismissTapped()
        
    }
    
    @IBOutlet weak var buSortNow: UIButton!
    { didSet {
        buSortNow.addTarget(self, action: #selector(self.buSortNowPressed), for: .touchUpInside)
 //       buSortNow.setTitle(KOLocalizedString("KeySortNow"), for: .normal)
        
    }        }
    
    @objc func buSortNowPressed() {
        
        
        DispatchQueue.main.async
        {
           self.sheetViewController?.dismissTapped()
            self.popBlock?(["goToFilterList", "\(self.laSelected.text!)" , "\(self.selectOrder)" , "45.265" , "532.2"])
            
        }
    }
    
    @IBOutlet var collectionViewMe: UICollectionView!
    
    func setSetting (){
        
        collectionViewMe.delegate = self
        collectionViewMe.dataSource = self
        let nibName = UINib(nibName: "CVCFilter", bundle:nil)
        
        collectionViewMe.register(nibName, forCellWithReuseIdentifier: "CVCFilter")
        collectionViewMe.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSetting ()
        
        
    }
    
    
    let arry = [NSLocalizedString("Most Ordered", comment: ""),NSLocalizedString("Near by", comment: ""),NSLocalizedString("Opening Now", comment: "")]
    
    
    var selectIndx = -1
    var selectOrder = ""
}

extension VCFilter :  UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        self.selectIndx = indexPath.row
        
        self.collectionViewMe.reloadData()
        
        if indexPath.row == 0 {
            
            self.selectOrder = NSLocalizedString("Most Ordered", comment: "")
            
        }else if indexPath.row == 1 {
            self.selectOrder = NSLocalizedString("Near by", comment: "")
            
        }else if indexPath.row == 2 {
            self.selectOrder = NSLocalizedString("Opening Now", comment: "")
        }

            self.laSelected.text = self.arry[indexPath.row]
   
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arry.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVCFilter", for: indexPath) as! CVCFilter

            let curuntOjec = self.arry[indexPath.item]
            cell.laType.text = curuntOjec


        if indexPath.row ==  self.selectIndx {
            
            cell.buSelect.setImage(UIImage.init(named:"p012" ), for: .normal)
            
        }else {
            cell.buSelect.setImage(UIImage.init(named:"p00"), for: .normal)
            
        }
        
        cell.buSelect.isUserInteractionEnabled = false

        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //        let vv = WIDTH  - 10.0
        let vv =  collectionView.frame.width  - 0.0
        
        
        
        return CGSize(width: vv / 1.0 , height: 55.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}
