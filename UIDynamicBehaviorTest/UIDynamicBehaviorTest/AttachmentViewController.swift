//
//  AttachmentViewController.swift
//  UIDynamicBehaviorTest
//
//  Created by mac on 24.03.18.
//  Copyright © 2018 Dim Malysh. All rights reserved.
//

import UIKit

class AttachmentViewController: UIViewController {
    var boxView: UIView!
    var endOfRopeImageView: UIImageView!
    var ropeShapeLayer: CAShapeLayer!
    var dynamicAnimator: UIDynamicAnimator!
    var attachmentBehavior: UIAttachmentBehavior!
    var isBoxView = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.darkGray
        
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        
        boxView = UIView(frame: CGRect(origin: CGPoint(x: 100.0, y: 100.0),
                                         size: CGSize(width: 80.0, height: 80.0)))
        boxView.backgroundColor = UIColor.lightGray
        view.addSubview(boxView)
        
        endOfRopeImageView = UIImageView(image: UIImage(named: "AttachmentPointMask"))
        endOfRopeImageView.frame = CGRect(origin: CGPoint(x: 0.0, y: 0.0),
                                       size: CGSize(width: 10.0, height: 10.0))
        endOfRopeImageView.center = CGPoint(x: boxView.bounds.size.width / 2 - 30,
                                       y: boxView.bounds.size.height / 2 - 30)
        endOfRopeImageView.backgroundColor = UIColor.lightGray
        endOfRopeImageView.layer.borderWidth = 2.0
        endOfRopeImageView.layer.borderColor = UIColor.white.cgColor
        endOfRopeImageView.layer.cornerRadius = 5.0
        endOfRopeImageView.layer.masksToBounds = true
        boxView.addSubview(endOfRopeImageView)
        
        boxView.addObserver(self, forKeyPath: "center", options: .new, context: nil)
        
        let gravityBehavior = UIGravityBehavior(items: [boxView])
        dynamicAnimator.addBehavior(gravityBehavior)
        
        attachmentBehavior = UIAttachmentBehavior(item: boxView,
                                                  offsetFromCenter: UIOffsetMake(-30.0, -30.0),
                                                  attachedToAnchor: CGPoint(x: view.bounds.midX, y: 120.0))
        attachmentBehavior.length = isBoxView ? 60.0 : 120.0
        attachmentBehavior.damping = 0.1
        attachmentBehavior.frequency = isBoxView ? 0.6 : 0.0
        dynamicAnimator.addBehavior(attachmentBehavior)
        
        let collisionBehavior = UICollisionBehavior(items: [boxView])
        collisionBehavior.collisionMode = .everything
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        dynamicAnimator.addBehavior(collisionBehavior)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        view.addGestureRecognizer(panGesture)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if ropeShapeLayer == nil {
            ropeShapeLayer = CAShapeLayer()
            ropeShapeLayer.fillColor = UIColor.clear.cgColor
            ropeShapeLayer.lineJoin = kCALineJoinRound
            ropeShapeLayer.lineWidth = 2.0
            ropeShapeLayer.strokeColor = UIColor.white.cgColor
            ropeShapeLayer.strokeEnd = 1.0
            view.layer.addSublayer(ropeShapeLayer)
        }
        
        let point = view.convert(endOfRopeImageView.center, from: boxView)
        let bezierPath = UIBezierPath()
        bezierPath.move(to: attachmentBehavior.anchorPoint)
        bezierPath.addLine(to: point)
        ropeShapeLayer.path = bezierPath.cgPath
    }
    
    deinit {
        boxView.removeObserver(self, forKeyPath: "center")
    }
    
    func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        let point = sender.location(in: view)
        attachmentBehavior.anchorPoint = point
    }
}
