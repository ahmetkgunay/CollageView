//
//  CollageItemView.swift
//  CollageView
//
//  Created by AHMET KAZIM GUNAY on 21/07/2017.
//  Copyright © 2017 Ahmet Kazım Gunay. All rights reserved.
//

import UIKit

public class CollageItemView: UIView {

    public private(set) var collageItem : CollageItem?
    
    lazy var imageView : UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode         = self.contentMode
        imgView.layer.borderColor   = self.layer.borderColor
        imgView.layer.borderWidth   = self.layer.borderWidth
        imgView.clipsToBounds       = true
        return imgView
    }()

    public var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    // MARK: - Initialize
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(collageItem:CollageItem) {
        super.init(frame: .zero)
        self.collageItem = collageItem
        prepareLayoutSettings(for: collageItem)
        self.addSubview(imageView)
    }
    
    private func prepareLayoutSettings(for collageItem: CollageItem) {
        
        self.contentMode                = collageItem.contentMode
        self.layer.borderColor          = collageItem.borderColor.cgColor
        self.layer.borderWidth          = collageItem.borderWidth
        self.clipsToBounds              = true
        self.isUserInteractionEnabled   = true
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = self.bounds
    }
}
