//
//  CardsViewController.swift
//  demo
//
//  Created by Astemir Eleev on 09/11/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {

    private lazy var cardView: UIView = {
        let view = UIView()
        self.view.addSubview(view)
        
        view.round(corners: .all, radius: 30)
        view.backgroundColor = .lightGray
        
        view.pinInside(view: self.view, offset: 128)
        
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView(image: #imageLiteral(resourceName: "image.jpg"))
        view.contentMode = .scaleAspectFill
    
        self.cardView.addSubview(view)
        
        view.round(corners: .all, radius: 30)
        
        view.pinInside(view: cardView, offset: 8)
        return view
    }()
    
    private lazy var blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let view = UIVisualEffectView(effect: blurEffect)
        
        imageView.addSubview(view)
        
        view.round(corners: .all, radius: 30)
        view.pinInside(view: cardView)

        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 50, weight: UIFont.Weight.bold)
        label.text = "Card Title"
        label.textColor = .white
        
        imageView.addSubview(label)
        
        label.pinTopToTopCenter(of: imageView, offset: 32)
        
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.roundedRect)
        button.backgroundColor = UIColor.init(white: 1.0, alpha: 0.5)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        button.setTitle("Animate", for: .normal)
        
        button.round(corners: .all, radius: 15)
        
        cardView.insertSubview(button, aboveSubview: imageView)
        
        button
            .bottom(with: imageView, anchor: .bottom, offset: -34)
            .center(in: imageView, axis: .horizontal)
            .set(height: 60)
            .set(aspect: 2/1)

        return button
    }()
    
    private lazy var text: UILabel = {
        let label = UILabel()
        label.numberOfLines = 10
        label.text = "This is a multiline label containing sample text for demonstration purposes. You may change this text as you'd like. This Card View can be animated by tapping on the `Animate` button. Have fun with constraints-kit framework."
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = .lightGray
        label.textAlignment = .justified
        
        cardView.insertSubview(label, aboveSubview: imageView)
        
        label
            .center(in: imageView)
            .left(with: imageView, anchor: .left, offset: 16)
            .right(with: imageView, anchor: .right, offset: -16)
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        debugPrint(cardView)
        debugPrint(imageView)
        debugPrint(blurView)
        debugPrint(titleLabel)
        debugPrint(button)
        debugPrint(text)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
