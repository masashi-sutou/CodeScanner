//
//  ViewController.swift
//  Demo
//
//  Created by 須藤 将史 on 2017/02/15.
//  Copyright © 2017年 masashi_sutou. All rights reserved.
//

import UIKit

final class ViewController: UITableViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.title = "MSCodeScanner-Demo"
        self.tableView = UITableView.init(frame: self.view.frame, style: .grouped)
    }
    
    // MARK: - UITableViewDelegate, UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 2
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return "Generate"
        case 1:
            return "Photo detect"
        case 2:
            return "Camera detect"
        default:
            return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "default")
        
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "QR code"
            case 1:
                cell.textLabel?.text = "Barcode"
            default:
                break
            }
        }
        
        if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "QR code"
            default:
                break
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                self.navigationController?.pushViewController(QRGenerateViewController(), animated: true)
            case 1:
                self.navigationController?.pushViewController(BarcodeGenerateViewController(), animated: true)
            default:
                break
            }
        }
        
        if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                self.navigationController?.pushViewController(QRDetectForPhotoLibraryViewController(), animated: true)
            default:
                break
            }
        }
    }
}
