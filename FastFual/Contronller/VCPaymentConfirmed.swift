//
//  VCPaymentConfirmed.swift
//  FastFual
//
//  Created by Basim on 5/8/21.
//

import UIKit

class VCPaymentConfirmed: UIViewController {
    var orderNumber=0

    @IBOutlet var laCode: UILabel!
    @IBOutlet var buBackToHome: UIButton!{
        didSet {
            buBackToHome.addTarget(self, action: #selector(self.buBackToHomePressed), for: .touchUpInside)
           } }
           @objc func buBackToHomePressed() {
            goToStart()
            
           }
    
    @IBOutlet var buTrackOrder: UIButton!{
        didSet {
            buTrackOrder.addTarget(self, action: #selector(self.buTrackOrderPressed), for: .touchUpInside)
           } }
           @objc func buTrackOrderPressed() {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        laCode.text = "#OR" + "\(orderNumber)"

    }

    override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           self.tabBarController?.tabBar.isHidden = false

       }

       override func viewWillAppear(_ animated: Bool) {
                   super.viewWillAppear(animated)
           self.tabBarController?.tabBar.isHidden = true

       }
    func goToStart(){
            guard let window = UIApplication.shared.keyWindow else {return}
                                      
                                      UIView.transition(with: window , duration: 0.5, options: .transitionFlipFromLeft, animations: {
                                        
                                        let storyboard1 = UIStoryboard(name: "Main", bundle: nil)
                                                                  
                   let vc = storyboard1.instantiateViewController(withIdentifier: "VCHomeStation") as! VCHomeStation
                                                           
                                        
                                       
                                        let navController = UINavigationController(rootViewController: vc)
                 guard let window = UIApplication.shared.keyWindow else {return}
                                        
                                        navController.navigationBar.isHidden = true
                                        window.rootViewController = navController

                                          
                                      }, completion: { completed in
                                          
                                      })
        }

}
