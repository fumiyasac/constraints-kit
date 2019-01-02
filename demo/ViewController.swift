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
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.frame, style: UITableView.Style.plain)
        view.addSubview(tableView)
        try! tableView.pinInside()
        
        return tableView
    }()
    
    private lazy var dataSource = ConstraintsKitTableViewDataSource()
    private lazy var delegate: ConstraintsKitTableViewDelegate = {
        let delegate = ConstraintsKitTableViewDelegate(target: dataSource, delegate: self)
        return delegate
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Add all the UIView components
        navigationController?.topViewController?.title = "Demos"
        
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        
        
//        [uiview, button, imageView].forEach { [weak self] in self?.view.addSubview($0) }
//
//        uiview.backgroundColor = .orange
//        uiview.round(corners: .all, radius: 30)
//
//        imageView.image = #imageLiteral(resourceName: "image.jpg")
//        imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = true
//        imageView.round(corners: .all, radius: 30)
        
        
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
        
//        uiview
//            .center(in: view, axis: .vertical)
//            .left(with: view, anchor: .left)
//            .right(with: view, anchor: .right)
//            .set(aspect: 3/2)
        
//        imageView.fit(inside: uiview, offset: 24)
        
//        uiview.pinInside(view: view, using: [.leading, .trailing, .top, .bottom])
        
//        uiview.pinToBottomHalf(of: view)
//        uiview.pinToTopHalf(of: view, offset: 24)
//        uiview.pinToLeftHalf(of: view, offset: 24)
//        uiview.pinToRightHalf(of: view, offset: 24)
        
//        uiview.pinInsideToTopLeftCorner(of: view, offset: 24)
//        .size(CGSize(width: 200, height: 300))

//        uiview.pin(of: button, offset: 24)
//            .size(CGSize(width: 200, height: 300))
        
//        uiview.pinTopToTopCenter(of: view).set(width: 200).set(aspect: 2/1)
        
//        uiview.size(CGSize(width: 200, height: 300))
//        uiview.pinBottomToBottomCenter(of: view, offset: 24)

//        uiview
//            .pin(anchors: [.left, .top], toTargetView: view, using: [.leading, .top])
//            .pin(anchors: [.bottom, .right], toTargetView: button, using: [.right, .top])
//
//        button.round(corners: .all, radius: 10)
//        
//        // Configure UIButton
//        button.setTitle("Open", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.backgroundColor = UIColor(red: 0.0, green: 0.25, blue: 0.5, alpha: 1.0)
//        
//        button
//            .bottom(with: view, anchor: .bottom, offset: -24)
//            .center(in: view, axis: .horizontal)
//            .set(width: 100)
//            .set(height: 60)
    }
}

extension ViewController: ConstraintsKitTableViewDelegateSelection {
    
    fileprivate func selected(viewIdentifier: ViewControllersType?, error: DataSourceError?) {
        guard let identifier = viewIdentifier, error == nil else {
            fatalError("Error occured while trying to launch the a UIViewController: \(error.debugDescription)")
        }
        
        let viewController: UIViewController
        let rawIdentifier = identifier.rawValue
        
        switch identifier {
        case .cardsView:
            viewController = storyboard?.instantiateViewController(withIdentifier: rawIdentifier) as! CardsViewController
        case .collectionView:
            viewController = storyboard?.instantiateViewController(withIdentifier: rawIdentifier) as! CollectionViewController
        }

        navigationController?.pushViewController(viewController, animated: true)
    }
    
}


enum ViewControllersType: String {
    case cardsView = "CardsViewController"
    case collectionView = "CollectionViewController"
}

fileprivate class ConstraintsKitTableViewDataSource: NSObject, UITableViewDataSource {
    
    private var dataSource: [String] = [
        "Card View",
        "UICollectionView"
    ]
    
    private var descriptions: [String] = [
        "A custom UI composed out of several UIKit components that form an interactive card view",
        "A UICollectionView with custom UICollectionViewCell"
    ]
    
    private(set) var viewControllerIdentifiers: [ViewControllersType] = [
        .cardsView, .collectionView ]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureCell(for: indexPath.row)
    }
    
    // MARK: - Private methods
    
    private func configureCell(for index: Int) -> UITableViewCell {
        let dataSourceElement = dataSource[index]
        let description = descriptions[index]
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = dataSourceElement
        cell.detailTextLabel?.text = description
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}

fileprivate protocol ConstraintsKitTableViewDelegateSelection: class {
    func selected(viewIdentifier: ViewControllersType?, error: DataSourceError?)
}

fileprivate class ConstraintsKitTableViewDelegate: NSObject, UITableViewDelegate {
    
    // MARK: - Properties
    
    private weak var delegate: ConstraintsKitTableViewDelegateSelection?
    private weak var dataSource: ConstraintsKitTableViewDataSource?
    
    // MARK: - Initializers
    
    init(target dataSource: ConstraintsKitTableViewDataSource, delegate: ConstraintsKitTableViewDelegateSelection) {
        self.dataSource = dataSource
        self.delegate = delegate
    }
    
    // MARK: - Conformance to UITableViewDelegate protocol
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let identifier = dataSource?.viewControllerIdentifiers[indexPath.row] else {
            delegate?.selected(viewIdentifier: nil, error: DataSourceError.dataSourceWasDeallocated)
            return
        }
        delegate?.selected(viewIdentifier: identifier, error: nil)
    }
}

fileprivate enum DataSourceError: Error {
    case dataSourceWasDeallocated
}
