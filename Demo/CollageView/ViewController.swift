//
//  ViewController.swift
//  CollageView
//
//  Created by AHMET KAZIM GUNAY on 24/07/2017.
//  Copyright © 2017 Ahmet Kazım Gunay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let images = [#imageLiteral(resourceName: "amsterdam"), #imageLiteral(resourceName: "istanbul"), #imageLiteral(resourceName: "camera"), #imageLiteral(resourceName: "istanbul2"), #imageLiteral(resourceName: "mirror")];
    
    @IBOutlet weak var collageView: CollageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collageView.delegate    = self
        collageView.dataSource  = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func notifyUser(message: String) -> Void {
        
        let alert = UIAlertController(title: nil,
                                      message: message,
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        let cancelAction = UIAlertAction(title: "OK",
                                         style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
    
    deinit {
        collageView.delegate    = nil
        collageView.dataSource  = nil
    }
}

extension ViewController: CollageViewDataSource {
    
    func collageViewNumberOfTotalItem(_ collageView: CollageView) -> Int {
        
        return images.count
    }
    
    func collageViewNumberOfRowOrColoumn(_ collageView: CollageView) -> Int {
        
        return 3
    }
    
    func collageViewLayoutDirection(_ collageView: CollageView) -> CollageViewLayoutDirection {
        
        return .horizontal
    }
    
    func collageView(_ collageView: CollageView, configure itemView: CollageItemImageView, at index: Int) {
        
        // MAGIC is in this code block
        // You can prepare your item here also,
        // You can fetch Images from Remote here!,
        // Customize UI for item, and etc..
        itemView.image = images[index]
        itemView.layer.borderWidth = 3
    }
}

extension ViewController: CollageViewDelegate {
    
    func collageView(_ collageView: CollageView, didSelect itemView: CollageItemImageView, at index: Int) {
        
        let message = "didSelect at index:  \(index), rowIndex: \(String(describing: itemView.collageItem!.rowIndex))"
        notifyUser(message: message)
    }
}

