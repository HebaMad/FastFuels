//
//  VCPrivacyPolicy.swift
//  FastFual
//
//  Created by Basim on 5/10/21.
//

import UIKit

class VCPrivacyPolicy: UIViewController {
    var privacy:String?
    @IBOutlet weak var buBack: UIButton!
           { didSet {
               buBack.addTarget(self, action: #selector(self.buBackPressed), for: .touchUpInside)
           }        }
      
       @objc func buBackPressed() {
           self.navigationController?.popViewController(animated: true)
       }
    @IBOutlet var laPrivacy: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        laPrivacy.text = privacy
        controlBackItem(backItem: buBack)

    }


    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            self.tabBarController?.tabBar.isHidden = false

        }

        override func viewWillAppear(_ animated: Bool) {
                    super.viewWillAppear(animated)
            self.tabBarController?.tabBar.isHidden = true

        }
    func controlBackItem(backItem: UIButton){
       if L102Language.currentAppleLanguage().elementsEqual("ar"){
        if let _img = backItem.imageView{
            backItem.setImage(UIImage(cgImage: (_img.image?.cgImage!)!, scale:_img.image!.scale , orientation: UIImage.Orientation.upMirrored), for: .normal)
            
           }
       }
   }


}
