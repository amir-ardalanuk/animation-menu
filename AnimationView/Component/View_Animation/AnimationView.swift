//
//  AnimationView.swift
//  AnimationView
//
//  Created by Amir Ardalan on 3/2/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import UIKit
struct AnimationConfig {
    var x : CGFloat
    var y : CGFloat
    var delay : TimeInterval
    var animteTime : CGFloat
    var firstDelay : TimeInterval
    var complete : (Bool)->Void
    
}
class AnimationView: UIView , Connectable {
    
    @IBOutlet weak var lblTitle: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    enum State {
        case colapse
        case expand
        case animating
    }
    
    var state : State = .colapse
    var animateConfig : AnimationConfig?
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    
    private func setup(){
        self.commit()
    }
    
    func config(_ config : AnimationViewConfig){
        self.lblTitle.textColor = config.textColor
        self.backgroundColor = config.color
        self.lblTitle.text = config.text
        self.animateConfig = config.animateData
        self.layer.cornerRadius = self.frame.width / 2
    }
    
    func animate(){
        guard let animationCnfg = self.animateConfig else {return}
        animate(config: animationCnfg)
    }
   private func animate(config:AnimationConfig){
        switch state{
        case .colapse:
            self.expandAnimate(config: config)
        case .expand:
            self.collapseAnimation(config: config)
        case .animating:
            return
        }
    }
    
    func expandAnimate(config:AnimationConfig){
        self.isHidden = false
        self.state = .animating
        self.lblTitle.isHidden = true
        UIView.animate(withDuration: 0.5, delay:config.firstDelay   , options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.transform = CGAffineTransform.init(translationX: 0, y:  config.y)
        },completion: {state in
            
            UIView.animate(withDuration: 0.5, delay:0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                self.lblTitle.alpha = 1
                self.lblTitle.isHidden = false
                //self.transform = CGAffineTransform.init(scaleXself.center = self.superview!.center
                self.frame.size = CGSize(width: self.bounds.width * 2, height: self.frame.height )
                 self.transform = CGAffineTransform.init(translationX: -self.bounds.width / 4, y:  config.y)
                
            },completion: { state in
                self.state = .expand
            })
        })
        
        
    }
    
    func collapseAnimation(config:AnimationConfig){
        
        self.state = .animating
        UIView.animate(withDuration:0.5 , delay:config.firstDelay   , options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.lblTitle.alpha = 0
            self.lblTitle.isHidden = true
               self.frame.size = CGSize(width: self.bounds.width / 2, height: self.bounds.height )
                self.layoutSubviews()
            self.transform = CGAffineTransform.init(translationX: 0, y:  config.y)
        },completion: {state in
            UIView.animate(withDuration: 0.5,
                           delay:0,
                           options: UIView.AnimationOptions.curveEaseOut, animations: {
                            self.transform = CGAffineTransform.init(translationX: 0, y: 0)
            }, completion: { state in
                self.isHidden = true
                config.complete(state)
                self.state = .colapse
            })
        })
        
        
    }
    
    
}
