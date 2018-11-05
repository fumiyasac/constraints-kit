//
//  UIChainableConstraint+SizeProperties.swift
//  constraints-kit
//
//  Created by Astemir Eleev on 05/11/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import UIKit

public extension UIChainableConstraint {
    
    public var width: CGFloat {
        set(value) {
            set(value: value, to: .width)
        }
        get {
            return view.bounds.width
            
        }
    }
    
    public var height: CGFloat {
        set(value) {
            set(value: value, to: .height)
        }
        get {
            return view.bounds.height
        }
    }
    
    public var aspect: CGFloat {
        set(value) {
            set(value: value, to: .aspect)
        }
        get {
            return view.bounds.width / view.bounds.height
        }
    }
    
}
