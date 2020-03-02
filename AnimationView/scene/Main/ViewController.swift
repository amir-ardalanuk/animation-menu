//
//  ViewController.swift
//  AnimationView
//
//  Created by Amir Ardalan on 3/2/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var animateObjectArray :[AnimationView] = []
    var width :CGFloat = 120
    var viewSize = CGSize(width: 45, height: 45)
    @IBOutlet weak var rotateView : RotateAnimationView!{
        didSet{
            self.rotateView.onTapRunner = {
                let count = self.animateObjectArray.reduce(0,{ (a,b) -> Int in
                    let curr =  b.state == .animating ? 1 : 0
                    return curr + a
                })
                guard count == 0 else {return false}
                self.animateObjectArray.forEach { (view) in
                    view.animate()
                }
                return true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animateObjectArray =  makeAnimateConfig().enumerated().map { (index,element) -> AnimationView in
            let view = AnimationView(frame: CGRect(x: self.view.frame.origin.x, y: rotateView.frame.origin.y , width: viewSize.width, height: viewSize.height))
            view.center = self.view.center
            self.view.insertSubview((view), belowSubview: self.rotateView)
            view.config(element)
            return view
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    func makeAnimateConfig() -> [AnimationViewConfig]{
        let green = AnimationViewConfig(color: .green,
                                        text: "Green",
                                        textColor: UIColor.white,
                                        width: 60,
                                        animateData: AnimationConfig(x: 100, y: 100, delay: 0.5, animteTime: 0.5, firstDelay: 0.0, complete: { (comp) in
                                            
                                        }) )
        let blue = AnimationViewConfig(color: .blue, text: "blue", textColor: UIColor.white, width: 60, animateData: AnimationConfig(x: 100, y: 150, delay: 0.5, animteTime: 0.5, firstDelay: 0.3, complete: { (comp) in
            
        }))
        let red = AnimationViewConfig(color: .red, text: "red", textColor: UIColor.white, width: 60,  animateData: AnimationConfig(x: 100, y: 200, delay: 0.5, animteTime: 0.5, firstDelay:0.6, complete: { (comp) in
                                                   
        }) )
        return [red,blue,green]
    }


}

