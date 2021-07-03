//
//  ViewController.swift
//  FastFual
//
//  Created by Basim on 12/31/20.
//

import UIKit
//
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        delayWithSeconds(2) {
            
            
            if UserDefaults.standard.string(forKey: "token") == nil  {
                self.navigationController?.pushViewController(VCSignIn(), animated: true)
                
            }else {
                if UserDefaults.standard.string(forKey: "typeISSupervisor") == "no"  {
                    self.goToHomeDriver()
                }else {
                    self.goToHomeSupervisor()
                }
                
                
            }
            
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
    
    
    
    
    
}
func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        completion()
    }
}

