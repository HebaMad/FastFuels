//
//  VCOrderSent.swift
//  FastFual
//
//  Created by Basim on 4/10/21.
//

    import UIKit

    class VCOrderSent: UIViewController {

var orderNumber=""
        @IBOutlet var orderNum: UILabel!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            orderNum.text="Your order code: \(orderNumber)"
            
        }
        
    
        @IBAction func Home(_ sender: Any) {
            goToStart()
        }
        
        @IBAction func buCheckOrder(_ sender: Any) {
            navigationController?.popViewController(animated: true)
        }
        override func viewWillDisappear(_ animated: Bool) {
               super.viewWillDisappear(animated)
               self.tabBarController?.tabBar.isHidden = false

           }

           override func viewWillAppear(_ animated: Bool) {
                       super.viewWillAppear(animated)
               self.tabBarController?.tabBar.isHidden = true

           }
    }
extension VCOrderSent{
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
