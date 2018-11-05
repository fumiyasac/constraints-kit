//
//  UIChainableConstraint+Relation.swift
//  constraints-kit
//
//  Created by Astemir Eleev on 05/11/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import UIKit

internal extension UIChainableConstraint.Relation {
    
    func convert() -> NSLayoutConstraint.Relation {
        switch self {
        case .equal:
            return .equal
        case .lessThanOrEqual:
            return .lessThanOrEqual
        case .greaterThanOrEqual:
            return .greaterThanOrEqual
        }
    }
}
