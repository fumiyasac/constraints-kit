//
//  UIView+ConstraintsKit.swift
//  extensions-kit
//
//  Created by Astemir Eleev on 15/10/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import UIKit

public extension UIView {
    
    // MARK: Methods
    
    @discardableResult public func identify(with name: String) -> UIView {
        if let lastConstaint = superview?.constraints.last {
            lastConstaint.identifier = name
        }
        return self
    }
    
    // MARK: - Constraining
    
    @discardableResult public func constrain(using attribute: Attribute, to viewAttribute: Attribute, of relatedView: UIView, relatedBy relation: Relation = .equal, offset: CGFloat = 0, multiplier: CGFloat = 1) -> UIView {
        enableAutoLayout()
        
        if let superview = self.superview {
            let constraint = NSLayoutConstraint(item: self,
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
            .constrain(using: .bottom, to: .bottom, of: view, offset: -offset, multiplier: 1)
            .constrain(using: .left, to: .left, of: view, offset: offset, multiplier: 1)
            .constrain(using: .right, to: .right, of: view, offset: -offset, multiplier: 1)
    }
    
    @discardableResult public func center(in view: UIView) -> UIView {
        enableAutoLayout()
        
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        return self
    }
    
    @discardableResult public func center(in view: UIView, axis: Axis,  multiplier: CGFloat = 1) -> UIView {
        enableAutoLayout()
        
        let anchor = axis.convert()
        constrain(using: anchor, to: anchor, of: view, offset: 0, multiplier: multiplier)
        return self
    }
    
    @discardableResult public func width(to view: UIView,
                                         relatedBy relatioin: Relation = .equal,
                                         priority: UILayoutPriority = .required,
                                         multiplier: CGFloat = 1.0,
                                         constant: CGFloat = 0.0) -> UIView {
        enableAutoLayout()
        
        let constraint: NSLayoutConstraint
        
        switch relatioin {
        case .equal:
            constraint = self.widthAnchor.constraint(equalTo: widthAnchor, multiplier: multiplier, constant: constant)
        case .lessThanOrEqual:
            constraint = self.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: multiplier, constant: constant)
        case .greaterThanOrEqual:
            constraint = self.widthAnchor.constraint(greaterThanOrEqualTo: widthAnchor, multiplier: multiplier, constant: constant)
        }
        constraint.set(priority: priority, isActive: true)
        
        return self
    }
    
    @discardableResult public func height(to view: UIView,
                                          relatedBy relatioin: Relation = .equal,
                                          priority: UILayoutPriority = .required,
                                          multiplier: CGFloat = 1.0,
                                          constant: CGFloat = 0.0) -> UIView {
        enableAutoLayout()
        let constraint: NSLayoutConstraint

        switch relatioin {
        case .equal:
            constraint = self.heightAnchor.constraint(equalTo: heightAnchor, multiplier: multiplier, constant: constant)
        case .lessThanOrEqual:
            constraint = self.widthAnchor.constraint(lessThanOrEqualTo: heightAnchor, multiplier: multiplier, constant: constant)
        case .greaterThanOrEqual:
            constraint = self.widthAnchor.constraint(greaterThanOrEqualTo: heightAnchor, multiplier: multiplier, constant: constant)
        }
        constraint.set(priority: priority, isActive: true)
        
        return self
    }
    
    @discardableResult public func size(_ size: CGSize) -> UIView {
        set(width: size.width)
        set(height: size.height)
        return self
    }
    
    // MARK: - Setting
    
    @discardableResult public func set(width value: CGFloat) -> UIView {
        set(value: value, to: .width)
        return self
    }
    
    @discardableResult public func set(height value: CGFloat) -> UIView {
        set(value: value, to: .height)
        return self
    }
    
    @discardableResult public func set(aspect value: CGFloat) -> UIView {
        set(value: value, to: .aspect)
        return self
    }
    
    @discardableResult public func set(aspectOf view: UIView) -> UIView {
        set(aspect: view.aspect)
        return self
    }
    
    @discardableResult public func set(value: CGFloat, to attribute: Attribute) -> UIView {
        guard let superview = self.superview else { return self }
        enableAutoLayout()
        
        let constraint = attribute != .aspect ?
            NSLayoutConstraint(item: self, attribute: attribute.convert() , relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: value) :
            NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: self, attribute: .height, multiplier: value, constant: 0)
        superview.addConstraint(constraint)
        
        return self
    }
}

