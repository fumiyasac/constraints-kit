//
//  ViewController.swift
//  demo
//
//  Created by Astemir Eleev on 16/10/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import UIKit
import constraints_kit

class ViewController: UIViewController {

    let uiview = UIView()
    let imageView = UIImageView()
    let button = UIButton(type: UIButton.ButtonType.system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Add all the UIView components

        [uiview, button, imageView].forEach { [weak self] in self?.view.addSubview($0) }
        
        uiview.backgroundColor = .orange
        uiview.round(corners: .all, radius: 30)

        imageView.image = #imageLiteral(resourceName: "image.jpg")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.round(corners: .all, radius: 30)
        
        
//        uiview
//            .constrain(using: .top, to: .top, of: view, offset: 24)
//            .constrain(using: .right, to: .right, of: view, offset: -24)
//            .constrain(using: .left, to: .left, of: view, offset: 24)
//            .constrain(using: .bottom, to: .top, of: button, offset: -24)
        
//        uiview
////            .top(with: view, anchor: .top, offset: 24)
//            .topToSystemSpacing(with: view, anchor: .top)
////            .constrain(using: .top, to: .centerY, of: view)
////            .identify(with: "UIView Top <-> Top constraint")
//            .right(with: view, anchor: .right, offset: -24)
////            .identify(with: "UIView Right <-> Right constraint")
//            .left(with: view, anchor: .left, offset: 24)
////            .identify(with: "UIView Left <-> Left constraint")
//            .bottom(with: button, anchor: .top, offset: -24)
////            .identify(with: "UIView Bottom <-> Top constraint")
        
        
//        print("uiview: ", view.constraints)
        
        
        
//        uiview
//            .topToSystemSpacing(with: view, anchor: .top)
//            //            .right(with: view, anchor: .right, offset: -24)
//            //            .left(with: view, anchor: .left, offset: 24)
//            .bottom(with: button, anchor: .top, offset: -24)
//            .center(in: view, axis: .horizontal)
//            .width(to: button, relatedBy: .greaterThanOrEqual)

//        uiview.constraint
//        uiview <=> view

//        uiview
//            .top(with: view, anchor: .top, offset: 24)
//            .identify(with: "top <-> top")
//            .bottom(with: button, anchor: .top, offset: -24)
//            .identify(with: "bottom <-> top")
//            .right(with: view, anchor: .right, offset: -24)
//            .left(with: view, anchor: .left, offset: 24)
        
//        uiview.pinInside(view: view, offset: 24)
        imageView.fit(inside: uiview, offset: 24)
//        uiview.pinInside(view: view, using: [.leading, .trailing, .top, .bottom])
        
//        uiview.pinToBottomHalf(of: view)
//        uiview.pinToTopHalf(of: view, offset: 24)
//        uiview.pinToLeftHalf(of: view, offset: 24)
//        uiview.pinToRightHalf(of: view, offset: 24)
        
//        uiview.pinInsideToTopLeftCorner(of: view, offset: 24)
//        .size(CGSize(width: 200, height: 300))

//        uiview.pinOutsideToTopLeftCorner(of: button, offset: 24).size(CGSize(width: 200, height: 300))
        
//        uiview.pinTopToTopCenter(of: view).set(width: 200).set(aspect: 2/1)
        
//        uiview.size(CGSize(width: 200, height: 300))
//        uiview.pinBottomToBottomCenter(of: view, offset: 24)

        uiview
            .pin(anchors: [.left, .top], toTargetView: view, using: [.leading, .top])
            .pin(anchors: [.bottom, .right], toTargetView: button, using: [.right, .top])
        
        button.round(corners: .all, radius: 10)
        
        // Configure UIButton
        button.setTitle("Open", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.0, green: 0.25, blue: 0.5, alpha: 1.0)
        
        button
            .bottom(with: view, anchor: .bottom, offset: -24)
            .center(in: view, axis: .horizontal)
            .set(width: 100)
            .set(height: 60)
    }
}
