//
//  CollageItem.swift
//  CollageView
//
//  Created by AHMET KAZIM GUNAY on 21/07/2017.
//  Copyright © 2017 Ahmet Kazım Gunay. All rights reserved.
//

import UIKit

public struct CollageItem {
    
    var borderWidth : CGFloat = 2.0
    var borderColor : UIColor = .white
    var contentMode : UIViewContentMode = .scaleAspectFill
    var rowIndex  = (0, 0)
    var indexForImageArray = 0
}