private extension UIView {

    private func enableAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func anchored(to view: UIView, using anchor: AxisY) -> NSLayoutAnchor<NSLayoutYAxisAnchor> {
        guard #available(iOS 11.0, *) else {
            return (anchor == .bottom) ? view.layoutMarginsGuide.bottomAnchor : view.layoutMarginsGuide.topAnchor
        }
        return (anchor == .bottom) ? view.safeAreaLayoutGuide.bottomAnchor : view.safeAreaLayoutGuide.topAnchor
    }
    
    private func anchored(to view: UIView, using anchor: AxisX, useEdge edge: Bool = false) -> NSLayoutAnchor<NSLayoutXAxisAnchor> {
        guard #available(iOS 11.0, *) else {
            if edge {
                return (anchor == .left) ? view.layoutMarginsGuide.leadingAnchor : view.layoutMarginsGuide.trailingAnchor
            } else {
                return (anchor == .left) ? view.layoutMarginsGuide.leftAnchor : view.layoutMarginsGuide.rightAnchor
            }
        }
        
        if edge {
            return (anchor == .left) ? view.safeAreaLayoutGuide.leadingAnchor : view.safeAreaLayoutGuide.trailingAnchor
        } else {
            return (anchor == .left) ? view.safeAreaLayoutGuide.leftAnchor : view.safeAreaLayoutGuide.rightAnchor
        }
    }
}

public extension UIView {
    
    public var width: CGFloat {
        return bounds.width
    }
    
    public var height: CGFloat {
        return bounds.height
    }
    
    public var aspect: CGFloat {
        return bounds.width / bounds.height
    }
}

// MARK: - Anchoring
public extension UIView {
    
    @discardableResult public func top(with view: UIView,
                                       anchor: AxisY,
                                       relatedBy relation: Relation = .equal,
                                       priority: UILayoutPriority = .required,
                                       offset: CGFloat = 0) -> UIView {
        enableAutoLayout()
        
        let computedAnchor = anchored(to: view, using: anchor)
        let constraint: NSLayoutConstraint
        
        switch relation {
        case .equal:
            constraint = topAnchor.constraint(equalTo: computedAnchor, constant: offset)
        case .greaterThanOrEqual:
            constraint = topAnchor.constraint(greaterThanOrEqualTo: computedAnchor, constant: offset)
        case .lessThanOrEqual:
            constraint = topAnchor.constraint(lessThanOrEqualTo: computedAnchor, constant: offset)
        }
        constraint.set(priority: priority, isActive: true)
        
        return self
    }
    
    @discardableResult public func bottom(with view: UIView,
                                          anchor: AxisY,
                                          relatedBy relation: Relation = .equal,
                                          priority: UILayoutPriority = .required,
                                          offset: CGFloat = 0) -> UIView {
        enableAutoLayout()
        
        let computedAnchor = anchored(to: view, using: anchor)
        let constraint: NSLayoutConstraint
        
        switch relation {
        case .equal:
            constraint = bottomAnchor.constraint(equalTo: computedAnchor, constant: offset)
        case .lessThanOrEqual:
            constraint = bottomAnchor.constraint(lessThanOrEqualTo: computedAnchor, constant: offset)
        case .greaterThanOrEqual:
            constraint = bottomAnchor.constraint(greaterThanOrEqualTo: computedAnchor, constant: offset)
        }
        constraint.set(priority: priority, isActive: true)
        
        return self
    }
    
