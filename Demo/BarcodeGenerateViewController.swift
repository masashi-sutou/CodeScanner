//
//  BarcodeGenerateViewController.swift
//  MSCodeScanner
//
//  Created by 須藤 将史 on 2017/02/15.
//  Copyright © 2017年 masashi_sutou. All rights reserved.
//

import UIKit
import MSCodeScanner

private extension Selector {
    static let generateButtonTapped = #selector(BarcodeGenerateViewController.generateButtonTapped(_:))
}

final class BarcodeGenerateViewController: UIViewController {
    
    private var imageView: UIImageView = UIImageView()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.title = "Generate a barcode"
        self.view.backgroundColor = .groupTableViewBackground
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "generate", style: .done, target: self, action: .generateButtonTapped)
        
        self.imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.width))
        self.imageView.center = self.view.center
        self.imageView.image = UIImage(named: "no_image")
        self.imageView.contentMode = .scaleAspectFit
        self.view.addSubview(imageView)
    }
    
    func generateButtonTapped(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Generate a Barcode", message: "Enter the text you want to make into the Barcode", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(_) -> Void in }))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(_) -> Void in
            if let textFields: [UITextField] = alert.textFields as [UITextField]? {
                self.imageView.image = MSCode.generate128Barcode(text: (textFields.first?.text)!)
            }
        }))
        alert.addTextField(configurationHandler: {(_) -> Void in })
        present(alert, animated: true, completion: nil)
    }
}
