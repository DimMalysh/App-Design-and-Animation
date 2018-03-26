//
//  Animation.swift
//  BasicAnimation
//
//  Created by mac on 24.03.18.
//  Copyright © 2018 Dim Malysh. All rights reserved.
//

import UIKit

@objc public protocol Animatable {
    var startAnimation: Bool {get set}
    var nameOfAnimation: String {get set}
    var x: CGFloat {get set}
    var y: CGFloat {get set}
    var force: CGFloat {get set}
    var animateForm: Bool {get set}
    var duration: CGFloat {get set}
    var delay: CGFloat {get set}
    var damping: CGFloat {get set}
    var velocity: CGFloat {get set}
    
    //UIView
    var transform: CGAffineTransform {get set}
    
    func animate()
}

class Animation: NSObject {
    private unowned var view: Animatable
    private var shouldAnimateAfterActive = false
    
    init (_ view: Animatable) {
        self.view = view
        super.init()
        initOfNotification()
    }
    
    func initOfNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive(_:)), name: .UIApplicationDidBecomeActive, object: nil)
    }
    
    func didBecomeActive(_ notification: Notification) {
        if shouldAnimateAfterActive {
            animate()
            shouldAnimateAfterActive = false
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .UIApplicationDidBecomeActive, object: nil)
    }
    
    private var startAnimation: Bool {
        get {
            return self.view.startAnimation
        }
        set {
            self.view.startAnimation = newValue
        }
    }
    
    private var animateForm: Bool {
        get {
            return self.view.animateForm
        }
        set {
            self.view.animateForm = newValue
        }
    }
    
    private var nameOfAnimation: String {
        get {
            return self.view.nameOfAnimation
        }
        set {
            self.view.nameOfAnimation = newValue
        }
    }

    private var x: CGFloat {
        get {
            return self.view.x
        }
        set {
            self.view.x = newValue
        }
    }
    
    private var y: CGFloat {
        get {
            return self.view.y
        }
        set {
            self.view.y = newValue
        }
    }
    
    private var force: CGFloat {
        get {
            return self.view.force
        }
        set {
            self.view.force = newValue
        }
    }
    
    var duration: CGFloat {
        get {
            return self.view.duration
        }
        set {
            self.view.duration = newValue
        }
    }
    
    var delay: CGFloat {
        get {
            return self.view.delay
        }
        set {
            self.view.delay = newValue
        }
    }

    
    var damping: CGFloat {
        get {
            return self.view.damping
        }
        set {
            self.view.damping = newValue
        }
    }

    
    var velocity: CGFloat {
        get {
            return self.view.velocity
        }
        set {
            self.view.velocity = newValue
        }
    }
    
    //UIView
    private var transform: CGAffineTransform {
        get {
            return self.view.transform
        }
        set {
            self.view.transform = newValue
        }
    }
    
    enum AnimationPreset: String {
        case slideLeft = "slideLeft"
        case slideRight = "slideRight"
    }
    
    func animatePreset() {
        if let animation = AnimationPreset(rawValue: nameOfAnimation) {
            switch animation {
            case .slideLeft: x = 300 * force
            case .slideRight: x = -300 * force
            }
        }
    }
    
    func animate() {
        animateForm = true
        animatePreset()
        configureView()
    }
    
    func configureView() {
        if animateForm {
            let translate = CGAffineTransform(translationX: x, y: y)
            transform = translate
        }
        
        UIView.animate(withDuration: TimeInterval(duration), delay: TimeInterval(delay), usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: .curveEaseInOut, animations: { [weak self] in
            if let _self = self {
                if _self.animateForm {
                    _self.transform = .identity
                } else {
                    let translate = CGAffineTransform(translationX: _self.x, y: _self.y)
                    _self.transform = translate
                }
            }
        }) { [weak self] finished in
            self?.resetAll()
        }
    }
    
    func resetAll() {
        x = 0.0
        y = 0.0
        nameOfAnimation = ""
        damping = 0.7
        velocity = 0.7
        delay = 0.0
        duration = 0.7
    }
    
    func customdidMoveToWindow() {
        if startAnimation {
            if UIApplication.shared.applicationState != .active {
                shouldAnimateAfterActive = true
                return
            }
            
            animate()
        }
    }
}