    @discardableResult public func left(with view: UIView,
                                        anchor: AxisX,
                                        relatedBy realtion: Relation = .equal,
                                        priority: UILayoutPriority = .required,
                                        offset: CGFloat = 0) -> UIView {
        enableAutoLayout()
        
        let computedAnchor = anchored(to: view, using: anchor)
        let constraint: NSLayoutConstraint
        
        switch realtion {
        case .equal:
            constraint = leftAnchor.constraint(equalTo: computedAnchor, constant: offset)
        case .greaterThanOrEqual:
            constraint = leftAnchor.constraint(greaterThanOrEqualTo: computedAnchor, constant: offset)
        case .lessThanOrEqual:
            constraint = leftAnchor.constraint(lessThanOrEqualTo: computedAnchor, constant: offset)
        }
        constraint.set(priority: priority, isActive: true)
        
        return self
    }
    
    @discardableResult public func right(with view: UIView,
                                         anchor: AxisX,
                                         relatedBy relation: Relation = .equal,
                                         priority: UILayoutPriority = .required,
                                         offset: CGFloat = 0) -> UIView {
        enableAutoLayout()
        
        let computedAnchor = anchored(to: view, using: anchor)
        let constraint: NSLayoutConstraint
        
        switch relation {
        case .equal:
            constraint = rightAnchor.constraint(equalTo: computedAnchor, constant: offset)
        case .greaterThanOrEqual:
            constraint = rightAnchor.constraint(greaterThanOrEqualTo: computedAnchor, constant: offset)
        case .lessThanOrEqual:
            constraint = rightAnchor.constraint(lessThanOrEqualTo: computedAnchor, constant: offset)
        }
        constraint.set(priority: priority, isActive: true)
        
        return self
    }
    
}

// MARK: - Anchoring to System Spacing
public extension UIView {
    
    @discardableResult public func leftToSystemSpacing(with view: UIView,
                                                       anchor: AxisX,
                                                       relatedBy relation: Relation = .equal,
                                                       priority: UILayoutPriority = .required,
                                                       multiplier: CGFloat = 1.0) -> UIView {
        enableAutoLayout()
        // We can be sure that this force-casting will succed sunce NSLayoutYAxisAnchor is a subclass of NSLayoutAnchor class
        let computedAnchor = anchored(to: view, using: anchor) as! NSLayoutXAxisAnchor
        let constraint: NSLayoutConstraint
        
        switch relation {
        case .equal:
            constraint = leftAnchor.constraint(equalToSystemSpacingAfter: computedAnchor, multiplier: multiplier)
        case .greaterThanOrEqual:
            constraint = leftAnchor.constraint(greaterThanOrEqualToSystemSpacingAfter: computedAnchor, multiplier: multiplier)
        case .lessThanOrEqual:
            constraint = leftAnchor.constraint(lessThanOrEqualToSystemSpacingAfter: computedAnchor, multiplier: multiplier)
        }
        constraint.set(priority: priority, isActive: true)
        
        return self
    }
    
