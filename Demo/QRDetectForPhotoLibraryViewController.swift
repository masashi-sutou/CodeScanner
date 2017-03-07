//
//  QRDetectForPhotoLibraryViewController.swift
//  CodeScanner
//
//  Created by 須藤 将史 on 2017/02/15.
//  Copyright © 2017年 masashi_sutou. All rights reserved.
//

import UIKit
import CodeScanner

private extension Selector {
    static let albumButtonTapped = #selector(QRDetectForPhotoLibraryViewController.albumButtonTapped(_:))
}

final class QRDetectForPhotoLibraryViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    private var scrollView: UIScrollView = UIScrollView()
    private var imageView: UIImageView = UIImageView(image: UIImage(named: "no_image"))
    private var textView: UITextView = UITextView()
    private var picker: UIImagePickerController?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.title = "Detect QR code in photo"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "album", style: .done, target: self, action: .albumButtonTapped)
        self.view.backgroundColor = .groupTableViewBackground
        
        self.picker = UIImagePickerController()
        self.picker?.sourceType = .photoLibrary
        self.picker?.delegate = self
        
        self.imageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.width)
        self.imageView.contentMode = .scaleAspectFit
        
        self.textView = UITextView(frame: CGRect(x: 0, y: self.imageView.frame.origin.y + self.imageView.frame.height + 10, width: self.view.frame.width, height: 100))
        self.textView.text = "[Not Found QR Code in Photo]"
        self.textView.textColor = .white
        self.textView.textAlignment = .center
        self.textView.backgroundColor = .gray
        self.textView.font = UIFont.systemFont(ofSize: 18)
        self.textView.isEditable = false
        self.textView.dataDetectorTypes = .link
        
        self.scrollView = UIScrollView(frame: self.view.frame)
        self.scrollView.addSubview(self.imageView)
        self.scrollView.addSubview(self.textView)
        
        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.textView.frame.origin.y + self.textView.frame.height)
        self.view.addSubview(self.scrollView)
    }
    
    func albumButtonTapped(_ sender: UIBarButtonItem) {
        
        // Determine whether library is available
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            self.present(self.picker!, animated: true, completion: nil)
        }
    }
    
    // MARK: UINavigationControllerDelegate, UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            // display image
            self.imageView.image = selectedImage
            
            // display text
            let messages: [String] = Code.detectQRCodes(image: selectedImage)
            if messages.count > 0 {
                self.textView.text = messages.first
            } else {
                self.textView.text = "[Not Found QR Code in Photo]"
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
}
