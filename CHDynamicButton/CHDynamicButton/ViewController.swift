//
//  ViewController.swift
//  CHPurchaseButton
//
//  Created by apple on 2016/10/20.
//  Copyright © 2016年 CM. All rights reserved.
//

import UIKit

class ViewController: UIViewController , PurchaseButtonDelegate {
    
    var button: PurchaseButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        button = PurchaseButton.buttonWithFrame(frame: CGRect(x: 30, y: 300, width: self.view.frame.size.width - 2 * 30, height: 50), borderColor: .red, title: "$2.99", titleColor: .red, backColor: .clear, cornerRadiu: 50 / 2, buttonState: .PurchaseButtonStateNormal)
        
        button.delegate = self
        
        self.view.addSubview(button)
        
        button.addTarget(self, action: #selector(self.actionControl(button:)), for: UIControlEvents.touchUpInside)
        
    }
    
    
    
    func actionControl(button: PurchaseButton) {
        
        PurchaseButton.purchaseButtonAction(button: button, titleNormal: "$2.99",
                                            colorNormal: .red, backColorNormal: .clear,
                                            titleConfirmation: "Buy", colorConfirmation: .white, backColorConfirmation: .red)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func PurchaseButtonDidStartAnimation(purchaseButton: PurchaseButton) {
        print("Start")
        
        DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(1.8 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
            purchaseButton.stopAnimation()
            self.button.backgroundColor = UIColor.clear
            self.button.setTitle("$2.99", for: .normal)
            self.button.setTitleColor(UIColor.red, for: .normal)
            self.button.buttonState = .PurchaseButtonStateNormal
            
        }
        
    }
    
    func PurchaseButtonDidFinishAnimation(purchaseButton: PurchaseButton) {
        print("stop")
    }
    
    func PurchaseButtonWillFinishAnimation(purchaseButton: PurchaseButton) {
        print("will")
    }
    
}

