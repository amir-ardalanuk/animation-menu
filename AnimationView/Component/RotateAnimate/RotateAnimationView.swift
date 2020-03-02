
//
//  ViewRotateAnimate.swift
//  AnimationView
//
//  Created by Amir Ardalan on 3/2/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import UIKit

class RotateAnimationView : CustomView , Connectable ,RotateAnimate {
    
    @IBOutlet weak var rotateImage: UIImageView!
    
    enum State{
        case normal
        case rotate
        case inAnimate
    }
    
    var state : State = .normal
    var onTapRunner: (()->Bool)?
    
    @IBInspectable var rotate: CGFloat = -15
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    
    private func setup(){
        self.commit()
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
        
        self.tap = {
            
            guard  (self.onTapRunner?() ?? false) == true else {
                return
            }
            
            self.tapHandler()
        }
    }
    
    func config(_ config : RotateAnimationConfig){
        self.rotateImage.image = config.image
        self.rotate = config.rotate
        self.backgroundColor = config.background
    }
    
    func tapHandler(){
        switch self.state {
        case .normal:
            toRotateState()
        case .rotate:
            toNormalState()
        case .inAnimate:
            return
        }
    }
    
    func toNormalState(){
        self.animate(with: 0)
        self.state = .normal
    }
    
    func toRotateState(){
        self.animate(with: self.rotate)
        self.state = .rotate
    }
    
    
}
