//
//  String+converter.swift
//  MSCodeScanner
//
//  Created by 須藤 将史 on 2017/02/18.
//  Copyright © 2017年 masashi_sutou. All rights reserved.
//

import Foundation

public extension String {
    
    public func convartISBN() -> String? {
        
        let v = NSString(string: self).longLongValue
        let prefix: Int64 = Int64(v / 10000000000)
        guard prefix == 978 || prefix == 979 else { return nil }
        let isbn9: Int64 = (v % 10000000000) / 10
        var sum: Int64 = 0
        var tmpISBN = isbn9
        
        var i = 10
        while i > 0 && tmpISBN > 0 {
            let divisor: Int64 = Int64(pow(10, Double(i - 2)))
            sum += (tmpISBN / divisor) * Int64(i)
            tmpISBN %= divisor
            i -= 1
        }
        
        let checkdigit = 11 - (sum % 11)
        // %lld is Long Long Intger Type, %d is Intger Type
        return String(format: "%lld%@", isbn9, (checkdigit == 10) ? "X" : String(format: "%lld", checkdigit % 11))
    }
    
    public func searchAamazon() {
        
        if let url = URL(string: String(format: "https://amazon.co.jp/dp/%@", self)) {
            UIApplication.shared.openURL(url)
        }
    }
}
