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
    var curve: String {get set}
    var x: CGFloat {get set}
    var y: CGFloat {get set}
    var scaleX: CGFloat {get set}
    var scaleY: CGFloat {get set}
    var force: CGFloat {get set}
    var repeatCount: Float {get set}
    var opacity: CGFloat {get set}
    var animateForm: Bool {get set}
    var duration: CGFloat {get set}
    var delay: CGFloat {get set}
    var damping: CGFloat {get set}
    var velocity: CGFloat {get set}
    
    //UIView
    var transform: CGAffineTransform {get set}
    var layer: CALayer {get}
    var alpha: CGFloat {get set}
    
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
    
    private var curve: String {
        get {
            return self.view.curve
        }
        set {
            self.view.curve = newValue
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
    
    private var scaleX: CGFloat {
        get {
            return self.view.scaleX
        }
        set {
            self.view.scaleX = newValue
        }
    }
    
    private var scaleY: CGFloat {
        get {
            return self.view.scaleY
        }
        set {
            self.view.scaleY = newValue
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
    
    private var repeatCount: Float {
        get {
            return self.view.repeatCount
        }
        set {
            self.view.repeatCount = newValue
        }
    }
    
    private var opacity: CGFloat {
        get {
            return self.view.opacity
        }
        set {
            self.view.opacity = newValue
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
    
    private var alpha: CGFloat {
        get {
            return self.view.alpha
        }
        set {
            self.view.alpha = newValue
        }
    }
    
    private var layer: CALayer {
        return view.layer
    }

    enum AnimationPreset: String {
        case slideLeft = "slideLeft"
        case slideRight = "slideRight"
        case zoomIn = "zoomIn"
        case zoomOut = "zoomOut"
        case squeezeLeft = "squeezeLeft"
        case squeezeRight = "squeezeRight"
        case shake = "shake"
        case morph = "morph"
    }
    
    enum AnimationCurve: String {
        case easeIn = "easeIn"
        case easeOut = "easeOut"
        case easeInOut = "easeInOut"
        case linear = "linear"
        case easeOutCirc = "easeOutCirc"
        case easeInOutCirc = "easeInOutCirc"
    }
    
    func animatePreset() {
        alpha = 1.0
        if let animation = AnimationPreset(rawValue: nameOfAnimation) {
            switch animation {
            case .slideLeft:
                x = 300.0 * force

            case .slideRight:
                x = -300.0 * force
                
            case .zoomIn:
                opacity = 0.0
                scaleX = 2.0 * force
                scaleY = 2.0 * force
                
            case .zoomOut:
                opacity = 0.0
                animateForm = false
                scaleX = 2.0 * force
                scaleY = 2.0 * force
                
            case .squeezeLeft:
                x = 300.0
                scaleX = 3.0 * force
                
            case .squeezeRight:
                x = -300.0
                scaleX = 3.0 * force
                
            case .shake:
                let animation = CAKeyframeAnimation()
                animation.keyPath = "position.x"
                animation.values = [0, 30 * force, -30 * force, 30 * force, 0]
                animation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1.0]
                animation.timingFunction = animateCurveTimingFunction(curve: curve)
                animation.duration = CFTimeInterval(duration)
                animation.isAdditive = true
                animation.repeatCount = repeatCount
                animation.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
                layer.add(animation, forKey: "shake")
                
            case .morph:
                let morphX = CAKeyframeAnimation()
                morphX.keyPath = "transform.scale.x"
                morphX.values = [1, 1.3 * force, 0.7, 1.3 * force, 1]
                morphX.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1.0]
                morphX.timingFunction = animateCurveTimingFunction(curve: curve)
                morphX.duration = CFTimeInterval(duration)
                morphX.repeatCount = repeatCount
                morphX.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
                layer.add(morphX, forKey: "morphX")
                
                let morphY = CAKeyframeAnimation()
                morphY.keyPath = "transform.scale.y"
                morphY.values = [1, 0.7, 1.3 * force, 0.7, 1]
                morphY.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1.0]
                morphY.timingFunction = animateCurveTimingFunction(curve: curve)
                morphY.duration = CFTimeInterval(duration)
                morphY.repeatCount = repeatCount
                morphY.beginTime = CACurrentMediaTime() + CFTimeInterval(delay)
                layer.add(morphY, forKey: "morphY")
            }
        }
    }
    
    func animateCurveTimingFunction(curve: String) -> CAMediaTimingFunction {
        if let curve = AnimationCurve(rawValue: curve) {
            switch curve {
            case .easeIn: return CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
            case .easeOut: return CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            case .easeInOut: return CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            case .linear: return CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            case .easeOutCirc: return CAMediaTimingFunction(controlPoints: 0.075, 0.82, 0.165, 1.0)
            case .easeInOutCirc: return CAMediaTimingFunction(controlPoints: 0.785, 0.135, 0.15, 0.86)
            }
        }
        return CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
    }
    
    func animationOptions(curve: String) -> UIViewAnimationOptions {
        if let curve = AnimationCurve(rawValue: curve) {
            switch curve {
            case .easeIn: return .curveEaseIn
            case .easeOut: return .curveEaseOut
            case .easeInOut: return .curveEaseInOut
            default: break
            }
        }
        return .curveLinear
    }
    
    func animate() {
        animateForm = true
        animatePreset()
        configureView()
    }
    
    func configureView() {
        if animateForm {
            let translate = CGAffineTransform(translationX: x, y: y)
            let scale = CGAffineTransform(scaleX: scaleX, y: scaleY)
            transform = translate.concatenating(scale)
            alpha = opacity
        }
        
        UIView.animate(withDuration: TimeInterval(duration), delay: TimeInterval(delay), usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: animationOptions(curve: curve), animations: { [weak self] in
            if let _self = self {
                if _self.animateForm {
                    _self.transform = .identity
                    _self.alpha = 1.0
                } else {
                    let translate = CGAffineTransform(translationX: _self.x, y: _self.y)
                    let scale = CGAffineTransform(scaleX: _self.scaleX, y: _self.scaleY)
                    _self.transform = translate.concatenating(scale)
                    
                    _self.alpha = _self.opacity
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
        repeatCount = 1.0
    }
    
    func customdidMoveToWindow() {
        if startAnimation {
            if UIApplication.shared.applicationState != .active {
                shouldAnimateAfterActive = true
                return
            }
            alpha = 0.0
            animate()
        }
    }
}