    @discardableResult public func bottomToSystemSpacing(with view: UIView,
                                                         anchor: AxisY,
                                                         relatedBy relation: Relation = .equal,
                                                         priority: UILayoutPriority = .required,
                                                         multiplier: CGFloat = 1.0) -> UIView {
        enableAutoLayout()
        
        // We can be sure that this force-casting will succed sunce NSLayoutYAxisAnchor is a subclass of NSLayoutAnchor class
        let computedAnchor = anchored(to: view, using: anchor) as! NSLayoutYAxisAnchor
        let constraint: NSLayoutConstraint
        
        switch relation {
        case .equal:
            constraint = bottomAnchor.constraint(equalToSystemSpacingBelow: computedAnchor, multiplier: multiplier)
        case .lessThanOrEqual:
            constraint = bottomAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: computedAnchor, multiplier: multiplier)
        case .greaterThanOrEqual:
            constraint = bottomAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: computedAnchor, multiplier: multiplier)
        }
        constraint.set(priority: priority, isActive: true)
        
        return self
    }
    
    @discardableResult public func topToSystemSpacing(with view: UIView,
                                                      anchor: AxisY,
                                                      relatedBy relation: Relation = .equal,
                                                      priority: UILayoutPriority = .required,
                                                      multiplier: CGFloat = 1.0) -> UIView {
        enableAutoLayout()
        
        // We can be sure that this force-casting will succed sunce NSLayoutYAxisAnchor is a subclass of NSLayoutAnchor class
        let computedAnchor = anchored(to: view, using: anchor) as! NSLayoutYAxisAnchor
        let constraint: NSLayoutConstraint
        
        switch relation {
        case .equal:
            constraint = topAnchor.constraint(equalToSystemSpacingBelow: computedAnchor, multiplier: multiplier)
        case .lessThanOrEqual:
            constraint = topAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: computedAnchor, multiplier: multiplier)
        case .greaterThanOrEqual:
            constraint = topAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: computedAnchor, multiplier: multiplier)
        }
        constraint.set(priority: priority, isActive: true)
        
        return self
    }
    
    @discardableResult public func rightToSystemSpacing(with view: UIView,
                                                        anchor: AxisX,
                                                        relatedBy relation: Relation = .equal,
                                                        priority: UILayoutPriority = .required,
                                                        multiplier: CGFloat = 1.0) -> UIView {
        // We can be sure that this force-casting will succed sunce NSLayoutYAxisAnchor is a subclass of NSLayoutAnchor class
        let computedAnchor = anchored(to: view, using: anchor) as! NSLayoutXAxisAnchor
        let constraint: NSLayoutConstraint
        
        switch relation {
        case .equal:
            constraint = rightAnchor.constraint(equalToSystemSpacingAfter: computedAnchor, multiplier: multiplier)
        case .greaterThanOrEqual:
            constraint = rightAnchor.constraint(greaterThanOrEqualToSystemSpacingAfter: computedAnchor, multiplier: multiplier)
        case .lessThanOrEqual:
            constraint = rightAnchor.constraint(lessThanOrEqualToSystemSpacingAfter: computedAnchor, multiplier: multiplier)
        }
        constraint.set(priority: priority, isActive: true)
        
        return self
    }
    
}

// MARK: - Pin extension
public extension UIView {
    
    @discardableResult public func pinTopLeftToTopLeftCorner(cornerOf view: UIView, offset: CGFloat = 0.0) -> UIView {
        top(with: view, anchor: .top, offset: offset)
        left(with: view, anchor: .left, offset: offset)
        
        return self
    }
    
    @discardableResult public func pinTopRightToTopRightCorner(of view: UIView, offset: CGFloat = 0.0) -> UIView {
        top(with: view, anchor: .top, offset: offset)
        right(with: view, anchor: .right, offset: offset)
        
        return self
    }
    
    @discardableResult public func pinBottomRightToBottomRight(cornerOf view: UIView, offset: CGFloat = 0.0) -> UIView {
        bottom(with: view, anchor: .bottom, offset: offset)
        right(with: view, anchor: .right, offset: offset)
        
        return self
    }
    
    @discardableResult public func pinBottomLeftToBottomLeft(cornerOf view: UIView, offset: CGFloat = 0.0) -> UIView {
        bottom(with: view, anchor: .bottom, offset: offset)
        left(with: view, anchor: .left, offset: offset)
        
        return self
    }
    
    
    @discardableResult public func pinBottomRightToTopLeft(of view: UIView, offset: CGFloat = 0.0) -> UIView {
        bottom(with: view, anchor: .top, offset: offset)
        right(with: view, anchor: .left, offset: offset)
        
        return self
    }
    
    
    @discardableResult public func pinBottomLeftToTopRight(cornerOf view: UIView, offset: CGFloat = 0.0) -> UIView {
        bottom(with: view, anchor: .top, offset: offset)
        left(with: view, anchor: .right, offset: offset)
        
        return self
    }
    
    
    @discardableResult public func pinTopLeftToBottomRight(cornerOf view: UIView, offset: CGFloat = 0.0) -> UIView {
        top(with: view, anchor: .bottom, offset: offset)
        left(with: view, anchor: .right, offset: offset)
        
        return self
    }
    
    @discardableResult public func pinBottomRightToTopLeft(cornerOf view: UIView, offset: CGFloat = 0.0) -> UIView {
        top(with: view, anchor: .bottom, offset: offset)
        right(with: view, anchor: .left, offset: offset)
        
        return self
    }
    
