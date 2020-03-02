//
//  CustomView.swift
//  AnimationView
//
//  Created by Amir Ardalan on 3/2/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import UIKit

class CustomView: UIView {
    
    var dashLayer: CAShapeLayer?
    
    
    var tempOffset = CGSize()
    @IBInspectable var borderWidth: CGFloat = 0{
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var hasShadow: Bool = false {
        didSet {
            self.config()
        }
    }
    
    @IBInspectable var borderColor: UIColor! = UIColor.clear {
        didSet {
            config()
        }
    }
    
    
    @IBInspectable var radius: CGFloat = 0 {
        didSet {
            config()
        }
    }
    
    var tap : (()->Void)?{
        didSet{
            initaili()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        config()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let dash = self.dashLayer {
            self.layer.addSublayer(dash)
        }
        
    }
    
    func config() {
        
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.setCorner(radius: self.radius)
    }
    
    func initaili(){
        if let _ = self.tap {
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.clickOn))
            self.addGestureRecognizer(tap)
        }
    }
    @objc func clickOn(){
        if let clicki = self.tap {
            clicki()
        }
    }
    
    func setCorner(radius : CGFloat){
        self.layer.cornerRadius = radius
    }
    
    fileprivate func touchUp() {}
    
    
}
