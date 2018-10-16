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
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Configure UIView
        self.view.addSubview(uiview)
        uiview.backgroundColor = .orange
        uiview.constraint.fit(inside: view)
        
        
        self.view.addSubview(button)
        // Configure UIButton
        button.titleLabel?.text = "Open"
        button.tintColor = .blue
        button.constraint.width = 100
        button.constraint.center(in: view).aspect = 1/2
    }
}

