//
//  CameraHandler.swift
//  Jalesa
//
//  Created by Jalesa on 9/17/19.
//  Copyright © 2019 Basim. All rights reserved.
//

import Foundation
import UIKit
import Photos


class CameraHandler: NSObject{
    
    
    static let shared = CameraHandler()
    
    var multiSelect:Bool = false
    fileprivate var currentVC: UIViewController!
    
    //MARK: Internal Properties
    var imagePickedBlock: ((UIImage) -> Void)?
    
    func camera()
    {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self;
            myPickerController.sourceType = .camera
            currentVC.present(myPickerController, animated: true, completion: nil)
        }
        
    }
    
    func photoLibrary()
    {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self;
            myPickerController.sourceType = .photoLibrary
            currentVC.present(myPickerController, animated: true, completion: nil)
        }
        
    }
    
    
    @objc func doneButtonTap() {
        
        
    }
    func showActionSheet(vc: UIViewController,multiSelect:Bool = false) {
        currentVC = vc
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
                actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert:UIAlertAction!) -> Void in
                    self.camera()
                }))
        
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            
            self.photoLibrary()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        vc.addActionSheetForiPad(actionSheet:actionSheet)
        vc.present(actionSheet, animated: true, completion: nil)
    }
    
}


extension CameraHandler: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        currentVC.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Local variable inserted by Swift 4.2 migrator.
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        if let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage {
            self.imagePickedBlock?(image)
        }else{
            print("Something went wrong")
        }
        currentVC.dismiss(animated: true, completion: nil)
    }
    
}


// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}
