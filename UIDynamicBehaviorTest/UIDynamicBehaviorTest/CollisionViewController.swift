//
//  CollisionViewController.swift
//  UIDynamicBehaviorTest
//
//  Created by mac on 24.03.18.
//  Copyright © 2018 Dim Malysh. All rights reserved.
//

import UIKit

class CollisionViewController: UIViewController {
    var redBoxView: UIView!
    var whiteBoxView: UIView!
    var dynamicAnimator: UIDynamicAnimator!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.darkGray
        
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        
        redBoxView = UIView(frame: CGRect(origin: CGPoint(x: 100.0, y: 50.0),
                                            size: CGSize(width: 80.0, height: 80.0)))
        redBoxView.backgroundColor = UIColor.red
        redBoxView.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_4 / 2))
        view.addSubview(redBoxView)
        
        whiteBoxView = UIView(frame: CGRect(origin: CGPoint(x: 150.0, y: 20.0),
                                            size: CGSize(width: 80.0, height: 80.0)))
        whiteBoxView.backgroundColor = UIColor.white
        whiteBoxView.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI_4 / 2))
        view.addSubview(whiteBoxView)

        addBehavior()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        view.addGestureRecognizer(panGesture)
    }
    
    func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        dynamicAnimator.removeAllBehaviors()
        redBoxView.center = sender.location(in: view)
        
        switch sender.state {
        case .ended:
            addBehavior()
        default:
            break
        }
    }
    
    func addBehavior() {
        let gravityBehavior = UIGravityBehavior(items: [redBoxView, whiteBoxView])
        dynamicAnimator.addBehavior(gravityBehavior)
        
        let collisionBehavior = UICollisionBehavior(items: [redBoxView, whiteBoxView])
        collisionBehavior.collisionMode = .everything
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        collisionBehavior.collisionDelegate = nil
        dynamicAnimator.addBehavior(collisionBehavior)
    }
}
