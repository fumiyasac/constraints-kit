//
//  UIView+ConstraintsKit.swift
//  extensions-kit
//
//  Created by Astemir Eleev on 15/10/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import UIKit

public extension UIView {
    
    /// Enables `Chainable Constraints`. Use this property to get access to the `UIChainableConstraint` API.
    public var constraint: UIChainableConstraint {
        return UIChainableConstraint(with: self)
    }
}
