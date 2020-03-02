//
//  RotateAnimateProtocol.swift
//  AnimationView
//
//  Created by Amir Ardalan on 3/2/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import UIKit

protocol RotateAnimate {
    func animate(with radius:CGFloat)
}

extension RotateAnimate where Self : RotateAnimationView {
    
    func animate(with radius:CGFloat){
        let angle: CGFloat = radius * CGFloat((180 / Double.pi));
        UIView.animate(withDuration: 0.5) {
            self.rotateImage.transform = CGAffineTransform(rotationAngle: angle)
        }
    }
}
