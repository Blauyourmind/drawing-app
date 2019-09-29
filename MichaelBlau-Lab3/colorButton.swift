//
//  colorButton.swift
//  MichaelBlau-Lab3
//
//  Created by michael blau on 9/25/19.
//  Copyright © 2019 michael blau. All rights reserved.
//

import UIKit

//medium.com/@filswino/easiest-implementation-of-rounded-buttons-in-xcode-6627efe39f84
@IBDesignable
class colorButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    //stackoverflow.com/questions/46256623/apply-custom-uibutton-styling-to-all-buttons
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            self.clipsToBounds = true
            self.layer.masksToBounds = true
        }
    }
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.layer.cornerRadius = 25
//        self.layer.masksToBounds = true
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        self.layer.cornerRadius = 25
//        self.layer.masksToBounds = true
//    }
}

