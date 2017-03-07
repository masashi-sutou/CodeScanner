//
//  MSCodeScanner.swift
//  MSCodeScanner
//
//  Created by 須藤 将史 on 2017/02/15.
//  Copyright © 2017年 masashi_sutou. All rights reserved.
//

import UIKit
import AVFoundation

public class MSCodeScanner: NSObject, AVCaptureMetadataOutputObjectsDelegate {
    
    private let captureSession = AVCaptureSession()
    private var previewLayer: AVCaptureVideoPreviewLayer?
    private var captureDevice: AVCaptureDevice?

    private var types: [String]!
    private var preview: UIView!
    private var resultOutputs: (([String]) -> Void)?
    
    // scan area（0 ~ 1.0）
    private let originX: CGFloat = 0.1
    private let originY: CGFloat = 0.4
    private let width: CGFloat = 0.8
    private let height: CGFloat = 0.3

    public init(metadataObjectTypes: [String], preview: UIView) {

        super.init()
        self.types = metadataObjectTypes
        self.preview = preview
    }

    public class func requestCameraPermission(success: @escaping (Bool) -> Void) {
        
        // Determine whether camera is available
        switch AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo) {
        case .authorized:
            success(true)
        case .denied, .restricted:
            success(false)
        case .notDetermined:
            AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: { (granted) in
                DispatchQueue.main.async {
                    success(granted)
                }
            })
        }
    }
    
    public func scan(resultOutputs: @escaping ([String]) -> Void) {
        
        self.captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        do {
            let inputDevice: AVCaptureInput = try AVCaptureDeviceInput(device: self.captureDevice)
            self.captureSession.addInput(inputDevice)
            
            // AVCaptureSessionPresetHigh is the default sessionPreset value
            self.captureSession.sessionPreset = AVCaptureSessionPresetHigh

            // setting output metadata
            let metaOutput = AVCaptureMetadataOutput()
            metaOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            self.captureSession.addOutput(metaOutput)
            
            // set metadataType setting property in initialize
            metaOutput.metadataObjectTypes = self.types
            
            // capture full screen from camera
            self.previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
            self.previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            self.previewLayer?.frame = CGRect(x: 0, y: 0, width: self.preview.frame.width, height: self.preview.frame.height)
            self.preview.layer.insertSublayer(self.previewLayer!, at: 0)
            
            if let type: String = self.types.first {
                switch type {
                case AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeCode128Code:

                    // scan area
                    metaOutput.rectOfInterest = CGRect(x: originY, y: 1 - originX - width, width: height, height: width)

                    // attributed scan area
                    let pFrame: CGRect = self.preview.frame
                    let bFrame: CGRect = CGRect(x: originX * pFrame.width, y: originY * pFrame.height, width: width * pFrame.width, height: height * pFrame.height)
                    let borderView = UIView(frame: bFrame)
                    borderView.layer.borderWidth = 2
                    borderView.layer.borderColor = UIColor.red.cgColor
                    self.preview.addSubview(borderView)
                    
                case AVMetadataObjectTypeQRCode:
                    break
                default:
                    break
                }
            }
            
            // callBack
            self.resultOutputs = resultOutputs

            self.captureSession.startRunning()
            
        } catch {
            print(error)
        }
    }

    // MARK: - start, stop
    
    public func start() {

        self.captureSession.startRunning()
    }
    
    public func stop() {
        
        self.captureSession.stopRunning()
    }
    
    // MARK: - AVCaptureMetadataOutputObjectsDelegate
    
    public func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        guard let objects = metadataObjects as? [AVMetadataObject] else { return }

        var detectionStrings: [String] = []
        
        for metadataObject in objects {
            loop: for type in self.types {
                guard metadataObject.type == type else { continue }
                guard self.previewLayer?.transformedMetadataObject(for: metadataObject) is AVMetadataMachineReadableCodeObject else { continue }
                if let object = metadataObject as? AVMetadataMachineReadableCodeObject {

                    #if DEBUG
                        var text = "Scan Value: "
                        text += "\(object.stringValue)"
                        text += "\n"
                        print(text)
                    #endif

                    detectionStrings.append(object.stringValue)
                    break loop
                }
            }
        }
        
        // callBack
        if let _ = self.resultOutputs {
            self.resultOutputs!(detectionStrings)
        }
    }
}
