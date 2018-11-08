//
//  NSLayoutConstraint+Utils.swift
//  constraints-kit
//
//  Created by Astemir Eleev on 06/11/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import Foundation

public extension NSLayoutConstraint {
    
    @discardableResult public func set(priority: UILayoutPriority, isActive: Bool) -> Self {
        self.priority = priority
        self.isActive = isActive
        return self
    }
    
    @discardableResult public func set(priority: UILayoutPriority) -> Self {
        self.priority = priority
        return self
    }
    
    @discardableResult public func activate() -> Self {
        isActive = true
        return self
    }
    
    @discardableResult public func deactivate() -> Self {
        isActive = false
        return self
    }
    
}
