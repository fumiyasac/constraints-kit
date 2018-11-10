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
  
    // MARK: - Constraining
    
    /// Constrains `self` using the specified `Attribute` to the specified `Attribute` with respect to the related `UIView`. You may set `Relation` (which is by default `.equal`), `offset` (default is `0.0`) and `multiplier` (default is `1.0`)
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
    
    /// Places `self` inside the specified `UIView` with an optional `offset` (default is `0.0`)
    public func fit(inside view: UIView, offset: CGFloat = 0) {
        constrain(using: .top, to: .top, of: view, offset: offset, multiplier: 1)
            .constrain(using: .bottom, to: .bottom, of: view, offset: -offset, multiplier: 1)
            .constrain(using: .left, to: .left, of: view, offset: offset, multiplier: 1)
            .constrain(using: .right, to: .right, of: view, offset: -offset, multiplier: 1)
    }
    
    /// Centers `self` inside the specified `UIView`
    @discardableResult public func center(in view: UIView) -> UIView {
        enableAutoLayout()
        
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        return self
    }
    
    /// Centers `self` inside the specified `UIView` using a concrete `Axis` case, with an optional `multiplier` (default is `1.0`)
    @discardableResult public func center(in view: UIView, axis: Axis,  multiplier: CGFloat = 1.0) -> UIView {
        enableAutoLayout()
        
        let anchor = axis.convert()
        constrain(using: anchor, to: anchor, of: view, offset: 0, multiplier: multiplier)
        return self
    }
    
    /// Applies width equalization between `self` and the specified `UIView`. You may change the `Relation` (default is `equal`), `UILayoutPriority` (default is `required`), `multiplier` (default is `1.0`) and `constant` (default is `0.0`)
    @discardableResult public func width(to view: UIView,
                                         relatedBy relatioin: Relation = .equal,
                                         priority: UILayoutPriority = .required,
                                         multiplier: CGFloat = 1.0,
                                         constant: CGFloat = 0.0) -> UIView {
        enableAutoLayout()
            
        let constraint: NSLayoutConstraint
        
        switch relatioin {
        case .equal:
            constraint = self.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: multiplier, constant: constant)
        case .lessThanOrEqual:
            constraint = self.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: multiplier, constant: constant)
        case .greaterThanOrEqual:
            constraint = self.widthAnchor.constraint(greaterThanOrEqualTo: view.widthAnchor, multiplier: multiplier, constant: constant)
        }
        constraint.set(priority: priority, isActive: true)
        
        return self
    }
    
    /// Applies height equalization between `self` and the specified `UIView`. You may change the `Relation` (default is `equal`), `UILayoutPriority` (default is `required`), `multiplier` (default is `1.0`) and `constant` (default is `0.0`)
    @discardableResult public func height(to view: UIView,
                                          relatedBy relatioin: Relation = .equal,
                                          priority: UILayoutPriority = .required,
                                          multiplier: CGFloat = 1.0,
                                          constant: CGFloat = 0.0) -> UIView {
        enableAutoLayout()
        let constraint: NSLayoutConstraint

        switch relatioin {
        case .equal:
            constraint = self.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: multiplier, constant: constant)
        case .lessThanOrEqual:
            constraint = self.widthAnchor.constraint(lessThanOrEqualTo: view.heightAnchor, multiplier: multiplier, constant: constant)
        case .greaterThanOrEqual:
            constraint = self.widthAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor, multiplier: multiplier, constant: constant)
        }
        constraint.set(priority: priority, isActive: true)
        
        return self
    }
    
    // MARK: - Setting
    
    /// Sets a new `CGSize` for `self` by applying layout constaints for `width` & `height` anchors
    @discardableResult public func set(size: CGSize) -> UIView {
        set(width: size.width)
        set(height: size.height)
        return self
    }
    
    /// Sets a new `width` by applying layout constaint for `width` anchor
    @discardableResult public func set(width value: CGFloat) -> UIView {
        set(value: value, to: .width)
        return self
    }
    
    /// Sets a new `height` by applying layout constraint for `height` anchor
    @discardableResult public func set(height value: CGFloat) -> UIView {
        set(value: value, to: .height)
        return self
    }
    
    /// Sets a new `aspect ratio` by applying layout constaint for `aspect` anchor
    @discardableResult public func set(aspect value: CGFloat) -> UIView {
        set(value: value, to: .aspect)
        return self
    }
    
    /// Sets a new `aspect ratio` by duplicating `aspect` of the specified `UIView`
    @discardableResult public func set(aspectOf view: UIView) -> UIView {
        set(aspect: view.aspect)
        return self
    }
    
    /// Sets a new offset `value` for the `Attribute`
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
    
    public var size: CGSize {
        return CGSize(width: width, height: height)
    }
    
    public var aspect: CGFloat {
        return bounds.width / bounds.height
    }
}

