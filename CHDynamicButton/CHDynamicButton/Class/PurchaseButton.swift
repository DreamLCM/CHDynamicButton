//
//  PurchaseButton.swift
//  CHPurchaseButton
//
//  Created by apple on 2016/10/25.
//  Copyright © 2016年 CM. All rights reserved.
//

import UIKit


protocol PurchaseButtonDelegate: class {
    
    // 开始动画
    func PurchaseButtonDidStartAnimation(purchaseButton: PurchaseButton) -> Void
    
    // 停止动画
    func PurchaseButtonDidFinishAnimation(purchaseButton: PurchaseButton) -> Void
    
    // 即将完成
    func PurchaseButtonWillFinishAnimation(purchaseButton: PurchaseButton) -> Void
    
}

enum PurchaseButtonState {
    
    case PurchaseButtonStateNormal
    case PurchaseButtonStateConfirmation
    case PurchaseButtonStateProgress
    
}


class PurchaseButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var borderColor: UIColor = UIColor(){
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    var circleView: CircleAnimationView!
    

    
    var origionRect: CGRect? = nil
    var delegate: PurchaseButtonDelegate?   // 代理
    
    var buttonState = PurchaseButtonState.PurchaseButtonStateNormal
    
    
    
    
    
    class func buttonWithFrame(frame: CGRect, borderColor: UIColor, title: String,
                               titleColor: UIColor, backColor: UIColor, cornerRadiu: CGFloat, buttonState: PurchaseButtonState) -> PurchaseButton {
        
        let button = PurchaseButton(type: UIButtonType.custom)
        button.frame = frame
        button.layer.cornerRadius = frame.size.height / 2
        button.layer.masksToBounds = true
        button.clipsToBounds = false
        button.layer.borderColor = borderColor.cgColor
        button.layer.borderWidth = 2
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.backgroundColor = backColor
        button.origionRect = button.frame

        return button
    }
    
    
    class func purchaseButtonAction(button: PurchaseButton, titleNormal: String,
                                    colorNormal: UIColor, backColorNormal:UIColor,
                                    titleConfirmation: String, colorConfirmation: UIColor,
                                    backColorConfirmation: UIColor) {
        
        if button.buttonState == PurchaseButtonState.PurchaseButtonStateNormal {
            button.buttonState = PurchaseButtonState.PurchaseButtonStateConfirmation
            
        } else if button.buttonState == PurchaseButtonState.PurchaseButtonStateConfirmation {
            button.buttonState = PurchaseButtonState.PurchaseButtonStateProgress
            
        } else {
            button.buttonState = PurchaseButtonState.PurchaseButtonStateNormal
            
        }
        
        switch button.buttonState {
        case .PurchaseButtonStateNormal:
            button.backgroundColor = backColorNormal
            button.setTitle(titleNormal, for: .normal)
            button.setTitleColor(colorNormal, for: .normal)
            
            break
            
        case .PurchaseButtonStateConfirmation:
            UIView.animate(withDuration: 1.0, animations: {
                button.backgroundColor = backColorConfirmation
                button.setTitle(titleConfirmation, for: .normal)
                button.setTitleColor(colorConfirmation, for: .normal)
                
                }, completion: { (Bool) in
                    
            })
            break
        case .PurchaseButtonStateProgress:
            button.startAnimation()
        }

    }
    
    
    
    // 开始动画
    func startAnimation() {
        
       
        
        let center = self.center
        let width = self.layer.cornerRadius * 2
        let height = self.frame.size.height
        let desFrame = CGRect(x: center.x - width, y: center.y - height / 2, width: width, height: height)
        
        self.isUserInteractionEnabled = false
        
        self.delegate?.PurchaseButtonDidStartAnimation(purchaseButton: self)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.titleLabel?.alpha = 0.0
            self.frame = desFrame
            
            }) { (finished) in
                
                self.circleView = CircleAnimationView.viewWithButton(button: self)
                self.addSubview(self.circleView)

                self.circleView.startAnimation()

                
        }
    }
    
    
    // 结束动画
    func stopAnimation() {
        self.isUserInteractionEnabled = true
        
        self.delegate?.PurchaseButtonWillFinishAnimation(purchaseButton: self)
        self.circleView.removeFromSuperview()
        
        UIView.animate(withDuration: 0.5, animations: { 
            self.frame = self.origionRect!
            self.titleLabel?.alpha = 1.0
            
            }) { (finished) in
                self.delegate?.PurchaseButtonDidFinishAnimation(purchaseButton: self)
        }
        
    }
    

}





