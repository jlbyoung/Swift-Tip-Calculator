//
//  Tip.swift
//  Tip Calculator
//
//  Created by James Young on 2/1/18.
//  Copyright © 2018 James Young. All rights reserved.
//

import Foundation
class Tip{
    var amount:[Double] = []
    init()
    {
        amount = [0.10, 0.15, 0.20]
    }
    
    func getTips(_ index : Int) -> Double
    {
        return amount[index]
    }
    
}
