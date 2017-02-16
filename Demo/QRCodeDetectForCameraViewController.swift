//
//  QRCodeDetectForCameraViewController.swift
//  MSCodeScanner
//
//  Created by 須藤 将史 on 2017/02/18.
//  Copyright © 2017年 masashi_sutou. All rights reserved.
//

import UIKit
import AVFoundation
import MSCodeScanner

final class QRCodeDetectForCameraViewController: UIViewController {
    
    private var scanner: MSCodeScanner!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.title = "Detect QR code from Camera"
        self.view.backgroundColor = .groupTableViewBackground
        
        self.scanner = MSCodeScanner(metadataObjectTypes: [AVMetadataObjectTypeQRCode], preview: self.view)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        MSCodeScanner.requestCameraPermission { (success) in
            if success {
                self.scanner.scan(frame: self.view.frame, resultOutputs: { (outputs) in
                    print(outputs)
                })
            }
        }
    }
}
