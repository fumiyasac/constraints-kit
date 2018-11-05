//
//  UIChainableConstraint+Axis.swift
//  constraints-kit
//
//  Created by Astemir Eleev on 05/11/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import UIKit

internal extension UIChainableConstraint.Axis {
    
    func convert() -> UIChainableConstraint.Attribute {
        switch self {
        case .horizontal:
            return .centerX
        case .vertical:
            return .centerY
        }
    }
}
