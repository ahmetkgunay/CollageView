//
//  CollageItem.swift
//  CollageView
//
//  Created by AHMET KAZIM GUNAY on 21/07/2017.
//  Copyright © 2017 Ahmet Kazım Gunay. All rights reserved.
//

import UIKit

public struct CollageItem {
    
    public private(set) var borderWidth : CGFloat = 2.0
    public private(set) var borderColor : UIColor = .white
    public private(set) var contentMode : UIView.ContentMode = .scaleAspectFill
    public private(set) var rowIndex  = (0, 0)
    public private(set) var indexForImageArray = 0
}

