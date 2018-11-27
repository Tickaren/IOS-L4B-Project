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
//To scale text! doesnt work as intended yet
//// MARK: - Extension UIFont
//extension UIFont {
//
//    /**
//     Will return the best font conforming to the descriptor which will fit in the provided bounds.
//     */
//    static func bestFittingFontSize(for text: String, in bounds: CGRect, fontDescriptor: UIFontDescriptor, additionalAttributes: [NSAttributedString.Key: Any]? = nil) -> CGFloat {
//        let constrainingDimension = min(bounds.width, bounds.height)
//        let properBounds = CGRect(origin: .zero, size: bounds.size)
//        var attributes = additionalAttributes ?? [:]
//
//        let infiniteBounds = CGSize(width: CGFloat.infinity, height: CGFloat.infinity)
//        var bestFontSize: CGFloat = constrainingDimension
//
//        for fontSize in stride(from: bestFontSize, through: 0, by: -1) {
//            let newFont = UIFont(descriptor: fontDescriptor, size: fontSize)
//            attributes[.font] = newFont
//
//            let currentFrame = text.boundingRect(with: infiniteBounds, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: attributes, context: nil)
//
//            if properBounds.contains(currentFrame) {
//                bestFontSize = fontSize
//                break
//            }
//        }
//        return bestFontSize
//    }
//
//    static func bestFittingFont(for text: String, in bounds: CGRect, fontDescriptor: UIFontDescriptor, additionalAttributes: [NSAttributedString.Key: Any]? = nil) -> UIFont {
//        let bestSize = bestFittingFontSize(for: text, in: bounds, fontDescriptor: fontDescriptor, additionalAttributes: additionalAttributes)
//        return UIFont(descriptor: fontDescriptor, size: bestSize)
//    }
//}
//
//// MARK: - Extension UILabel
//
//extension UILabel {
//
//    /// Will auto resize the contained text to a font size which fits the frames bounds.
//    /// Uses the pre-set font to dynamically determine the proper sizing
//    func fitTextToBounds() {
//        guard let text = text, let currentFont = font else { return }
//
//        let bestFittingFont = UIFont.bestFittingFont(for: text, in: bounds, fontDescriptor: currentFont.fontDescriptor, additionalAttributes: basicStringAttributes)
//        font = bestFittingFont
//    }
//
//    private var basicStringAttributes: [NSAttributedString.Key: Any] {
//        var attribs = [NSAttributedString.Key: Any]()
//
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.alignment = self.textAlignment
//        paragraphStyle.lineBreakMode = self.lineBreakMode
//        attribs[.paragraphStyle] = paragraphStyle
//
//        return attribs
//    }
//}




