//
//  SliderMenuGestureDefault.swift
//  carrefour
//
//  Created by Edouard Roussillon on 5/31/16.
//  Copyright © 2016 Concrete Solutions. All rights reserved.
//

import Foundation
import UIKit

public class SliderMenuGestureDefault: NSObject, SliderMenuGesture {
    public static let sharedInstance: SliderMenuGestureDefault = SliderMenuGestureDefault()
    
    private override init() {}
    
    
    public func addLeftPanGestures() {
        if menuViewControllers.leftViewController != nil {
            if self.leftPanGesture == nil {
                self.leftPanGesture = UIPanGestureRecognizer(target: self, action: #selector(SliderMenuGestureDefault.handleLeftPanGesture(panGesture:)))
                self.leftPanGesture!.delegate = self
                self.rootView.addGestureRecognizer(self.leftPanGesture!)
            }
        }
    }
    
    public func addRightPanGestures() {
        if menuViewControllers.rightViewController != nil {
            if self.rightPanGesture == nil {
                self.rightPanGesture = UIPanGestureRecognizer(target: self, action: #selector(SliderMenuGestureDefault.handleRightPanGesture(panGesture:)))
                self.rightPanGesture!.delegate = self
                self.rootView.addGestureRecognizer(self.rightPanGesture!)
            }
        }
    }
    
    public func removeLeftPanGestures() {
        if leftPanGesture != nil {
            self.rootView.removeGestureRecognizer(leftPanGesture!)
            leftPanGesture = nil
        }
    }
    
    public func removeRightPanGestures() {
        if rightPanGesture != nil {
            self.rootView.removeGestureRecognizer(rightPanGesture!)
            rightPanGesture = nil
        }
    }
    
    public func addLeftTapGestures() {
        if menuViewControllers.leftViewController != nil {
            
            if self.leftTapGesture == nil {
                self.leftTapGesture = UITapGestureRecognizer(target: self, action: #selector(SliderMenuGestureDefault.handleLeftTapGesture))
                self.leftTapGesture!.delegate = self
                self.rootView.addGestureRecognizer(leftTapGesture!)
            }
        }
    }
    
    public func addRightTapGestures() {
        if menuViewControllers.rightViewController != nil {
            if self.rightTapGesture == nil {
                self.rightTapGesture = UITapGestureRecognizer(target: self, action: #selector(SliderMenuGestureDefault.handleRightTapGesture))
                self.rightTapGesture!.delegate = self
                self.rootView.addGestureRecognizer(self.rightTapGesture!)
            }
        }
    }
    
    public func removeLeftTapGestures() {
        if leftTapGesture != nil {
            self.rootView.removeGestureRecognizer(leftTapGesture!)
            leftTapGesture = nil
        }
    }
    
    public func removeRightTapGestures() {
        if rightTapGesture != nil {
            self.rootView.removeGestureRecognizer(rightTapGesture!)
            rightTapGesture = nil
        }
    }
    
    //
    // MARK: UIPanGestureRecognizer
    //
    
    @objc public func handleLeftPanGesture(panGesture: UIPanGestureRecognizer) {
        
        if self.animationType.isRightSideOpen() {
            return
        }

        switch panGesture.state {
        case UIGestureRecognizer.State.began:
            self.animationType.beganLeftTranslationGesture()
            LeftPanState.startPointOfPan = panGesture.location(in: self.rootView)
            LeftPanState.wasOpenAtStartOfPan = self.animationType.isLeftSideOpen()
            LeftPanState.wasHiddenAtStartOfPan = self.animationType.isLeftSideHidden()

            self.menuViewControllers.leftViewController?.beginAppearanceTransition(LeftPanState.wasHiddenAtStartOfPan, animated: true)
            self.menuTools.setOpenWindowLevel()
            
            if LeftPanState.wasOpenAtStartOfPan {
                self.sendNotification(trackAction: TrackAction.LeftWillClose)
            } else {
                self.sendNotification(trackAction: TrackAction.LeftWillOpen)
            }
            
        case UIGestureRecognizer.State.changed:
            
            let translation: CGPoint = panGesture.translation(in: panGesture.view!)
            let frameTranslation = self.animationType.applyLeftGestureTranslation(translation: translation, toFrame: LeftPanState.frameAtStartOfPan)
            self.animationType.changedLeftTranslationGesture(frameTranslation: frameTranslation)

        case UIGestureRecognizer.State.ended:

            let velocity: CGPoint = panGesture.velocity(in: panGesture.view)
            let panInfo: PanInfo = self.animationType.endLeftTranslationGesture(velocity: velocity)

            if panInfo.action == .Open {
                self.menuViewControllers.leftViewController?.endAppearanceTransition()
                self.animationType.openLeftWithVelocity(velocity: panInfo.velocity)
            } else {
                self.menuViewControllers.leftViewController?.endAppearanceTransition()
                self.animationType.closeLeftWithVelocity(velocity: panInfo.velocity)
                self.menuTools.setCloseWindowLevel()
            }
        default:
            break
        }
    }
    
    @objc public func handleRightPanGesture(panGesture: UIPanGestureRecognizer) {
        
        if self.animationType.isLeftSideOpen() {
            return
        }
        
        switch panGesture.state {
        case UIGestureRecognizer.State.began:
            self.animationType.beganRightTranslationGesture()
            RightPanState.startPointOfPan = panGesture.location(in: self.rootView)
            RightPanState.wasOpenAtStartOfPan =  self.animationType.isRightSideOpen()
            RightPanState.wasHiddenAtStartOfPan = self.animationType.isRightSideHidden()
            
            self.menuViewControllers.rightViewController?.beginAppearanceTransition(RightPanState.wasHiddenAtStartOfPan, animated: true)
            self.menuTools.setOpenWindowLevel()
            
            if RightPanState.wasOpenAtStartOfPan {
                self.sendNotification(trackAction: TrackAction.RightWillClose)
            } else {
                self.sendNotification(trackAction: TrackAction.RightWillOpen)
            }
            
        case UIGestureRecognizer.State.changed:
            
            let translation: CGPoint = panGesture.translation(in: panGesture.view!)
            let frameTranslation = self.animationType.applyRightGestureTranslation(translation: translation, toFrame: RightPanState.frameAtStartOfPan)
            self.animationType.changedRightTranslationGesture(frameTranslation: frameTranslation)
            
        case UIGestureRecognizer.State.ended:
            
            let velocity: CGPoint = panGesture.velocity(in: panGesture.view)
            let panInfo: PanInfo = self.animationType.endRightTranslationGesture(velocity: velocity)
            
            if panInfo.action == .Open {
                if !RightPanState.wasHiddenAtStartOfPan {
                    self.menuViewControllers.rightViewController?.beginAppearanceTransition(true, animated: true)
                }
                self.animationType.openRightWithVelocity(velocity: panInfo.velocity)
            } else {
                if RightPanState.wasHiddenAtStartOfPan {
                    self.menuViewControllers.rightViewController?.beginAppearanceTransition(false, animated: true)
                }
                self.animationType.closeRightWithVelocity(velocity: panInfo.velocity)
                self.menuTools.setCloseWindowLevel()
            }
        default:
            break
        }
    }
    
    @objc public func handleLeftTapGesture() {
        self.sendNotification(trackAction: TrackAction.LeftWillClose)
        self.animationType.toggleLeft()
    }
    
    @objc public func handleRightTapGesture() {
        self.sendNotification(trackAction: TrackAction.RightWillClose)
        self.animationType.toggleRight()
    }
    
    //
    // MARK: UIGestureRecognizerDelegate
    //
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        let point: CGPoint = touch.location(in: self.rootView)
        
        if (self.mainViewController?.children.count)! > 1 && SliderMenuOptions.openMenuOnlyFirstViewController {
            return false
        }
        
        if gestureRecognizer == leftPanGesture {
            return slideLeftForGestureRecognizer(gesture: gestureRecognizer, point: point)
        } else if gestureRecognizer == rightPanGesture {
            return slideRightViewForGestureRecognizer(gesture: gestureRecognizer, withTouchPoint: point)
        } else if gestureRecognizer == leftTapGesture {
            return self.animationType.isLeftSideOpen() && !isPointContainedWithinLeftRect(point: point)
        } else if gestureRecognizer == rightTapGesture {
            return self.animationType.isRightSideOpen() && !isPointContainedWithinRightRect(point: point)
        }
        
        return false
    }

    private func slideLeftForGestureRecognizer( gesture: UIGestureRecognizer, point:CGPoint) -> Bool {
        return self.animationType.isLeftSideOpen() || SliderMenuOptions.leftPanFromBezel && isLeftPointContainedWithinBezelRect(point: point)
    }
    
    private func slideRightViewForGestureRecognizer(gesture: UIGestureRecognizer, withTouchPoint point: CGPoint) -> Bool {
        return self.animationType.isRightSideOpen() || SliderMenuOptions.rightPanFromBezel && isRightPointContainedWithinBezelRect(point: point)
    }

    private func isPointContainedWithinLeftRect(point: CGPoint) -> Bool {
        return self.menuViews.leftContainerView.frame.contains(point)
    }
    
    private func isPointContainedWithinRightRect(point: CGPoint) -> Bool {
        return self.menuViews.rightContainerView.frame.contains(point)
    }

    private func isLeftPointContainedWithinBezelRect(point: CGPoint) -> Bool {
        return point.x <= SliderMenuOptions.leftBezelWidth
    }

    private func isRightPointContainedWithinBezelRect(point: CGPoint) -> Bool {
        let lastPoint = self.rootView.bounds.width - SliderMenuOptions.rightBezelWidth
        return point.x >= lastPoint
    }
}
