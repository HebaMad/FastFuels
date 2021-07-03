//
//  UIViewControllerExtension.swift
//  FittedSheets
//
//  Created by Gordon Tucker on 8/28/18.
//  Copyright © 2018 Gordon Tucker. All rights reserved.
//

import UIKit

extension UIViewController {
    /// The sheet view controller presenting the current view controller heiarchy (if any)
    public var sheetViewController: SheetViewController? {
        var parent = self.parent
        while let currentParent = parent {
            if let sheetViewController = currentParent as? SheetViewController {
                return sheetViewController
            } else {
                parent = currentParent.parent
            }
        }
        return nil
    }
    
 func showAlertMessage(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    func showAlertPopUp(title: String, message: String, buttonTitle1: String = "OK", buttonTitle2: String = "Cancel", buttonTitle1Style: UIAlertAction.Style = .default, buttonTitle2Style: UIAlertAction.Style = .default, action1 buttonTitle1Action: @escaping (() -> Void), action2 buttonTitle2Action: @escaping (()->Void)) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let button1 = UIAlertAction.init(title: buttonTitle1, style: buttonTitle1Style) { (action) in
            print("\(buttonTitle1) Button")
            buttonTitle1Action()
        }
        let button2 = UIAlertAction.init(title: buttonTitle2, style: buttonTitle2Style) { (action) in
            print("\(buttonTitle2) Button")
            buttonTitle2Action()
        }
        alert.addAction(button1)
        alert.addAction(button2)

//        alert.addAction(button2)
        self.present(alert, animated: true, completion: nil)
    }
}
