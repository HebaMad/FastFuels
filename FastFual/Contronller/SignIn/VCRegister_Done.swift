//
//  VCRegister_Done.swift
//  FastFual
//
//  Created by Basim on 1/4/21.
//

import UIKit
import SVProgressHUD
class VCRegister_Done: UIViewController {
    
    var type:String=""
    @IBOutlet weak var laYouraccounthaveRegistered1: UILabel!
    @IBOutlet weak var laCongrat: UILabel!
    @IBOutlet weak var buGETSTART: UIButton!
    { didSet {
        buGETSTART.addTarget(self, action: #selector(self.buGETSTARTPressed), for: .touchUpInside)
    }        }
    @objc func buGETSTARTPressed() {
        if type.elementsEqual("supervisor"){
            
            
            self.goToHomeSupervisor()
            //            let vc=UIStoryboard.mainStoryBoard.instantiateViewController(withIdentifier: "TTabBarViewController")
            //            SVProgressHUD.show(withStatus: "Please wait..")
            //            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            //            let vc=UIStoryboard.mainStoryBoard.instantiateViewController(withIdentifier: "DriverTabBarViewController")
            //            self.navigationController?.pushViewController(vc, animated: true)
            self.goToHomeDriver()
            
        }
        
    }
    
    
    func goToHomeSupervisor(){
        guard let window = UIApplication.shared.keyWindow else {return}
        
        UIView.transition(with: window , duration: 0.5, options: .transitionFlipFromLeft, animations: {
            let storyboard1 = UIStoryboard(name: "Main", bundle: nil)
            
            let vc = storyboard1.instantiateViewController(withIdentifier: "TTabBarViewController") as! TTabBarViewController
            
            window.rootViewController =  vc // UINavigationController(rootViewController: VCHome())
            
        }, completion: { completed in
            
        })
    }
    
    func goToHomeDriver(){
        guard let window = UIApplication.shared.keyWindow else {return}
        
        UIView.transition(with: window , duration: 0.5, options: .transitionFlipFromLeft, animations: {
            let storyboard1 = UIStoryboard(name: "Main", bundle: nil)
            
            let vc = storyboard1.instantiateViewController(withIdentifier: "TTabBarViewController2") as! TTabBarViewController
            
            window.rootViewController =  vc // UINavigationController(rootViewController: VCHome())
            
        }, completion: { completed in
            
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
}
