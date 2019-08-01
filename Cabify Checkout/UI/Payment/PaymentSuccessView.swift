//
//  PaymentSuccessView.swift
//  Cabify Checkout
//
//  Created by Ilbert Esculpi on 8/1/19.
//  Copyright © 2019 Cabify. All rights reserved.
//

import UIKit

@IBDesignable
class PaymentSuccessView: UIView {
    
    // MARK: - IBOutlet
    @IBOutlet weak var checkImage: UIImageView!
    var view: UIView!
    var shapeLayer: CALayer!
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        xibSetup();
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        xibSetup();
    }
    
    func xibSetup() {
        backgroundColor = UIColor.clear;
        view = loadNib();
        view.frame = self.bounds;
        view.translatesAutoresizingMaskIntoConstraints = false;
        addSubview(view);
        addConstraints([
            NSLayoutConstraint(
                item: view!,
                attribute: .top,
                relatedBy: .equal,
                toItem: self,
                attribute: .top,
                multiplier: 1.0,
                constant: 0
            ),
            NSLayoutConstraint(
                item: view!,
                attribute: .bottom,
                relatedBy: .equal,
                toItem: self,
                attribute: .bottom,
                multiplier: 1.0,
                constant: 0
            ),
            NSLayoutConstraint(
                item: view!,
                attribute: .leading,
                relatedBy: .equal,
                toItem: self,
                attribute: .leading,
                multiplier: 1.0,
                constant: 0
            ),
            NSLayoutConstraint(
                item: view!,
                attribute: .trailing,
                relatedBy: .equal,
                toItem: self,
                attribute: .trailing,
                multiplier: 1.0,
                constant: 0
            ),
        ])
    }
    
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }

}

// MARK: - Animation
extension PaymentSuccessView: CAAnimationDelegate {
    
    func animationDidStart(_ anim: CAAnimation) {
        print("[DEBUG] animationStart");
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if( flag ) {
            print("[DEBUG] animationComplete");
            checkImage.isHidden = false;
        }
    }
    
    func startAnimation() {
        
        print("[DEBUG] startAnimation()");
        
        addAnimationLayer()
        
        // start animation
        DispatchQueue.main.async {
            let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
            basicAnimation.fromValue = 0
            basicAnimation.delegate = self
            basicAnimation.toValue = 1
            basicAnimation.duration = CFTimeInterval(0.3)
            basicAnimation.fillMode = CAMediaTimingFillMode.forwards
            basicAnimation.isRemovedOnCompletion = false
            self.shapeLayer.add(basicAnimation, forKey: "strokeAnimation")
        }
        
    }
    
    func addAnimationLayer() {
        
        // create a circle animation around the check image
        let shapeLayer = CAShapeLayer();
        let trackPath = CAShapeLayer();
        let circularPath = UIBezierPath(
            arcCenter: checkImage.center,
            radius: 48,
            startAngle: -CGFloat.pi / 2,
            endAngle: (CGFloat.pi + (CGFloat.pi / 2) ),
            clockwise: true
        )
        trackPath.path = circularPath.cgPath
        trackPath.strokeColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.4).cgColor
        trackPath.fillColor = UIColor.clear.cgColor
        trackPath.lineWidth = 4
        trackPath.lineCap = CAShapeLayerLineCap.round
        view.layer.addSublayer(trackPath)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor(named: "Success")!.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 4
        shapeLayer.strokeEnd = 0
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        
        self.shapeLayer = shapeLayer;
        view.layer.addSublayer(shapeLayer);
        
    }
    
    
}
