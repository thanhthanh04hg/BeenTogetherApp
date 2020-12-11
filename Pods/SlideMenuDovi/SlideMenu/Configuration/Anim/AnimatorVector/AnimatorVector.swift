//
//  AnimatorVector.swift
//  carrefour
//
//  Created by Edouard Roussillon on 5/31/16.
//  Copyright © 2016 Concrete Solutions. All rights reserved.
//

import Foundation
import UIKit

/**
 *  It will be call to close or open menu
 */
public protocol AnimatorVector: GlobalVariables {
    func resetAnimationLeftSide()
    func resetAnimationRightSide()
    func transitionToSize(transitionCoordinator: UIViewControllerTransitionCoordinator)

    func openLeftWithVelocity(velocity: CGFloat)
    func closeLeftWithVelocity(velocity: CGFloat)

    func openRightWithVelocity(velocity: CGFloat)
    func closeRightWithVelocity(velocity: CGFloat)
}

extension AnimatorVector {

    public func resetAnimationLeftSide() {
        self.menuTools.menuViews.mainContainerView.frame.origin = CGPoint(x: 0, y: 0)
    }

    public func resetAnimationRightSide() {
         self.menuTools.menuViews.mainContainerView.frame.origin = CGPoint(x: 0, y: 0)
    }

    public func transitionToSize(transitionCoordinator: UIViewControllerTransitionCoordinator) {
        self.menuViews.leftContainerView.isHidden = true
        self.menuViews.rightContainerView.isHidden = true

        transitionCoordinator.animate(alongsideTransition: nil, completion: { (context: UIViewControllerTransitionCoordinatorContext!) -> Void in

            self.animationType.resetAnimationLeftSide()
            self.animationType.resetAnimationRightSide()

            self.menuViews.leftContainerView.isHidden = false
            self.menuViews.rightContainerView.isHidden = false
        })
    }

    public func openLeftWithVelocity(velocity: CGFloat) {
        let xOrigin: CGFloat = self.menuViews.mainContainerView.frame.origin.x
        let finalXOrigin: CGFloat = SliderMenuOptions.leftViewWidth

        var frame = self.menuViews.mainContainerView.frame
        frame.origin.x = finalXOrigin

        var duration: TimeInterval = Double(SliderMenuOptions.animationDuration)
        if velocity != finalXOrigin {
            duration = Double(abs(xOrigin - finalXOrigin) / velocity)
            duration = Double(fmax(0.1, fmin(1.0, duration)))
        }

        self.gesture.addLeftTapGestures()
        self.animationType.addShadowToView(targetContainerView: self.menuViews.mainContainerView)

        UIView.animate(withDuration: duration, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {() -> Void in
            self.menuViews.mainContainerView.frame = frame
            self.menuViews.opacityView.frame = frame
            self.menuViews.opacityView.layer.opacity = Float(SliderMenuOptions.contentViewOpacity)
        }) {(Bool) -> Void in
            self.menuTools.disableContentInteraction()
            self.menuTools.menuViewControllers.leftViewController?.endAppearanceTransition()
            self.sendNotification(trackAction: TrackAction.LeftDidOpen)
        }
    }

    public func closeLeftWithVelocity(velocity: CGFloat) {

        let xOrigin: CGFloat = self.menuViews.mainContainerView.frame.origin.x
        let finalXOrigin: CGFloat = 0.0

        var frame: CGRect = self.menuViews.mainContainerView.frame
        frame.origin.x = finalXOrigin

        var duration: TimeInterval = Double(SliderMenuOptions.animationDuration)
        if velocity != 0.0 {
            duration = Double(abs(xOrigin - finalXOrigin) / velocity)
            duration = Double(fmax(0.1, fmin(1.0, duration)))
        }

        self.gesture.removeLeftTapGestures()

        UIView.animate(withDuration: duration, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {() -> Void in
            self.menuViews.mainContainerView.frame = frame
            self.menuViews.opacityView.frame = frame
            self.menuViews.opacityView.layer.opacity = 0.0
        }) {(Bool) -> Void in
            self.animationType.removeShadow(targetContainerView: self.menuViews.mainContainerView)
            self.menuTools.enableContentInteraction()
            self.menuTools.menuViewControllers.leftViewController?.endAppearanceTransition()
            self.sendNotification(trackAction: TrackAction.LeftDidClose)
        }
    }

    public func openRightWithVelocity(velocity: CGFloat) {

        var frame = self.menuViews.mainContainerView.frame
        frame.origin.x = -SliderMenuOptions.rightViewWidth

        let from = abs(self.menuViews.mainContainerView.frame.origin.x)
        let to = abs(frame.origin.x)

        var duration: TimeInterval = Double(SliderMenuOptions.animationDuration)
        if velocity != -SliderMenuOptions.rightViewWidth {
            duration = Double(abs(to - from) / abs(velocity))
            duration = Double(fmax(0.1, fmin(1.0, duration)))
        }

        self.animationType.addShadowToView(targetContainerView: self.menuViews.mainContainerView)
        self.gesture.addRightTapGestures()

        UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseInOut, animations: {() -> Void in
            self.menuViews.mainContainerView.frame = frame
            self.menuViews.opacityView.frame = frame
            self.menuViews.opacityView.layer.opacity = Float(SliderMenuOptions.contentViewOpacity)
        }) {(Bool) -> Void in
            self.menuTools.disableContentInteraction()
            self.menuViewControllers.rightViewController?.endAppearanceTransition()
            self.sendNotification(trackAction: TrackAction.RightDidOpen)
        }
    }

    public func closeRightWithVelocity(velocity: CGFloat) {
        let xOrigin: CGFloat = self.menuViews.mainContainerView.frame.origin.x

        var frame = self.menuViews.mainContainerView.frame
        frame.origin.x = 0.0

        var duration: TimeInterval = Double(SliderMenuOptions.animationDuration)
        if velocity != 0.0 {
            duration = Double(abs(self.rootView.bounds.width - xOrigin) / velocity)
            duration = Double(fmax(0.1, fmin(1.0, duration)))
        }

        self.gesture.removeRightTapGestures()

        UIView.animate(withDuration: duration, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {() -> Void in
            self.menuViews.mainContainerView.frame = frame
            self.menuViews.opacityView.frame = frame
            self.menuViews.opacityView.layer.opacity = 0.0
        }) {(Bool) -> Void in
            self.menuTools.removeShadow(targetContainerView: self.menuViews.rightContainerView)
            self.menuTools.enableContentInteraction()
            self.menuViewControllers.rightViewController?.endAppearanceTransition()
            self.sendNotification(trackAction: TrackAction.RightDidClose)
        }
    }
}
