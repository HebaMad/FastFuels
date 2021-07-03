//
//  VCAgentNewOrder.swift
//  FastFual
//
//  Created by macbook on 5/20/21.
//

import UIKit

class VCAgentNewOrder: UIViewController {

    @IBOutlet var laItem: UILabel!
    @IBOutlet var laQuality: UILabel!
    @IBOutlet var laTotal: UILabel!
    
    @IBOutlet var laFromPosition: UILabel!
    @IBOutlet var laFromLocation: UILabel!
    @IBOutlet var laFromLength: UILabel!
    
    
    @IBOutlet var laToPosition: UILabel!
    @IBOutlet var laToLocation: UILabel!
    @IBOutlet var laToLength: UILabel!
    
    
    @IBOutlet var buAccept: UIButton!{
        didSet {
            buAccept.addTarget(self, action: #selector(self.buAcceptPressed), for: .touchUpInside)
            }}
            @objc func buAcceptPressed() {
            }
    
    @IBOutlet var buReject: UIButton!{
        didSet {
            buReject.addTarget(self, action: #selector(self.buRejectPressed), for: .touchUpInside)
            }}
            @objc func buRejectPressed() {
            }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }



}