// MARK: - Anchoring
public extension UIView {
    
    /// Anchors top anchor to the specified `UIView` using `AxisY` anchor, `Relation` (defatul is `.equal`), NSLayoutPriority (default is `.required`) and `offset` (default is `0.0`)
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
    
    /// Anchors botom anchor to the specified `UIView` using `AxisY` anchor, `Relation` (defatul is `.equal`), NSLayoutPriority (default is `.required`) and `offset` (default is `0.0`)
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
    
    /// Anchors left anchor to the specified `UIView` using `AxisY` anchor, `Relation` (defatul is `.equal`), NSLayoutPriority (default is `.required`) and `offset` (default is `0.0`)
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
    
    /// Anchors right anchor to the specified `UIView` using `AxisY` anchor, `Relation` (defatul is `.equal`), NSLayoutPriority (default is `.required`) and `offset` (default is `0.0`)
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
    
    /// Anchors left anchor to the specified `UIView` with respect to System Spacing using `AxisY` anchor, `Relation` (defatul is `.equal`), NSLayoutPriority (default is `.required`) and `offset` (default is `0.0`)
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
    
    /// Anchors bottom anchor to the specified `UIView` with respect to System Spacing using `AxisY` anchor, `Relation` (defatul is `.equal`), NSLayoutPriority (default is `.required`) and `offset` (default is `0.0`)
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
    
    /// Anchors top anchor to the specified `UIView` with respect to System Spacing using `AxisY` anchor, `Relation` (defatul is `.equal`), NSLayoutPriority (default is `.required`) and `offset` (default is `0.0`)
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
    
    /// Anchors right anchor to the specified `UIView` with respect to System Spacing using `AxisY` anchor, `Relation` (defatul is `.equal`), NSLayoutPriority (default is `.required`) and `offset` (default is `0.0`)
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
    
    /// Pins Top Left anchor to the Top Left corner of the specified `UIView` with a given `offset` (default is `0.0`)
    @discardableResult public func pinTopLeftToTopLeftCorner(cornerOf view: UIView, offset: CGFloat = 0.0) -> UIView {
        top(with: view, anchor: .top, offset: offset)
        left(with: view, anchor: .left, offset: offset)
        
        return self
    }
    
    /// Pins Top Right anchor to the Top Right corner of the specified `UIView` with a given `offset` (default is `0.0`)
    @discardableResult public func pinTopRightToTopRightCorner(of view: UIView, offset: CGFloat = 0.0) -> UIView {
        top(with: view, anchor: .top, offset: offset)
        right(with: view, anchor: .right, offset: offset)
        
        return self
    }
    
    /// Pins Bottom Right anchor to the Bottom Right corner of the specified `UIView` with a given `offset` (default is `0.0`)
    @discardableResult public func pinBottomRightToBottomRight(cornerOf view: UIView, offset: CGFloat = 0.0) -> UIView {
        bottom(with: view, anchor: .bottom, offset: offset)
        right(with: view, anchor: .right, offset: offset)
        
        return self
    }
    
