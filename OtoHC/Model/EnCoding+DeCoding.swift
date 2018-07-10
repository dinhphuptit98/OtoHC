//
//  EnCoding+DeCoding.swift
//  OtoHC
//
//  Created by NguyenDinhPhu on 09/07/2018.
//  Copyright © 2018 NguyenDinhPhu. All rights reserved.
//
import UIKit

extension String {
    /// Encode a String to Base64
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
    /// Decode a String from Base64. Returns nil if unsuccessful.
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}