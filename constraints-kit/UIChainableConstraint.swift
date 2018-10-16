//
//  UIChainableConstraint.swift
//  constraints-kit
//
//  Created by Astemir Eleev on 16/10/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import UIKit

public class UIChainableConstraint {
    
    // MARK: - Enums
    
    public enum Attribute {
        case top, bottom, left, right, aspect, width, height, centerX, centerY
    }
    
    public enum AxisX {
        case left, right
    }
    
    public enum AxisY {
        case top, bottom
    }
    
    public enum Axis {
        case horizontal, vertical
    }
    
    // MARK: - Properties
    
    private let view: UIView
    
    // MARK: - Initializers
    
    public init(with view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view = view
    }
    
    // MARK: - Methods
    
    @discardableResult public func top(with view: UIView, anchor: UIChainableConstraint.AxisY, offset: CGFloat = 0) -> UIChainableConstraint {
        self.view.topAnchor.constraint(equalTo: anchored(to: view, using: anchor), constant: offset).isActive = true
        return self
    }
    
    @discardableResult public func bottom(with view: UIView, anchor: UIChainableConstraint.AxisY, offset: CGFloat = 0 ) -> UIChainableConstraint {
        self.view.bottomAnchor.constraint(equalTo: anchored(to: view, using: anchor), constant: offset).isActive = true
        return self
    }
    
    @discardableResult public func left(with view: UIView, anchor: UIChainableConstraint.AxisX, offset: CGFloat = 0 ) -> UIChainableConstraint {
        self.view.leftAnchor.constraint(equalTo: anchored(to: view, using: anchor), constant: offset).isActive = true
        return self
    }
    
    @discardableResult public func right(with view: UIView, anchor: UIChainableConstraint.AxisX, offset: CGFloat = 0 ) -> UIChainableConstraint {
        self.view.rightAnchor.constraint(equalTo: anchored(to: view, using: anchor), constant: offset).isActive = true
        return self
    }
    
    @discardableResult public func constrain(using attribute: UIChainableConstraint.Attribute, to viewAttribute: UIChainableConstraint.Attribute, of relatedView: UIView, offset: CGFloat = 0, multiplier : CGFloat = 1) -> UIChainableConstraint {
        
        if let sup = view.superview {
            let constraint = NSLayoutConstraint(item: view, attribute: attribute.convert(), relatedBy: .equal, toItem: relatedView, attribute: viewAttribute.convert(), multiplier: multiplier, constant: offset)
            sup.addConstraint(constraint)
        }
        return self
    }
    
    public func fit(inside view: UIView, offset: CGFloat = 0) {
        constrain(using: .top, to: .top, of: view, offset: offset, multiplier: 1)
            .constrain(using: .bottom, to: .bottom, of: view, offset: offset, multiplier: 1)
            .constrain(using: .left, to: .left, of: view, offset: offset, multiplier: 1)
            .constrain(using: .right, to: .right, of: view, offset: offset, multiplier: 1)
    }
    
    @discardableResult public func center(in view: UIView) -> UIChainableConstraint {
        self.view.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.view.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return self
    }
    
    @discardableResult public func center(in view: UIView, axis: UIChainableConstraint.Axis, multiplier: CGFloat = 1) -> UIChainableConstraint{
        let anchor = axis.convert()
        constrain(using: anchor, to: anchor, of: view, offset: 0, multiplier: multiplier)
        return self
    }
    
    @discardableResult public func width(of view: UIView, multiplier: CGFloat = 1) -> UIChainableConstraint {
        self.view.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: multiplier).isActive = true
        return self
    }
    
    @discardableResult public func height(of view: UIView, multiplier: CGFloat = 1) -> UIChainableConstraint {
        self.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: multiplier).isActive = true
        return self
    }
    
    @discardableResult func set(value: CGFloat, to attribute: UIChainableConstraint.Attribute) -> UIChainableConstraint {
        guard let superview = view.superview else { return self }
        
        let constraint = attribute != .aspect ?
            NSLayoutConstraint(item: view, attribute: attribute.convert() , relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: value) :
            NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: view, attribute: .height, multiplier: value, constant: 0)
        superview.addConstraint(constraint)
        
        return self
    }
    
    // MARK: - Private methods
    
    private func anchored(to view: UIView, using anchor: UIChainableConstraint.AxisY) -> NSLayoutAnchor<NSLayoutYAxisAnchor> {
        guard #available(iOS 11.0, *) else {
            return (anchor == .bottom) ? view.layoutMarginsGuide.bottomAnchor : view.layoutMarginsGuide.topAnchor
        }
        return (anchor == .bottom) ? view.safeAreaLayoutGuide.bottomAnchor : view.safeAreaLayoutGuide.topAnchor
    }
    
    private func anchored(to view: UIView, using anchor: UIChainableConstraint.AxisX) -> NSLayoutAnchor<NSLayoutXAxisAnchor> {
        guard #available(iOS 11.0, *) else {
            return (anchor == .left) ? view.layoutMarginsGuide.leftAnchor : view.layoutMarginsGuide.rightAnchor
        }
        return (anchor == .left) ? view.safeAreaLayoutGuide.leftAnchor : view.safeAreaLayoutGuide.rightAnchor
    }
    
}

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

private extension UIChainableConstraint.Attribute {
    
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
        default:
            return .notAnAttribute
        }
    }
}

private extension UIChainableConstraint.Axis {
    
    func convert() -> UIChainableConstraint.Attribute {
        switch self {
        case .horizontal:
            return .centerX
        case .vertical:
            return .centerY
        }
    }
}