    /// Pins Bottom Left anchor to the Bottom Left corner of the specified `UIView` with a given `offset` (default is `0.0`)
    @discardableResult public func pinBottomLeftToBottomLeft(cornerOf view: UIView, offset: CGFloat = 0.0) -> UIView {
        bottom(with: view, anchor: .bottom, offset: offset)
        left(with: view, anchor: .left, offset: offset)
        
        return self
    }
    
    /// Pins Bottom Right anchor to the Top Left corner of the specified `UIView` with a given `offset` (default is `0.0`)
    @discardableResult public func pinBottomRightToTopLeft(of view: UIView, offset: CGFloat = 0.0) -> UIView {
        bottom(with: view, anchor: .top, offset: offset)
        right(with: view, anchor: .left, offset: offset)
        
        return self
    }
    
    /// Pins Bottom Left anchor to the Top Right corner of the specified `UIView` with a given `offset` (default is `0.0`)
    @discardableResult public func pinBottomLeftToTopRight(cornerOf view: UIView, offset: CGFloat = 0.0) -> UIView {
        bottom(with: view, anchor: .top, offset: offset)
        left(with: view, anchor: .right, offset: offset)
        
        return self
    }
    
    /// Pins Top Left anchor to the Bottom Right corner of the specified `UIView` with a given `offset` (default is `0.0`)
    @discardableResult public func pinTopLeftToBottomRight(cornerOf view: UIView, offset: CGFloat = 0.0) -> UIView {
        top(with: view, anchor: .bottom, offset: offset)
        left(with: view, anchor: .right, offset: offset)
        
        return self
    }
    
    /// Pins Bottom Right anchor to the Top Left corner of the specified `UIView` with a given `offset` (default is `0.0`)
    @discardableResult public func pinBottomRightToTopLeft(cornerOf view: UIView, offset: CGFloat = 0.0) -> UIView {
        top(with: view, anchor: .bottom, offset: offset)
        right(with: view, anchor: .left, offset: offset)
        
        return self
    }
    
    /// Pins Top anchor to the Top Center anchor of the specified `UIView` with a given `offset` (default is `0.0`)
    @discardableResult public func pinTopToTopCenter(of view: UIView, offset: CGFloat = 0.0) -> UIView {
        top(with: view, anchor: .top, offset: offset)
        center(in: view, axis: .horizontal)
        
        return self
    }
    
    /// Pins Bottom anchor to the Bottom Center anchor of the specified `UIView` with a given `offset` (default is `0.0`)
    @discardableResult public func pinBottomToBottomCenter(of view: UIView, offset: CGFloat = 0.0) -> UIView {
        bottom(with: view, anchor: .bottom, offset: -offset)
        center(in: view, axis: .horizontal)
        
        return self
    }
    
    /// Pins Left anchor to the Left Center anchor of the specified `UIView` with a given `offset` (default is `0.0`)
    @discardableResult public func pinLeftToLeftCenter(of view: UIView, offset: CGFloat = 0.0) -> UIView {
        left(with: view, anchor: .left, offset: offset)
        center(in: view, axis: .vertical)
        
        return self
    }
    
    /// Pins Right anchor to the Right Center anchor of the specified `UIView` with a given `offset` (default is `0.0`)
    @discardableResult public func pinRightToRightCenter(of view: UIView, offset: CGFloat = 0.0) -> UIView {
        right(with: view, anchor: .right, offset: -offset)
        center(in: view, axis: .vertical)
        
        return self
    }
    
