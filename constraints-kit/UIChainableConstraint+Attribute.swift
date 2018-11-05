//
//  UIChainableConstraint+Attribute.swift
//  constraints-kit
//
//  Created by Astemir Eleev on 05/11/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import UIKit

internal extension UIChainableConstraint.Attribute {
    
    func convert() -> NSLayoutConstraint.Attribute {
        switch self {
        case .top:
            return .top
        case .bottom:
            return .bottom
        case .left:
            return .leading
        case .right:
            return .trailing
        case .width:
            return .width
        case .height:
            return .height
        case .centerX:
            return .centerX
        case .centerY:
            return .centerY
        case .lastBaseline:
            return .lastBaseline
        case .firstBaseline:
            return .firstBaseline
        default:
            return .notAnAttribute
        }
    }
}
