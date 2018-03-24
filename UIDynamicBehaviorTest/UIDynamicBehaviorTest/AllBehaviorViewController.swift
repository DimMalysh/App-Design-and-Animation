//
//  AllBehaviorViewController.swift
//  UIDynamicBehaviorTest
//
//  Created by mac on 24.03.18.
//  Copyright © 2018 Dim Malysh. All rights reserved.
//

import UIKit

class AllBehaviorViewController: UIViewController {
    var boxes = [UIView]()
    var dynamicAnimator: UIDynamicAnimator!
    var attachmentBehavior: UIAttachmentBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.darkGray
        
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        
        for index in 0..<6 {
            let boxView = UIView(frame: CGRect(origin: CGPoint(x: CGFloat(index) * 60.0, y: 200.0),
                                               size: CGSize(width: 30.0, height: 30.0)))
            boxView.backgroundColor = UIColor.green
            boxView.layer.cornerRadius = 15.0
            boxView.layer.masksToBounds = true
            view.addSubview(boxView)
            boxes.append(boxView)
        }
        
        let dynamicItemBehavior = UIDynamicItemBehavior(items: boxes)
        dynamicItemBehavior.angularResistance = 0.5
        dynamicItemBehavior.density = 10.0
        dynamicItemBehavior.elasticity = 0.6
        dynamicItemBehavior.friction = 0.3
        dynamicItemBehavior.resistance = 0.3
        dynamicAnimator.addBehavior(dynamicItemBehavior)
        
        let gravityBehavior = UIGravityBehavior(items: boxes)
        dynamicAnimator.addBehavior(gravityBehavior)
        
        let collisionBehavior = UICollisionBehavior(items: boxes)
        collisionBehavior.collisionMode = .everything
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        dynamicAnimator.addBehavior(collisionBehavior)
        
        attachmentBehavior = UIAttachmentBehavior(item: boxes.first!, attachedToAnchor: boxes.first!.center)
        attachmentBehavior.anchorPoint = CGPoint(x: 150.0, y: 80.0)
        attachmentBehavior.length = 10.0
        attachmentBehavior.damping = 1.0
        attachmentBehavior.frequency = 1.0
        dynamicAnimator.addBehavior(attachmentBehavior)
        
        for index in 1..<boxes.count {
            let boxView = boxes[index]
            let tempAttachmentBehavior = UIAttachmentBehavior(item: boxView, attachedTo: boxes[index - 1])
            tempAttachmentBehavior.length = 25.0
            tempAttachmentBehavior.frequency = 3.0
            dynamicAnimator.addBehavior(tempAttachmentBehavior)
        }
    
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        view.addGestureRecognizer(panGesture)
    }
    
    func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        if !dynamicAnimator.behaviors.contains(attachmentBehavior) {
            dynamicAnimator.addBehavior(attachmentBehavior)
        }
        
        let point = sender.location(in: view)
        attachmentBehavior.anchorPoint = point
        
        switch sender.state {
        case .ended: dynamicAnimator.removeBehavior(attachmentBehavior)
        default: break
        }
    }
}
