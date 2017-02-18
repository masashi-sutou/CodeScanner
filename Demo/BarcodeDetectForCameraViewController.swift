//
//  BarcodeDetectForCameraViewController.swift
//  MSCodeScanner
//
//  Created by 須藤 将史 on 2017/02/17.
//  Copyright © 2017年 masashi_sutou. All rights reserved.
//

import UIKit
import AVFoundation
import MSCodeScanner

final class BarcodeDetectForCameraViewController: UIViewController {
    
    private var scanner: MSCodeScanner!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.title = "Detect barcode by camera"
        self.view.backgroundColor = .groupTableViewBackground
        
        self.scanner = MSCodeScanner(metadataObjectTypes: [AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeCode128Code], preview: self.view)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        MSCodeScanner.requestCameraPermission { (success) in
            if success {
                self.scanner.scan(frame: self.view.frame, resultOutputs: { (outputs) in
                    outputs.first?.convartISBN()?.searchAamazon()
                    print(outputs)
                })
            }
        }
    }
}
