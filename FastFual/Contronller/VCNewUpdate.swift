//
//  VCNewUpdate.swift
//  FastFual
//
//  Created by Basim on 5/10/21.
//

import UIKit
import StoreKit

class VCNewUpdate: UIViewController , SKStoreProductViewControllerDelegate{

    
    
    @IBOutlet var buTryAgain: UIButton!{
        didSet {
            buTryAgain.addTarget(self, action: #selector(self.buTryAgainPressed), for: .touchUpInside)
           } }
           @objc func buTryAgainPressed() {
            
            self.openStoreProductWithiTunesItemIdentifier(identifier: "1530443446")

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    
    func openStoreProductWithiTunesItemIdentifier(identifier: String) {
        let storeViewController = SKStoreProductViewController()
        storeViewController.delegate = self

        let parameters = [ SKStoreProductParameterITunesItemIdentifier : identifier]
        storeViewController.loadProduct(withParameters: parameters) { [weak self] (loaded, error) -> Void in
            if loaded {
                // Parent class of self is UIViewContorller
                self?.present(storeViewController, animated: true, completion: nil)
            }
        }
    }

    
    
    func productViewControllerDidFinish(_ viewController: SKStoreProductViewController) {
        
        if viewController != nil {
            dismiss(animated: true)
        }
    }


}
