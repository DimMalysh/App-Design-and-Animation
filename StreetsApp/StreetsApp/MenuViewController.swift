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
    @IBOutlet weak var dialogView: DesignView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var shareView: AnimationView!
    @IBOutlet weak var shareButton: AnimationButton!
    @IBOutlet weak var twitterButton: AnimationButton!
    @IBOutlet weak var facebookButton: AnimationButton!
    @IBOutlet weak var twitterLabel: AnimationLabel!
    @IBOutlet weak var facebookLabel: AnimationLabel!
    @IBOutlet weak var maskButton: UIButton!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var backgroundDialogImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var avatarImageVIew: UIImageView!
    
    var dynamicAnimator: UIDynamicAnimator!
    var attachmentBehavior: UIAttachmentBehavior!
    var snapBehavior: UISnapBehavior!
    
    var data = getData()
    var countRecord = 0
    
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
        
        dialogView.alpha = 0.0
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
        
        backgroundImageView.image = UIImage(named: data[countRecord]["image"]!)
        backgroundDialogImageView.image = UIImage(named: data[countRecord]["image"]!)
        avatarImageVIew.image = UIImage(named: data[countRecord]["avatar"]!)
        titleLabel.text = data[countRecord]["title"]
        
        dialogView.alpha = 1.0
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
            
            let translate = sender.translation(in: view)
            if translate.x > 235.0 {
                dynamicAnimator.removeAllBehaviors()
                
                let gravityBehavior = UIGravityBehavior(items: [dialogView])
                gravityBehavior.gravityDirection = CGVector(dx: 10.0, dy: 0.0)
                dynamicAnimator.addBehavior(gravityBehavior)
                
                delay(0.4) {
                    self.refreshView()
                }
            }
            
        default: break
        }
    }
    
    @IBAction func shareButtonAction(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            self.dialogView.frame = CGRect(x: 10.0, y: 100.0, width: 300.0, height: 285.0)
            self.userView.frame = CGRect(x: 43.0, y: 375.0, width: 235.0, height: 50.0)
        }
        
        shareView.isHidden = false
        shareView.nameOfAnimation = "fadeIn"
        shareView.animate()
        
        shareButton.nameOfAnimation = "shake"
        shareButton.animate()
        
        showMask()
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveLinear, animations: {
            self.dialogView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }, completion: nil)
        
        twitterButton.nameOfAnimation = "slideUp"
        twitterButton.delay = 0.5
        twitterButton.animate()
        
        twitterLabel.nameOfAnimation = "fadeIn"
        twitterLabel.delay = 0.6
        twitterLabel.animate()
        
        facebookButton.nameOfAnimation = "slideUp"
        facebookButton.delay = 0.7
        facebookButton.animate()
        
        twitterLabel.nameOfAnimation = "fadeIn"
        twitterLabel.delay = 0.8
        twitterLabel.animate()
        
        shareButton.isEnabled = false
    }
    
    @IBAction func maskButtonAction(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
            self.dialogView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.maskButton.alpha = 0.0
        }, completion: nil)
        
        shareView.nameOfAnimation = "fadeOut"
        shareView.animate()
        shareView.isHidden = true
        
        shareButton.isEnabled = true
    }
    
    //MARK: Helpers Methods
    
    func showMask() {
        maskButton.isHidden = false
        maskButton.alpha = 0.0
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
            self.maskButton.alpha = 1.0
        }, completion: nil)
    }
    
    func addBlurEffect(view: UIView, style: UIBlurEffectStyle) {
        view.backgroundColor = UIColor.clear
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        view.insertSubview(blurEffectView, at: 0)
    }
    
    func delay(_ delay: Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            DispatchQueue.main.async(execute: closure)
        }
    }
    
    func refreshView() {
        countRecord += 1
        if countRecord > 2 {
            countRecord = 0
        }
        
        dynamicAnimator.removeAllBehaviors()
        
        snapBehavior = UISnapBehavior(item: dialogView, snapTo: view.center)
        attachmentBehavior.anchorPoint = view.center
        
        dialogView.center = view.center
        viewDidAppear(true)
    }
}
