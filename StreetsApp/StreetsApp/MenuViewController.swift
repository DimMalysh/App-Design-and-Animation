//
//  MenuViewController.swift
//  StreetsApp
//
//  Created by mac on 23.03.18.
//  Copyright © 2018 Dim Malysh. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    @IBOutlet weak var backgroundMaskView: UIView!
    @IBOutlet weak var dialogView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var userView: UIView!
    
    var dynamicAnimator: UIDynamicAnimator!
    var attachmentBehavior: UIAttachmentBehavior!
    var snapBehavior: UISnapBehavior!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Set blur effect.
        addBlurEffect(view: backgroundMaskView, style: .dark)
        addBlurEffect(view: headerView, style: .dark)
        addBlurEffect(view: bottomView, style: .dark)
        
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        snapBehavior = UISnapBehavior(item: dialogView, snapTo: view.center)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let scale = CGAffineTransform(scaleX: 0.5, y:  0.5)
        let translate = CGAffineTransform(translationX: 0.0, y: -300.0)
        dialogView.transform = scale.concatenating(translate)
        
        UIView.animate(withDuration: 0.5) {
            let scale = CGAffineTransform(scaleX: 1.0, y:  1.0)
            let translate = CGAffineTransform(translationX: 0.0, y: 0.0)
            self.dialogView.transform = scale.concatenating(translate)
        }
    }
    
    @IBAction func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        let tempDialogView = dialogView!
        let location = sender.location(in: view)
        let boxLocation = sender.location(in: dialogView)
        
        switch sender.state {
        case .began:
            dynamicAnimator.removeBehavior(snapBehavior)
            let centerOffset = UIOffsetMake(boxLocation.x - tempDialogView.bounds.midX,
                                            boxLocation.y - tempDialogView.bounds.midY)
            attachmentBehavior = UIAttachmentBehavior(item: tempDialogView,
                                                      offsetFromCenter: centerOffset,
                                                      attachedToAnchor: location)
            attachmentBehavior.frequency = 0.0
            dynamicAnimator.addBehavior(attachmentBehavior)
            
            UIView.animate(withDuration: 0.5, animations: {
                self.userView.frame = CGRect(origin: CGPoint(x: 43.0, y :425.0), size: CGSize(width: 235.0, height: 50.0))
            })
            
        case .changed:
            attachmentBehavior.anchorPoint = location
            
        case .ended:
            dynamicAnimator.removeBehavior(attachmentBehavior)
            snapBehavior = UISnapBehavior(item: tempDialogView, snapTo: view.center)
            dynamicAnimator.addBehavior(snapBehavior)
            
        default: break
        }
    }
    
    func addBlurEffect(view: UIView, style: UIBlurEffectStyle) {
        view.backgroundColor = UIColor.clear
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        view.insertSubview(blurEffectView, at: 0)
    }
}
