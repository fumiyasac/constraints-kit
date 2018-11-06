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
        case top, bottom, left, right, aspect, width, height, centerX, centerY, lastBaseline, firstBaseline
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
    
    public enum Relation: Int {
        case lessThanOrEqual = -1
        case equal = 0
        case greaterThanOrEqual = 1
    }
    
    // MARK: - Properties
    
    internal var view: UIView
    
    // MARK: - Initializers
    
    public init(with view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view = view
    }
    
    // MARK: - Methods
    
    /// Identifies the last constraint with the given identifier
    @discardableResult public func identify(with name: String) -> UIChainableConstraint {
        if let lastConstaint = view.superview?.constraints.last {
            lastConstaint.identifier = name
        }
        return self
    }

    @discardableResult public func top(with view: UIView,
                                       anchor: AxisY,
                                       relatedBy relation: Relation = .equal,
                                       priority: UILayoutPriority = .required,
                                       offset: CGFloat = 0) -> UIChainableConstraint {
        let computedAnchor = anchored(to: view, using: anchor)
        let topAnchor = self.view.topAnchor
        let constraint: NSLayoutConstraint
        
        switch relation {
        case .equal:
            constraint = topAnchor.constraint(equalTo: computedAnchor, constant: offset)
        case .greaterThanOrEqual:
            constraint = topAnchor.constraint(greaterThanOrEqualTo: computedAnchor, constant: offset)
        case .lessThanOrEqual:
            constraint = topAnchor.constraint(lessThanOrEqualTo: computedAnchor, constant: offset)
        }
        constraint.priority = UILayoutPriority(rawValue: priority.rawValue)
        constraint.isActive = true
        
        return self
    }
    
    @discardableResult public func bottom(with view: UIView,
                                          anchor: AxisY,
                                          relatedBy relation: Relation = .equal,
                                          priority: UILayoutPriority = .required,
                                          offset: CGFloat = 0) -> UIChainableConstraint {
        let computedAnchor = anchored(to: view, using: anchor)
        let bottomAnchor = self.view.bottomAnchor
        let constraint: NSLayoutConstraint

        switch relation {
        case .equal:
            constraint = bottomAnchor.constraint(equalTo: computedAnchor, constant: offset)
        case .lessThanOrEqual:
            constraint = bottomAnchor.constraint(lessThanOrEqualTo: computedAnchor, constant: offset)
        case .greaterThanOrEqual:
            constraint = bottomAnchor.constraint(greaterThanOrEqualTo: computedAnchor, constant: offset)
        }
        constraint.priority = UILayoutPriority(rawValue: priority.rawValue)
        constraint.isActive = true
        
        return self
    }
    
    @discardableResult public func left(with view: UIView,
                                        anchor: AxisX,
                                        relatedBy realtion: Relation = .equal,
                                        priority: UILayoutPriority = .required,
                                        offset: CGFloat = 0) -> UIChainableConstraint {
        let computedAnchor = anchored(to: view, using: anchor)
        let leftAnchor = self.view.leftAnchor
        let constraint: NSLayoutConstraint
        
        switch realtion {
        case .equal:
            constraint = leftAnchor.constraint(equalTo: computedAnchor, constant: offset)
        case .greaterThanOrEqual:
            constraint = leftAnchor.constraint(greaterThanOrEqualTo: computedAnchor, constant: offset)
        case .lessThanOrEqual:
            constraint = leftAnchor.constraint(lessThanOrEqualTo: computedAnchor, constant: offset)
        }
        constraint.priority = UILayoutPriority(rawValue: priority.rawValue)
        constraint.isActive = true
        
        return self
    }
    
    @discardableResult public func right(with view: UIView,
                                         anchor: AxisX,
                                         relatedBy relation: Relation = .equal,
                                         priority: UILayoutPriority = .required,
                                         offset: CGFloat = 0) -> UIChainableConstraint {
        let computedAnchor = anchored(to: view, using: anchor)
        let rightAnchor = self.view.rightAnchor
        let constraint: NSLayoutConstraint
        
        switch relation {
        case .equal:
            constraint = rightAnchor.constraint(equalTo: computedAnchor, constant: offset)
        case .greaterThanOrEqual:
            constraint = rightAnchor.constraint(greaterThanOrEqualTo: computedAnchor, constant: offset)
        case .lessThanOrEqual:
            constraint = rightAnchor.constraint(lessThanOrEqualTo: computedAnchor, constant: offset)
        }
        constraint.priority = UILayoutPriority(priority.rawValue)
        constraint.isActive = true
        
        return self
    }
   
    @discardableResult public func constrain(using attribute: Attribute, to viewAttribute: Attribute, of relatedView: UIView, relatedBy relation: Relation = .equal, offset: CGFloat = 0, multiplier: CGFloat = 1) -> UIChainableConstraint {
        
        if let superview = view.superview {
            let constraint = NSLayoutConstraint(item: view,
                                                attribute: attribute.convert(),
                                                relatedBy: relation.convert(),
                                                toItem: relatedView,
                                                attribute: viewAttribute.convert(),
                                                multiplier: multiplier,
                                                constant: offset)
            superview.addConstraint(constraint)
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
    
    @discardableResult public func center(in view: UIView, axis: Axis, multiplier: CGFloat = 1) -> UIChainableConstraint {
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
    
    @discardableResult public func set(width value: CGFloat) -> UIChainableConstraint {
        set(value: value, to: .width)
        return self
    }
    
    @discardableResult public func set(height value: CGFloat) -> UIChainableConstraint {
        set(value: value, to: .height)
        return self
    }
    
    @discardableResult public func set(aspect value: CGFloat) -> UIChainableConstraint {
        set(value: value, to: .aspect)
        return self
    }
    
    @discardableResult public func set(value: CGFloat, to attribute: Attribute) -> UIChainableConstraint {
        guard let superview = view.superview else { return self }
        
        let constraint = attribute != .aspect ?
            NSLayoutConstraint(item: view, attribute: attribute.convert() , relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: value) :
            NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: view, attribute: .height, multiplier: value, constant: 0)
        superview.addConstraint(constraint)
        
        return self
    }
    
    // MARK: - Private methods
    
    private func anchored(to view: UIView, using anchor: AxisY) -> NSLayoutAnchor<NSLayoutYAxisAnchor> {
        guard #available(iOS 11.0, *) else {
            return (anchor == .bottom) ? view.layoutMarginsGuide.bottomAnchor : view.layoutMarginsGuide.topAnchor
        }
        return (anchor == .bottom) ? view.safeAreaLayoutGuide.bottomAnchor : view.safeAreaLayoutGuide.topAnchor
    }
    
    private func anchored(to view: UIView, using anchor: AxisX) -> NSLayoutAnchor<NSLayoutXAxisAnchor> {
        guard #available(iOS 11.0, *) else {
            return (anchor == .left) ? view.layoutMarginsGuide.leftAnchor : view.layoutMarginsGuide.rightAnchor
        }
        return (anchor == .left) ? view.safeAreaLayoutGuide.leftAnchor : view.safeAreaLayoutGuide.rightAnchor
    }
    
}
