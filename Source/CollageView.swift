//
//  CollageView.swift
//  CollageView
//
//  Created by AHMET KAZIM GUNAY on 21/07/2017.
//  Copyright © 2017 Ahmet Kazım Gunay. All rights reserved.
//

import UIKit

public enum CollageViewLayoutDirection {
    case vertical, horizontal
}

@objc public protocol CollageViewDelegate: NSObjectProtocol {
    
    @objc optional func collageView(_ collageView: CollageView, didSelect itemView: CollageItemView, at index: Int)
}

public protocol CollageViewDataSource: NSObjectProtocol {
    
    func collageViewNumberOfRowOrColoumn(_ collageView: CollageView) -> Int
    func collageViewNumberOfTotalItem(_ collageView: CollageView) -> Int
    func collageViewLayoutDirection(_ collageView: CollageView) -> CollageViewLayoutDirection
    func collageView(_ collageView: CollageView, configure itemView:CollageItemView, at index: Int)
}

open class CollageView: UIView {
    
    public typealias rowIndex = (x:Int, y:Int)
    
    // MARK: - Public Properties
    
    open private(set) var imageViews                        = Array<CollageItemView>()
    open var layoutDirection : CollageViewLayoutDirection   = .vertical
    open private(set) var rowOrColoumnCount : Int           = 0
    open private(set) var itemCount                         = 0

    weak open var delegate : CollageViewDelegate?
    weak open var dataSource: CollageViewDataSource? {
        didSet {
            setup()
        }
    }
    
    // MARK: Initialize
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // MARK: Inline Helpers
    
    fileprivate func addImageViews() {
        
        for i in 0..<itemCount {
            
            let itemView = createImageView(i)
            self.dataSource?.collageView(self, configure: itemView, at: i)
            addTapGesture(to: itemView)
            imageViews.append(itemView)
            self.addSubview(itemView)
        }
    }
    
    public func reload() {
        clearAll()
        setup()
    }
    
    private func setup() {
        
        guard let dataSource = dataSource else { return }
        
        itemCount                   = dataSource.collageViewNumberOfTotalItem(self)
        layoutDirection             = dataSource.collageViewLayoutDirection(self)
        rowOrColoumnCount           = dataSource.collageViewNumberOfRowOrColoumn(self)
        
        assert(itemCount >= rowOrColoumnCount, "Image count can not be more than row Count")
        
        addImageViews()
    }
    
    public func clearAll() {
        
        imageViews.removeAll()
        itemCount           = 0
        layoutDirection     = .vertical
        rowOrColoumnCount   = 0
        self.subviews.forEach { $0.removeFromSuperview() }
        
        self.subviews.lazy.filter { $0 is CollageItemView }
            .flatMap { $0.gestureRecognizers ?? [] }
            .forEach { $0.view?.removeGestureRecognizer($0) }
    }
    
    // MARK: Tap Gesture 
    
    fileprivate func addTapGesture(to itemView: CollageItemView) {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        itemView.addGestureRecognizer(tapGesture)
    }
    
    @objc fileprivate func handleTap(_ sender: UITapGestureRecognizer) {
        
        let itemView = sender.view as! CollageItemView
        guard let item = itemView.collageItem else { return }
        
        self.delegate?.collageView?(self, didSelect: itemView, at: item.indexForImageArray)
    }
    
    // MARK: - Layout

    override open func layoutSubviews() {
        super.layoutSubviews()
        
        for imageView in imageViews where rowOrColoumnCount != 0 {
            
            guard let collageItem = imageView.collageItem else { return }
            imageView.frame = frameAtIndex(rowIndex: collageItem.rowIndex)
        }
    }
}

extension CollageView {
    
    fileprivate func createImageView(_ index:Int) -> CollageItemView {
        
        let rowIndex = rowIndexForItem(at: index)
        
        let item = CollageItem(borderWidth: 1, borderColor: .white, contentMode: .scaleAspectFill, rowIndex: rowIndex, indexForImageArray : index)
        return CollageItemView(collageItem: item)
    }
    
    private func rowIndexForItem(at index:Int) -> rowIndex {
        
        var returnRowIndex = (0, 0)
        
        if rowOrColoumnCount == 0 {
            return returnRowIndex
        }
        
        switch self.layoutDirection {
        case .horizontal:
            returnRowIndex = (index%rowOrColoumnCount, Int(index / rowOrColoumnCount))
            break
        case.vertical:
            returnRowIndex = (Int(index / rowOrColoumnCount), index%rowOrColoumnCount)
            break
        }
        
        return returnRowIndex
    }
    
    public func frameAtIndex(rowIndex:rowIndex) -> CGRect {
        
        let mode          = modeValue(for: itemCount)
        let fullyDivided  = isFullyDivided(forMode: mode)
        let quotient      = quotientValue(for: itemCount)

        var widthDivider  = CGFloat(0)
        var heightDivider = CGFloat(0)
        
        switch layoutDirection {
        case .horizontal:
            let isRemainingRow  = rowIndex.y == quotient
            widthDivider        = !isRemainingRow ? CGFloat(rowOrColoumnCount) : CGFloat(mode)
            heightDivider       = fullyDivided ? CGFloat(quotient) : CGFloat(quotient + 1)
            break
        case .vertical:
            let isRemainingRow  = rowIndex.x == quotient
            widthDivider        = fullyDivided ? CGFloat(quotient) : CGFloat(quotient + 1)
            heightDivider       = !isRemainingRow ? CGFloat(rowOrColoumnCount) : CGFloat(mode)
            break
        }
        
        let width   = self.frame.size.width / widthDivider
        let height  = self.frame.size.height / heightDivider
        let xOrigin = CGFloat(rowIndex.x) * width
        let yOrigin = CGFloat(rowIndex.y) * height

        return CGRect(x: xOrigin, y: yOrigin, width: width, height: height)
    }
    
    private func modeValue(for itemCount: Int) -> Int {
        
        return itemCount % rowOrColoumnCount
    }
    
    private func isFullyDivided(forMode:Int) -> Bool {
        
        return forMode == 0
    }
    
    private func quotientValue(for itemCount: Int) -> Int {
        
        return itemCount / rowOrColoumnCount
    }
}
