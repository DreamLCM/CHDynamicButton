//
//  CircleAnimationView.swift
//  CHPurchaseButton
//
//  Created by apple on 2016/10/25.
//  Copyright © 2016年 CM. All rights reserved.
//

import UIKit

class CircleAnimationView: UIView {
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.

    
    
    override func draw(_ rect: CGRect) {
        
        let path = UIBezierPath.init()
        let center = CGPoint(x: rect.size.width / 2, y: rect.size.height / 2)
        let radius = rect.size.width / 2 - 2
        let start = -M_PI_2 + Double(self.timeFlag!) * 2 * M_PI
        let end = -M_PI_2 + 0.45 * 2 * M_PI + Double(self.timeFlag!) * 2 * M_PI
        
        path.addArc(withCenter: center, radius: radius, startAngle: CGFloat(start), endAngle: CGFloat(end), clockwise: true)
        UIColor.blue.setStroke()
//        self.borderColor?.setStroke()
        path.lineWidth = 1.5
        path.stroke()
        
//        print(start)
        
    }

   
    var borderColor: UIColor? = nil
    var timeFlag: CGFloat? = nil
    var timer: Timer? = nil
    
    
    class func viewWithButton(button: UIButton) -> CircleAnimationView {
        let animationView = CircleAnimationView(frame: CGRect(x: -8, y: -8, width: button.frame.size.width + 16, height: button.frame.size.height + 16))
        animationView.backgroundColor = UIColor.clear
        animationView.borderColor = button.titleLabel?.textColor
        animationView.timeFlag = 0
        return animationView
    }
    
    override func removeFromSuperview() {
        self.timer?.invalidate()
        super.removeFromSuperview()
    }
    
    func startAnimation() {
        
    
        // 以下方式必须手动加入Runloop
        self.timer = Timer(timeInterval: 0.006, target: self, selector: #selector(self.continueAnimation), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: RunLoopMode.defaultRunLoopMode)
//        self.timer?.fire()
        
        
        
        
    }
    
    func continueAnimation() {
       
        self.timeFlag = self.timeFlag! + 0.01
        self.setNeedsDisplay()
        
    }
    
    
    
    

}







