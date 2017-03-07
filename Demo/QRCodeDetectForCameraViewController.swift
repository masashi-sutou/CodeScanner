//
//  QRCodeDetectForCameraViewController.swift
//  CodeScanner
//
//  Created by 須藤 将史 on 2017/02/18.
//  Copyright © 2017年 masashi_sutou. All rights reserved.
//

import UIKit
import AVFoundation
import CodeScanner

final class QRCodeDetectForCameraViewController: UIViewController {
    
    private var scanner: CodeScanner!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.title = "Detect QR code by camera"
        self.view.backgroundColor = .groupTableViewBackground
        
        self.scanner = CodeScanner(metadataObjectTypes: [AVMetadataObjectTypeQRCode], preview: self.view)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        CodeScanner.requestCameraPermission { (success) in
            if success {
                self.scanner.scan(resultOutputs: { (outputs) in
                    print(outputs)
                })
            }
        }
    }
}
