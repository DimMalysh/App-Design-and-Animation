//
//  PushViewController.swift
//  UIDynamicBehaviorTest
//
//  Created by mac on 24.03.18.
//  Copyright © 2018 Dim Malysh. All rights reserved.
//

import UIKit

class PushViewController: UIViewController {
    var boxView: UIView!
    var ropeShapeLayer: CAShapeLayer!
    var dynamicAnimator: UIDynamicAnimator!
    var pushBehavior: UIPushBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.darkGray
        
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        
        boxView = UIView(frame: CGRect(origin: CGPoint(x: 100.0, y: 200.0),
                                       size: CGSize(width: 80.0, height: 80.0)))
        boxView.backgroundColor = UIColor.lightGray
        view.addSubview(boxView)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        view.addGestureRecognizer(panGesture)
    }
    
    func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        let point = sender.location(in: view)
        
        switch sender.state {
        case .began, .cancelled:
            dynamicAnimator.removeAllBehaviors()
            
        case .changed:
            boxView.center = point
            
            if ropeShapeLayer == nil {
                ropeShapeLayer = CAShapeLayer()
                ropeShapeLayer.fillColor = UIColor.clear.cgColor
                ropeShapeLayer.lineJoin = kCALineJoinRound
                ropeShapeLayer.lineWidth = 2.0
                ropeShapeLayer.strokeColor = UIColor.white.cgColor
                ropeShapeLayer.strokeEnd = 1.0
                view.layer.addSublayer(ropeShapeLayer)
            }
            
            let bezierPath = UIBezierPath()
            bezierPath.move(to: point)
            bezierPath.addLine(to: view.center)
            ropeShapeLayer.path = bezierPath.cgPath

        case .ended:
            ropeShapeLayer.removeFromSuperlayer()
            ropeShapeLayer = nil
            
            let origin = view.center
            var distanceForMagnitude = sqrt(pow(origin.x - point.x, 2.0) + pow(origin.y - point.y, 2.0))
            let angle = atan2(origin.x - point.x, origin.y - point.y)
            
            distanceForMagnitude = max(distanceForMagnitude, 10.0)
            
            pushBehavior = UIPushBehavior(items: [boxView], mode: .instantaneous)
            pushBehavior.magnitude = distanceForMagnitude / 40
            pushBehavior.angle = angle
            pushBehavior.active = true
            dynamicAnimator.addBehavior(pushBehavior)
            
        default:
            break
        }
    }
}
