//
//  Attribute.swift
//  constraints-kit
//
//  Created by Astemir Eleev on 06/11/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import Foundation

public enum Attribute {
    case top, bottom, left, right, aspect, width, height, centerX, centerY, lastBaseline, firstBaseline
}

internal extension Attribute {
    
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
