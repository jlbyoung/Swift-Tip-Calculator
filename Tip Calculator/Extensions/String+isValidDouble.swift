//
//  String+isValidDouble.swift
//  Tip Calculator
//
//  Created by James Young on 2/1/18.
//  Copyright © 2018 James Young. All rights reserved.
//

import Foundation

extension String{
    func isValidDouble(maxDecimals: Int) -> Bool
    {
        let formatter = NumberFormatter()
        formatter.allowsFloats = true
        let decimalSeparator = formatter.decimalSeparator ?? "."
        
        if(formatter.number(from: self)) != nil{
            let split = self.components(separatedBy: decimalSeparator)
            
            let digits = split.count == 2 ? split.last ?? "" : ""
            
            return digits.characters.count <= maxDecimals
        }
        return false
    }
}
