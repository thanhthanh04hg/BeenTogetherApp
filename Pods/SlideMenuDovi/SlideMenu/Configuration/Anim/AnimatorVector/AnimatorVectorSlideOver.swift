//
//  AnimatorVectorSlideOver.swift
//  carrefour
//
//  Created by Edouard Roussillon on 6/3/16.
//  Copyright © 2016 Concrete Solutions. All rights reserved.
//

import Foundation
import UIKit

public protocol AnimatorVectorSlideOver: AnimatorVector {}

extension AnimatorVectorSlideOver {
    
    public func resetAnimationLeftSide() {
        self.menuTools.menuViews.leftContainerView.frame.origin = CGPoint(x: -SliderMenuOptions.leftViewWidth, y: 0)
    }
    
    public func resetAnimationRightSide() {
        self.menuTools.menuViews.rightContainerView.frame.origin = CGPoint(x: self.rootView.bounds.width, y: 0)
    }
    
    public func openLeftWithVelocity(velocity: CGFloat) {
        let xOrigin: CGFloat = self.menuViews.leftContainerView.frame.origin.x
        let finalXOrigin: CGFloat = 0.0
        
        var frame = self.menuViews.leftContainerView.frame
        frame.origin.x = finalXOrigin
        
        var duration: TimeInterval = Double(SliderMenuOptions.animationDuration)
        if velocity != 0.0 {
            duration = Double(abs(xOrigin - finalXOrigin) / velocity)
            duration = Double(fmax(0.1, fmin(1.0, duration)))
        }
        
        self.gesture.addLeftTapGestures()
        self.animationType.addShadowToView(targetContainerView: self.menuViews.leftContainerView)
        
        UIView.animate(withDuration: duration, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {() -> Void in
            self.menuViews.leftContainerView.frame = frame
            self.menuViews.opacityView.layer.opacity = Float(SliderMenuOptions.contentViewOpacity)
        }) {(Bool) -> Void in
            self.menuTools.disableContentInteraction()
            self.menuTools.menuViewControllers.leftViewController?.endAppearanceTransition()
            self.sendNotification(trackAction: TrackAction.LeftDidOpen)
        }
    }
    
    public func closeLeftWithVelocity(velocity: CGFloat) {
        
        let xOrigin: CGFloat = self.menuViews.leftContainerView.frame.origin.x
        let finalXOrigin: CGFloat = -SliderMenuOptions.leftViewWidth
        
        var frame: CGRect = self.menuViews.leftContainerView.frame
        frame.origin.x = finalXOrigin
        
        var duration: TimeInterval = Double(SliderMenuOptions.animationDuration)
        if velocity != -SliderMenuOptions.leftViewWidth {
            duration = Double(abs(xOrigin - finalXOrigin) / velocity)
            duration = Double(fmax(0.1, fmin(1.0, duration)))
        }
        
        self.gesture.removeLeftTapGestures()
        
        UIView.animate(withDuration: duration, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {() -> Void in
            self.menuViews.leftContainerView.frame = frame
            self.menuViews.opacityView.layer.opacity = 0.0
        }) {(Bool) -> Void in
            self.animationType.removeShadow(targetContainerView: self.menuViews.leftContainerView)
            self.menuTools.enableContentInteraction()
            self.menuTools.menuViewControllers.leftViewController?.endAppearanceTransition()
            self.sendNotification(trackAction: TrackAction.LeftDidClose)
        }
    }
    
    public func openRightWithVelocity(velocity: CGFloat) {
        let lastPosition = self.rootView.frame.width - SliderMenuOptions.rightViewWidth
        var frame = self.menuViews.rightContainerView.frame
        frame.origin.x = lastPosition
        
        let from = abs(self.menuViews.rightContainerView.frame.origin.x)
        let to = abs(frame.origin.x)
        
        var duration: TimeInterval = Double(SliderMenuOptions.animationDuration)
        if velocity != lastPosition {
            duration = Double(abs(to - from) / abs(velocity))
            duration = Double(fmax(0.1, fmin(1.0, duration)))
        }
        
        self.animationType.addShadowToView(targetContainerView: self.menuViews.rightContainerView)
        self.gesture.addRightTapGestures()
        
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseInOut, animations: {() -> Void in
            self.menuViews.rightContainerView.frame = frame
            self.menuViews.opacityView.layer.opacity = Float(SliderMenuOptions.contentViewOpacity)
        }) {(Bool) -> Void in
            self.menuTools.disableContentInteraction()
            self.menuViewControllers.rightViewController?.endAppearanceTransition()
            self.sendNotification(trackAction: TrackAction.RightDidOpen)
        }
    }
    
    public func closeRightWithVelocity(velocity: CGFloat) {
        let xOrigin: CGFloat = self.menuViews.rightContainerView.frame.origin.x
        
        var frame = self.menuViews.rightContainerView.frame
        frame.origin.x = self.rootView.bounds.width
        
        var duration: TimeInterval = Double(SliderMenuOptions.animationDuration)
        if velocity != self.rootView.bounds.width {
            duration = Double(abs(self.rootView.bounds.width - xOrigin) / velocity)
            duration = Double(fmax(0.1, fmin(1.0, duration)))
        }
        
        self.gesture.removeRightTapGestures()
        
        UIView.animate(withDuration: duration, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {() -> Void in
            self.menuViews.rightContainerView.frame = frame
            self.menuViews.opacityView.layer.opacity = 0.0
        }) {(Bool) -> Void in
            self.menuTools.removeShadow(targetContainerView: self.menuViews.rightContainerView)
            self.menuTools.enableContentInteraction()
            self.menuViewControllers.rightViewController?.endAppearanceTransition()
            self.sendNotification(trackAction: TrackAction.RightDidClose)
        }
    }
    
}
