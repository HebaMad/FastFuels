//
//  VCNoInternet.swift
//  FastFual
//
//  Created by Basim on 5/10/21.
//

import UIKit

class VCNoInternet: UIViewController {

    
    
    @IBOutlet var buTryAgain: UIButton!{
        didSet {
            buTryAgain.addTarget(self, action: #selector(self.buTryAgainPressed), for: .touchUpInside)
           } }
           @objc func buTryAgainPressed() {
            
            print ("aslashodxsadsai;pdnabsd")
            if Reachability.isConnectInternt() == true {
                self.dismiss(animated: true, completion: nil)
            } else {
    //            print("Internet connection FAILED")
    //            self.alert(message: "تأكد من اتصال جهازك بالإنترنت.", title: "لا اتصال بالانترنت", btn_actions: ["تم"])
            }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


}