    /// Pins `self` inside the specified `UIView` with `Relation` (default is `.equal`), UILayoutPriority (default is `.required`) and `offset` (default is `0.0`)
    @discardableResult public func pinInside(view: UIView, relatedBy relation: Relation = .equal, priority: UILayoutPriority = .required, offset: CGFloat = 0.0 ) -> UIView {
        
        left(with: view, anchor: .left, relatedBy: relation, priority: priority, offset: offset)
        top(with: view, anchor: .top, relatedBy: relation, priority: priority, offset: offset)
        right(with: view, anchor: .right, relatedBy: relation, priority: priority, offset: -offset)
        bottom(with: view, anchor: .bottom, relatedBy: relation, priority: priority, offset: -offset)
        
        return self
    }
    
    /// Pins `self` to the specified `UIView` by using `Anchor` (which is an `OptionSet`)
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
    
    /// Pins the specified `Anchors` of `self` to the `UIView` by using the related `Anchors`
    @discardableResult public func pin(anchors: Anchor, toTargetView view: UIView, using viewAnchors: Anchor) -> UIView {
        
        let constraints = anchors.convert()
        let targetConstraints = viewAnchors.convert()
        
        for (index, constraint) in constraints.enumerated() where index < targetConstraints.count {
            let targetConstraint = targetConstraints[index].convert()
            
            switch constraint {
            case .left:
                left(with: view, anchor: targetConstraint.toAxisX() ?? .left)
            case .right:
                right(with: view, anchor: targetConstraint.toAxisX() ?? .right)
            case .bottom:
                bottom(with: view, anchor: targetConstraint.toAxisY() ?? .bottom)
            case .top:
                top(with: view, anchor: targetConstraint.toAxisY() ?? .top)
            case .centerY:
                center(in: view, axis: targetConstraint.toAxis() ?? .vertical)
            case .centerX:
                center(in: view, axis: targetConstraint.toAxis() ?? .horizontal)
            case .firstBaseline:
                constrain(using: .firstBaseline, to: targetConstraint, of: view)
            case .lastBaseline:
                constrain(using: .lastBaseline, to: targetConstraint, of: view)
            case .trailing:
                constrain(using: .trailing, to: targetConstraint, of: view)
            case .leading:
                constrain(using: .leading, to: targetConstraint, of: view)
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
    
    
    /// Fills the bottom half of the specified view by `self` with the given `offset` (default is `0.0`)
    @discardableResult public func fillBottomHalf(of view: UIView, offset: CGFloat = 0.0) -> UIView {
        left(with: view, anchor: .left, offset: offset)
        right(with: view, anchor: .right, offset: -offset)
        bottom(with: view, anchor: .bottom, offset: -offset)
        constrain(using: .top, to: .centerY, of: view, offset: offset)
        
        return self
    }
    /// Fills the top half of the specified view by `self` with the given `offset` (default is `0.0`)
    @discardableResult public func fillTopHalf(of view: UIView, offset: CGFloat = 0.0) -> UIView {
        left(with: view, anchor: .left, offset: offset)
        right(with: view, anchor: .right, offset: -offset)
        top(with: view, anchor: .top, offset: offset)
        constrain(using: .bottom, to: .centerY, of: view, offset: -offset)
        
        return self
    }
    
    /// Fills the left half of the specified view by `self` with the given `offset` (default is `0.0`)
    @discardableResult public func fillLeftHalf(of view: UIView, offset: CGFloat = 0.0) -> UIView {
        left(with: view, anchor: .left, offset: offset)
        bottom(with: view, anchor: .bottom, offset: -offset)
        top(with: view, anchor: .top, offset: offset)
        constrain(using: .right, to: .centerX, of: view, offset: -offset)
        
        return self
    }
    
    /// Fills the right half of the specified view by `self` with the given `offset` (default is `0.0`)
    @discardableResult public func fillRightHalf(cornerOf view: UIView, offset: CGFloat = 0.0) -> UIView {
        right(with: view, anchor: .right, offset: -offset)
        bottom(with: view, anchor: .bottom, offset: -offset)
        top(with: view, anchor: .top, offset: offset)
        constrain(using: .left, to: .centerX, of: view, offset: offset)
        
        return self
    }
    
}
