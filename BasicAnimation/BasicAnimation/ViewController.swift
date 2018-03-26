//
//  ViewController.swift
//  BasicAnimation
//
//  Created by mac on 24.03.18.
//  Copyright © 2018 Dim Malysh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var boxView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //controlPointAnimation()
    }
    
    //MARK: - SlideLeft and Right
    func slideLetfToRight() {
        let force: CGFloat = 1.0
        let translate = CGAffineTransform(translationX: -300.0 * force, y: 0.0)
        boxView.transform = translate
        
        UIView.animate(withDuration: 1.7, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
            self.boxView.transform = CGAffineTransform(translationX: 0.0, y: 0.0)
        }, completion: nil)
    }
    
    func slideRightToLetf() {
        let force: CGFloat = 1.0
        let translate = CGAffineTransform(translationX: 300.0 * force, y: 0.0)
        boxView.transform = translate
        
        UIView.animate(withDuration: 1.7, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
            self.boxView.transform = CGAffineTransform(translationX: 0.0, y: 0.0)
        }, completion: nil)
    }
    
    //MARK: - ZoomIn and Out
    func zoomIn() {
        let force: CGFloat = 1.0
        let scale = CGAffineTransform(scaleX: 2.0 * force, y: 2.0 * force)
        boxView.transform = scale
        
        UIView.animate(withDuration: 1.7, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
            self.boxView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: nil)
    }
    
    func zoomOut() {
        let force: CGFloat = 1.0
        let scale = CGAffineTransform(scaleX: 0.0 * force, y: 0.0 * force)
        boxView.transform = scale
        
        UIView.animate(withDuration: 1.7, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
            self.boxView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: nil)
    }
    
    //MARK: - SqueezeLeft and Right (translate + scale)
    func squeezeLeftToRight() {
        let force: CGFloat = 1.0
        let translate = CGAffineTransform(translationX: -300.0 * force, y: 0.0)
        let scale = CGAffineTransform(scaleX: 3.0 * force, y: 0.0 * force)
        boxView.transform = translate.concatenating(scale)
        
        UIView.animate(withDuration: 1.7, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
            let translate = CGAffineTransform(translationX: 0.0 * force, y: 0.0)
            let scale = CGAffineTransform(scaleX: 1.0 * force, y: 1.0 * force)
            self.boxView.transform = translate.concatenating(scale)
        }, completion: { finished in
            print("Animation completed")
        })
    }
    
    func squeezeRightToLeft() {
        let force: CGFloat = 1.0
        
        let translate = CGAffineTransform(translationX: 300.0 * force, y: 0.0)
        let scale = CGAffineTransform(scaleX: 3.0 * force, y: 0.0 * force)
        boxView.transform = translate.concatenating(scale)
        
        UIView.animate(withDuration: 1.7, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
            let translate = CGAffineTransform(translationX: 0.0 * force, y: 0.0)
            let scale = CGAffineTransform(scaleX: 1.0 * force, y: 1.0 * force)
            self.boxView.transform = translate.concatenating(scale)
            
        }, completion: { finished in
            //print("Animation completed")
        })
    }
    
    //MARK: - FadeIn and Out
    func fadeIn() {
        let opacity: CGFloat = 0.0
        boxView.alpha = opacity
        
        UIView.animate(withDuration: 1.7, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
            let opacity: CGFloat = 1.0
            self.boxView.alpha = opacity
        }, completion: nil)
    }
    
    func fadeOut() {
        let opacity: CGFloat = 1.0
        boxView.alpha = opacity
        
        UIView.animate(withDuration: 1.7, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
            let opacity: CGFloat = 0.0
            self.boxView.alpha = opacity
        }, completion: nil)
    }
    
    //MARK: - Shake
    func shakeAnimation() {
        let force: CGFloat = 10.0
        let shake = CAKeyframeAnimation()
        shake.keyPath = "position.x"
        shake.values = [0, 30 * force, -30 * force, 30 * force, 0]
        shake.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1.0]
        shake.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        shake.duration = 2
        shake.isAdditive = true
        shake.repeatCount = 1
        shake.beginTime = CACurrentMediaTime() + 0
        boxView.layer.add(shake, forKey: nil)
    }
    
    //MARK: - MorphX and Y
    func morphX() {
        let force: CGFloat = 1.0
        let morphX = CAKeyframeAnimation()
        morphX.keyPath = "transform.scale.x"
        morphX.values = [1, 1.3 * force, 0.7, 1.3 * force, 1]
        morphX.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1.0]
        morphX.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        morphX.duration = 5
        morphX.repeatCount = 1
        morphX.beginTime = CACurrentMediaTime() + 0
        boxView.layer.add(morphX, forKey: nil)
    }
    
    func morphY() {
        let force: CGFloat = 1.0
        let morphY = CAKeyframeAnimation()
        morphY.keyPath = "transform.scale.y"
        morphY.values = [1, 0.7, 1.3 * force, 0.7, 1]
        morphY.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1.0]
        morphY.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        morphY.duration = 5
        morphY.repeatCount = 1
        morphY.beginTime = CACurrentMediaTime() + 0
        boxView.layer.add(morphY, forKey: nil)
    }
    
    func morphXandY() {
        let force: CGFloat = 1.0
        let morphX = CAKeyframeAnimation()
        morphX.keyPath = "transform.scale.x"
        morphX.values = [1, 1.3 * force, 0.7, 1.3 * force, 1]
        morphX.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1.0]
        morphX.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        morphX.duration = 5
        morphX.repeatCount = 1
        morphX.beginTime = CACurrentMediaTime() + 0
        boxView.layer.add(morphX, forKey: nil)
        
        let morphY = CAKeyframeAnimation()
        morphY.keyPath = "transform.scale.y"
        morphY.values = [1, 0.7, 1.3 * force, 0.7, 1]
        morphY.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1.0]
        morphY.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        morphY.duration = 5
        morphY.repeatCount = 1
        morphY.beginTime = CACurrentMediaTime() + 0
        boxView.layer.add(morphY, forKey: nil)
    }
    
    //MARK: - Control point animation
    //Examples of control points can be found on the website: easings.net
    func controlPointAnimation() {
        let force: CGFloat = 1.0
        let shake = CAKeyframeAnimation()
        shake.keyPath = "position.x"
        shake.values = [0, 30 * force, -30 * force, 30 * force, 0]
        shake.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1.0]
        
        //Control point is 0.77, 0, 0.175, 1
        shake.timingFunction = CAMediaTimingFunction(controlPoints: 0.77, 0, 0.175, 1)
        shake.duration = 2
        shake.isAdditive = true
        shake.repeatCount = 1
        shake.beginTime = CACurrentMediaTime() + 0
        boxView.layer.add(shake, forKey: nil)
    }
}

