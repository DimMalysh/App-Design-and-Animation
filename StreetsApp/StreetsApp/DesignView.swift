//
//  DesignView.swift
//  BasicAnimation
//
//  Created by mac on 26.03.18.
//  Copyright © 2018 Dim Malysh. All rights reserved.
//

import UIKit

@IBDesignable class DesignView: AnimationView {
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
}
