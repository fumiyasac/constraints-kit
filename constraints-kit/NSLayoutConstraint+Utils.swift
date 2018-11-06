//
//  NSLayoutConstraint+Utils.swift
//  constraints-kit
//
//  Created by Astemir Eleev on 06/11/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import Foundation

extension NSLayoutConstraint {
    
    func set(priority: UILayoutPriority, isActive: Bool) {    
        self.priority = priority
        self.isActive = isActive
    }
}

