//
//  AnimationButton.swift
//  StreetsApp
//
//  Created by mac on 26.03.18.
//  Copyright © 2018 Dim Malysh. All rights reserved.
//

import UIKit

class AnimationButton: UIButton, Animatable {
    @IBInspectable var startAnimation: Bool = false
    @IBInspectable var nameOfAnimation: String = ""
    @IBInspectable var curve: String = ""
    @IBInspectable var force: CGFloat = 1.0
    @IBInspectable var x: CGFloat = 0.0
    @IBInspectable var y: CGFloat = 0.0
    @IBInspectable var scaleX: CGFloat = 1.0
    @IBInspectable var scaleY: CGFloat = 1.0
    @IBInspectable var duration: CGFloat = 0.7
    @IBInspectable var repeatCount: Float = 1.0
    @IBInspectable var delay: CGFloat = 0.0
    @IBInspectable var damping: CGFloat = 0.7
    @IBInspectable var velocity: CGFloat = 0.7
    var animateForm: Bool = false
    var opacity: CGFloat = 1.0
    
    lazy private var privateAnimation: Animation = Animation(self)
    
    func animate() {
        privateAnimation.animate()
        
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        privateAnimation.customdidMoveToWindow()
    }
}
