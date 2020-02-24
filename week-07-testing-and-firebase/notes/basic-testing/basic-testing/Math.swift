//
//  Math.swift
//  basic-testing
//
//  Created by Isaac Sheets on 2/24/20.
//  Copyright © 2020 Isaac Sheets. All rights reserved.
//

import Foundation


class FunMath {
    
    func add(n1: Int, n2: Int) -> Int {
        return n1 + n2
    }
    
    func divide(dividend: Double, divisor: Double)  -> Double? {
        guard divisor != 0 else {
            return nil
        }
        return dividend/divisor
    }
}
