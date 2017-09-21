//
//  QRGenerateViewController.swift
//  CodeScanner
//
//  Created by 須藤 将史 on 2017/02/15.
//  Copyright © 2017年 masashi_sutou. All rights reserved.
//

import UIKit
import CodeScanner

final class QRGenerateViewController: UIViewController {
    
    private var imageView: UIImageView = UIImageView()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.title = "Generate a QR code"
        self.view.backgroundColor = .groupTableViewBackground
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "generate", style: .done, target: self, action: #selector(QRGenerateViewController.generateButtonTapped(_:)))
        
        self.imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.width))
        self.imageView.center = self.view.center
        self.imageView.image = UIImage(named: "no_image")
        self.imageView.contentMode = .scaleAspectFit
        self.view.addSubview(imageView)
    }
    
    @objc func generateButtonTapped(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Generate a QR code", message: "Enter the text you want to make into the QR code", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(_) -> Void in }))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(_) -> Void in
            if let textFields: [UITextField] = alert.textFields as [UITextField]? {
                self.imageView.image = Code.generateQRCode(text: (textFields.first?.text)!)
            }
        }))
        alert.addTextField(configurationHandler: {(_) -> Void in })
        present(alert, animated: true, completion: nil)
    }
}
