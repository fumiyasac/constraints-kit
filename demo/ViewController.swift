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

        [uiview, button].forEach { [weak self] in self?.view.addSubview($0) }
        
        uiview.backgroundColor = .orange
        uiview.round(corners: .all, radius: 30)

//        uiview.constraint
//            .constrain(using: .top, to: .top, of: view, offset: 24)
//            .constrain(using: .right, to: .right, of: view, offset: -24)
//            .constrain(using: .left, to: .left, of: view, offset: 24)
//            .constrain(using: .bottom, to: .top, of: button, offset: -24)
        
        uiview.constraint
//            .top(with: view, anchor: .top, offset: 24)
            .topToSystemSpacing(with: view, anchor: .top)
//            .constrain(using: .top, to: .centerY, of: view)
//            .identify(with: "UIView Top <-> Top constraint")
            .right(with: view, anchor: .right, offset: -24)
//            .identify(with: "UIView Right <-> Right constraint")
            .left(with: view, anchor: .left, offset: 24)
//            .identify(with: "UIView Left <-> Left constraint")
            .bottom(with: button, anchor: .top, offset: -24)
//            .identify(with: "UIView Bottom <-> Top constraint")
        
        print("uiview: ", view.constraints)
        
        button.round(corners: .all, radius: 10)
        
        // Configure UIButton
        button.setTitle("Open", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.0, green: 0.25, blue: 0.5, alpha: 1.0)
        
        button.constraint
            .bottom(with: view, anchor: .bottom, offset: -24)
            .center(in: view, axis: .horizontal)
            .set(width: 100)
            .set(height: 60)
    }
}

