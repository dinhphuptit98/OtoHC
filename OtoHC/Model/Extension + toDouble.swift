//
//  Extension + toDouble.swift
//  OtoHC
//
//  Created by NguyenDinhPhu on 28/06/2018.
//  Copyright © 2018 NguyenDinhPhu. All rights reserved.
//

import UIKit

extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}
