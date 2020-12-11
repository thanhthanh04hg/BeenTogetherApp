//
//  MenuTools.swift
//  carrefour
//
//  Created by Edouard Roussillon on 5/30/16.
//  Copyright © 2016 Concrete Solutions. All rights reserved.
//

import Foundation
import UIKit

public class MenuTools {
    public static let sharedInstance: MenuTools = MenuTools()
    
    var rootView: UIView!
    let menuViews = MenuViews()
    let menuViewControllers = MenuViewControllers()
    
    // Private constructor
    private init() {}
    
    /*
    *   Tools
    */
    
    public func leftMinOrigin() -> CGFloat {
        return  -SliderMenuOptions.leftViewWidth
    }
    
    public func rightMinOrigin(frame: CGRect) -> CGFloat {
        return self.rootView.frame.width
    }
    
    //
    //  MARK: Window Level
    //
    
    public func setCloseWindowLevel() {
        if SliderMenuOptions.hideStatusBar {
            DispatchQueue.main.async {
                if let window = UIApplication.shared.keyWindow {
                    window.windowLevel = UIWindow.Level.normal
                }
            }
        }
    }
    
    public func setOpenWindowLevel() {
        if SliderMenuOptions.hideStatusBar {
            DispatchQueue.main.async {
                if let window = UIApplication.shared.keyWindow {
                    window.windowLevel = UIWindow.Level.statusBar + 1
                }
            }
        }
    }
    
    //
    //  MARK: Main Container Interaction
    //
    
    public func disableContentInteraction() {
        menuViews.mainContainerView.isUserInteractionEnabled = false
    }
    
    public func enableContentInteraction() {
        menuViews.mainContainerView.isUserInteractionEnabled = true
    }
    
    //
    // MARK: add or remove Shadow
    //
    
    public func addShadowToView(targetContainerView: UIView) {
        targetContainerView.layer.masksToBounds = false
        targetContainerView.layer.shadowColor = SliderMenuOptions.shadowColor.cgColor
        targetContainerView.layer.shadowOffset = SliderMenuOptions.shadowOffset
        targetContainerView.layer.shadowOpacity = Float(SliderMenuOptions.shadowOpacity)
        targetContainerView.layer.shadowRadius = SliderMenuOptions.shadowRadius
        targetContainerView.layer.shadowPath = UIBezierPath(rect: targetContainerView.bounds).cgPath
    }
    
    public func removeShadow(targetContainerView: UIView) {
        targetContainerView.layer.masksToBounds = true
        self.menuViews.mainContainerView.layer.opacity = 1.0
    }
    
    //
    // MARK: Opacity
    //
    
    public func applyLeftOpacity() {
        let openedLeftRatio: CGFloat = getOpenedLeftRatio()
        let opacity: CGFloat = SliderMenuOptions.contentViewOpacity * openedLeftRatio
        self.menuViews.opacityView.layer.opacity = Float(opacity)
    }
    
    public func applyRightOpacity() {
        let openedRightRatio: CGFloat = getOpenedRightRatio()
        let opacity: CGFloat = SliderMenuOptions.contentViewOpacity * openedRightRatio
        self.menuViews.opacityView.layer.opacity = Float(opacity)
    }
    
    //
    // MARK: Private
    //
    
    private func getOpenedLeftRatio() -> CGFloat {
        let width: CGFloat = self.menuViews.leftContainerView.frame.size.width
        let currentPosition: CGFloat = self.menuViews.leftContainerView.frame.origin.x - leftMinOrigin()
        return currentPosition / width
    }
    
    private func getOpenedRightRatio() -> CGFloat {
        let width: CGFloat = self.menuViews.rightContainerView.frame.size.width
        let currentPosition: CGFloat = self.menuViews.rightContainerView.frame.origin.x
        return -(currentPosition - self.rootView.bounds.width) / width
    }
}

