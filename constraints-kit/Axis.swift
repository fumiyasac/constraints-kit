//
//  Axis.swift
//  constraints-kit
//
//  Created by Astemir Eleev on 06/11/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import Foundation

public enum Axis {
    case horizontal, vertical
}

internal extension Axis {
    
    func convert() -> Attribute {
        switch self {
        case .horizontal:
            return .centerX
        case .vertical:
            return .centerY
        }
    }
}
