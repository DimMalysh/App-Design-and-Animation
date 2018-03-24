//
//  GravityViewController.swift
//  UIDynamicBehaviorTest
//
//  Created by mac on 24.03.18.
//  Copyright © 2018 Dim Malysh. All rights reserved.
//

import UIKit

class GravityViewController: UIViewController {
    var squareView: UIView!
    var dynamicAnimator: UIDynamicAnimator!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.darkGray
        
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        
        squareView = UIView(frame: CGRect(origin: CGPoint(x: 140.0, y: 200.0),
                                          size: CGSize(width: 50.0, height: 50.0)))
        squareView.backgroundColor = UIColor.lightGray
        view.addSubview(squareView)

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        view.addGestureRecognizer(panGesture)
    }
    
    func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        dynamicAnimator.removeAllBehaviors()
        squareView.center = sender.location(in: view)
        
        switch sender.state {
        case .ended:
            let gravityBehavior = UIGravityBehavior(items: [squareView])
            dynamicAnimator.addBehavior(gravityBehavior)
        default:
            break
        }
    }
}
