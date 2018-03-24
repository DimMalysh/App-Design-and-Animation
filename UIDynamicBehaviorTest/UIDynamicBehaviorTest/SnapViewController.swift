//
//  SnapViewController.swift
//  UIDynamicBehaviorTest
//
//  Created by mac on 24.03.18.
//  Copyright © 2018 Dim Malysh. All rights reserved.
//

import UIKit

class SnapViewController: UIViewController {
    var boxView: UIView!
    var dynamicAnimator: UIDynamicAnimator!
    
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
            
        case .ended:
            let size = view.frame.size
            let lead = point.x
            let tail = size.width - point.x
            let bottom = size.height - point.y
            
            let edge = boxView.frame.size.width / 2
            
            var tempPoint = CGPoint()
            if lead < tail {
                tempPoint = lead < bottom ? CGPoint(x: edge, y: point.y) : CGPoint(x: point.x, y: size.height - edge)
            } else {
                tempPoint = tail < bottom ? CGPoint(x: size.width - edge, y: point.y) : CGPoint(x: point.x, y: size.height - edge)
            }
            
            let snapBehavior = UISnapBehavior(item: boxView, snapTo: tempPoint)
            snapBehavior.damping = 0.55
            dynamicAnimator.addBehavior(snapBehavior)
            
        default:
            break
        }
    }
}