    @discardableResult public func pinTopToTopCenter(of view: UIView, offset: CGFloat = 0.0) -> UIView {
        top(with: view, anchor: .top, offset: offset)
        center(in: view, axis: .horizontal)
        
        return self
    }
    
    @discardableResult public func pinBottomToBottomCenter(of view: UIView, offset: CGFloat = 0.0) -> UIView {
        bottom(with: view, anchor: .bottom, offset: -offset)
        center(in: view, axis: .horizontal)
        
        return self
    }
    
    @discardableResult public func pinLeftToLeftCenter(of view: UIView, offset: CGFloat = 0.0) -> UIView {
        left(with: view, anchor: .left, offset: offset)
        center(in: view, axis: .vertical)
        
        return self
    }
    
    @discardableResult public func pinRightToRightCenter(of view: UIView, offset: CGFloat = 0.0) -> UIView {
        right(with: view, anchor: .right, offset: -offset)
        center(in: view, axis: .vertical)
        
        return self
    }
    
    @discardableResult public func pinInside(view: UIView, relatedBy relation: Relation = .equal, priority: UILayoutPriority = .required, offset: CGFloat = 0.0 ) -> UIView {
        
        left(with: view, anchor: .left, relatedBy: relation, priority: priority, offset: offset)
        top(with: view, anchor: .top, relatedBy: relation, priority: priority, offset: offset)
        right(with: view, anchor: .right, relatedBy: relation, priority: priority, offset: -offset)
        bottom(with: view, anchor: .bottom, relatedBy: relation, priority: priority, offset: -offset)
        
        return self
    }
    
    @discardableResult public func pinTo(view: UIView, using anchor: Anchor) -> UIView {
        
        let constraints = anchor.convert()
        
        for constraint in constraints {
            switch constraint {
            case .left:
                left(with: view, anchor: .left)
            case .right:
                right(with: view, anchor: .right)
            case .bottom:
                bottom(with: view, anchor: .bottom)
            case .top:
                top(with: view, anchor: .top)
            case .centerY:
                center(in: view, axis: .vertical)
            case .centerX:
                center(in: view, axis: .horizontal)
            case .firstBaseline:
                constrain(using: .firstBaseline, to: .firstBaseline, of: view)
            case .lastBaseline:
                constrain(using: .lastBaseline, to: .lastBaseline, of: view)
            case .trailing:
                constrain(using: .trailing, to: .trailing, of: view)
            case .leading:
                constrain(using: .leading, to: .leading, of: view)
            case .width:
                width(to: view)
            case .height:
                height(to: view)
            default:
                continue
            }
        }
        
        return self
    }
}


// MARK: - Fill extension
public extension UIView {
    
    @discardableResult public func fillToBottomHalf(of view: UIView, offset: CGFloat = 0.0) -> UIView {
        left(with: view, anchor: .left, offset: offset)
        right(with: view, anchor: .right, offset: -offset)
        bottom(with: view, anchor: .bottom, offset: -offset)
        constrain(using: .top, to: .centerY, of: view, offset: offset)
        
        return self
    }
    
    @discardableResult public func fillToTopHalf(of view: UIView, offset: CGFloat = 0.0) -> UIView {
        left(with: view, anchor: .left, offset: offset)
        right(with: view, anchor: .right, offset: -offset)
        top(with: view, anchor: .top, offset: offset)
        constrain(using: .bottom, to: .centerY, of: view, offset: -offset)
        
        return self
    }
    
    @discardableResult public func fillLeftHalf(of view: UIView, offset: CGFloat = 0.0) -> UIView {
        left(with: view, anchor: .left, offset: offset)
        bottom(with: view, anchor: .bottom, offset: -offset)
        top(with: view, anchor: .top, offset: offset)
        constrain(using: .right, to: .centerX, of: view, offset: -offset)
        
        return self
    }
    
    @discardableResult public func fillRightHalf(cornerOf view: UIView, offset: CGFloat = 0.0) -> UIView {
        right(with: view, anchor: .right, offset: -offset)
        bottom(with: view, anchor: .bottom, offset: -offset)
        top(with: view, anchor: .top, offset: offset)
        constrain(using: .left, to: .centerX, of: view, offset: offset)
        
        return self
    }
    
}
