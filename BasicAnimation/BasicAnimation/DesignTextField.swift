//
//  DesignTextField.swift
//  BasicAnimation
//
//  Created by mac on 26.03.18.
//  Copyright © 2018 Dim Malysh. All rights reserved.
//

import UIKit

@IBDesignable class DesignTextField: AnimationTextField {
    @IBInspectable var placeholderColor: UIColor = UIColor.clear {
        didSet {
            attributedPlaceholder = NSAttributedString(string: placeholder!, attributes: [NSForegroundColorAttributeName: placeholderColor])
            layoutSubviews()
        }
    }
    
    @IBInspectable var sidePadding: CGFloat = 0.0 {
        didSet {
            let padding = UIView(frame: CGRect(x: 0.0, y: 0.0, width: sidePadding, height: sidePadding))
            leftViewMode = .always
            leftView = padding
            rightViewMode = .always
            rightView = padding
        }
    }
    
    @IBInspectable var leftPadding: CGFloat = 0.0 {
        didSet {
            let padding = UIView(frame: CGRect(x: 0.0, y: 0.0, width: leftPadding, height: 0.0))
            leftViewMode = .always
            leftView = padding
        }
    }
    
    @IBInspectable var rightPadding: CGFloat = 0.0 {
        didSet {
            let padding = UIView(frame: CGRect(x: 0.0, y: 0.0, width: rightPadding, height: 0.0))
            rightViewMode = .always
            rightView = padding
        }
    }
}
