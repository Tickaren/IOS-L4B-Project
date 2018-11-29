//
//  Extensions.swift
//  Project
//
//  Created by Anton Svärd on 2018-11-07.
//  Copyright © 2018 Oscar Stenqvist. All rights reserved.
//

import UIKit
import AVFoundation

// MARK: - Extension UIColor
extension UIColor {
    struct BackgroundColor {
        static let pink = UIColor(named: "ownPink")
    }
}

// MARK: - Extension UIView
extension UIView{
    
    // MARK: Glow effect
    
    enum GlowEffect:Float{
        case small = 0.4, normal = 2, big = 15
    }
    
    // MARK: Glow animation
    
    func doGlowAnimation(withColor color:UIColor, withEffect effect:GlowEffect = .normal) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowRadius = 0
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero
        
        let glowAnimation = CABasicAnimation(keyPath: "shadowRadius")
        glowAnimation.fromValue = 0
        glowAnimation.toValue = effect.rawValue
        glowAnimation.beginTime = CACurrentMediaTime()+0.3
        glowAnimation.duration = CFTimeInterval(1.0)
        glowAnimation.fillMode = CAMediaTimingFillMode.removed
        glowAnimation.autoreverses = true
        glowAnimation.isRemovedOnCompletion = false
        glowAnimation.repeatCount = .infinity
        layer.add(glowAnimation, forKey: "shadowGlowingAnimation")
    }
    
    // MARK: Shake animation
    
    func shake(count : Float = 4,for duration : TimeInterval = 0.3,withTranslation translation : Float = 5) {
        
        let shakeAnimation : CABasicAnimation = CABasicAnimation(keyPath: "transform.translation.x")
        shakeAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        shakeAnimation.repeatCount = count
        shakeAnimation.duration = duration/TimeInterval(shakeAnimation.repeatCount)
        shakeAnimation.autoreverses = true
        shakeAnimation.fromValue = NSValue(cgPoint: CGPoint(x: CGFloat(-translation), y: self.center.y))
        shakeAnimation.toValue = NSValue(cgPoint: CGPoint(x: CGFloat(translation), y: self.center.y))
        layer.add(shakeAnimation, forKey: "shake")
    }
    
}
// MARK: - Extension UIDevice
extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}
//extension UIButton {
//    @IBInspectable var adjustFontSizeToWidth: Bool {
//        get {
//            return (self.titleLabel?.adjustsFontSizeToFitWidth)!
//        }
//        set {
//            self.titleLabel?.numberOfLines = 1
//            self.titleLabel?.adjustsFontSizeToFitWidth = newValue;
//            self.titleLabel?.lineBreakMode = .byClipping;
//            self.titleLabel?.baselineAdjustment = .alignCenters
//        }
//    }
//}
extension UIButton {
    @IBInspectable var adjustFontSizeToWidth: Bool {
        get {
            return titleLabel!.adjustsFontSizeToFitWidth
        }
        set {
            titleLabel!.adjustsFontSizeToFitWidth = newValue
            titleLabel!.lineBreakMode             = .byClipping
        }
    }
}





