//
//  CollageItemView.swift
//  CollageView
//
//  Created by AHMET KAZIM GUNAY on 21/07/2017.
//  Copyright © 2017 Ahmet Kazım Gunay. All rights reserved.
//

import UIKit

public class CollageItemImageView: UIImageView {

    public private(set) var collageItem : CollageItem?
    
    // MARK: - Initialize
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(collageItem:CollageItem) {
        super.init(frame: .zero)
        self.collageItem = collageItem
        prepareLayoutSettings(for: collageItem)
    }
    
    private func prepareLayoutSettings(for collageItem: CollageItem) {
        
        self.contentMode                = collageItem.contentMode
        self.layer.borderColor          = collageItem.borderColor.cgColor
        self.layer.borderWidth          = collageItem.borderWidth
        self.clipsToBounds              = true
        self.isUserInteractionEnabled   = true
    }
}
