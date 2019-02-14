//
//  ViewController.swift
//  CollageView
//
//  Created by AHMET KAZIM GUNAY on 24/07/2017.
//  Copyright © 2017 Ahmet Kazım Gunay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    fileprivate let images = [#imageLiteral(resourceName: "amsterdam"), #imageLiteral(resourceName: "istanbul"), #imageLiteral(resourceName: "camera"), #imageLiteral(resourceName: "istanbul2"), #imageLiteral(resourceName: "mirror"), #imageLiteral(resourceName: "amsterdam"), #imageLiteral(resourceName: "istanbul"), #imageLiteral(resourceName: "camera"), #imageLiteral(resourceName: "istanbul2"), #imageLiteral(resourceName: "mirror")];
    
    fileprivate var shownImagesCount = 5
    
    fileprivate var moreImagesCount: Int {
        get {
            return images.count - shownImagesCount
        }
    }
    
    @IBOutlet weak var collageView: CollageView!
    var layoutDirection: CollageViewLayoutDirection = .horizontal
    var layoutNumberOfColomn: Int = 3

    fileprivate lazy var reOrderButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "ReOrder", style: .plain, target: self, action: #selector(self.reOrderButtonTapped(sender: )))
        return button
    }()
    
    override func loadView() {
        super.loadView()
        navigationItem.rightBarButtonItem = reOrderButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collageView.delegate    = self
        collageView.dataSource  = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        collageView.delegate    = nil
        collageView.dataSource  = nil
    }
    
    // MARK: Button Actions
    
    @objc private func reOrderButtonTapped(sender: UIBarButtonItem) {
        
        sender.tag += 1
        if sender.tag%2 == 0 {
            layoutDirection = .horizontal
            layoutNumberOfColomn = 3
        } else {
            layoutDirection = .vertical
            layoutNumberOfColomn = 2
        }
        collageView.reload()
    }
}

extension ViewController {
    
    func notifyUser(message: String) -> Void {
        
        let alert = UIAlertController(title: nil,
                                      message: message,
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        let cancelAction = UIAlertAction(title: "OK",
                                         style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
}

extension ViewController: CollageViewDataSource {
    
    func collageView(_ collageView: CollageView, configure itemView: CollageItemView, at index: Int) {
        
        // MAGIC is in this code block
        // You can prepare your item here also,
        // You can fetch Images from Remote here!,
        // Customize UI for item, and etc..
        itemView.image = images[index]
        itemView.layer.borderWidth = 3
        
        if index == shownImagesCount - 1 {
            addBlackViewAndLabel(to: itemView)
        }
    }
    
    func collageViewNumberOfTotalItem(_ collageView: CollageView) -> Int {
        
        return shownImagesCount
    }
    
    func collageViewNumberOfRowOrColoumn(_ collageView: CollageView) -> Int {
        
        return layoutNumberOfColomn
    }
    
    func collageViewLayoutDirection(_ collageView: CollageView) -> CollageViewLayoutDirection {
        
        return layoutDirection
    }
    
    // Helpers
    private func addBlackViewAndLabel(to view:UIView) {
        
        let blackView = UIView()
        blackView.backgroundColor = .black
        blackView.alpha = 0.4
        view.addSubview(blackView)
        
        addConstraints(to: blackView, parentView: view)
        
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textAlignment = .center
        label.textColor = .white
        label.text = "+\(moreImagesCount)"
        view.addSubview(label)
        
        addConstraints(to: label, parentView: view)
    }
    
    private func addConstraints(to view:UIView, parentView:UIView) {
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let horConstraint = NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal,
                                               toItem: parentView, attribute: .centerX,
                                               multiplier: 1.0, constant: 0.0)
        let verConstraint = NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal,
                                               toItem: parentView, attribute: .centerY,
                                               multiplier: 1.0, constant: 0.0)
        let widConstraint = NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal,
                                               toItem: parentView, attribute: .width,
                                               multiplier: 1, constant: 0.0)
        let heiConstraint = NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal,
                                               toItem: parentView, attribute: .height,
                                               multiplier: 1, constant: 0.0)
        
        parentView.addConstraints([horConstraint, verConstraint, widConstraint, heiConstraint])
    }
}

extension ViewController: CollageViewDelegate {
    
    func collageView(_ collageView: CollageView, didSelect itemView: CollageItemView, at index: Int) {
        
        let message = "didSelect at index:  \(index), rowIndex: \(String(describing: itemView.collageItem!.rowIndex))"
        notifyUser(message: message)
    }
}

