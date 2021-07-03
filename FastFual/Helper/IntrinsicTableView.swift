//
//  IntrinsicTableView.swift
//  TabelViewWithScrollView
//
//  Created by Khaled Khaldi on 7/27/15.
//  Copyright (c) 2018 iPhoneAlsham. All rights reserved.
//

import UIKit

@IBDesignable class IntrinsicTableView: UITableView {
    
    override var intrinsicContentSize : CGSize {
        // Drawing code
        layoutIfNeeded()
    
        #if TARGET_INTERFACE_BUILDER
        return CGSize(width: UIView.noIntrinsicMetric, height: 200)
        #else
        return CGSize(width: UIView.noIntrinsicMetric, height: self.contentSize.height)
        #endif

    }
    
    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
}
