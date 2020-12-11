//
//  UIViewController+SilderMenu.swift
//  carrefour
//
//  Created by Edouard Roussillon on 5/31/16.
//  Copyright © 2016 Concrete Solutions. All rights reserved.
//

import UIKit

extension UIViewController {
    
    public func slideMenuController() -> SliderMenuViewController? {
        var viewController: UIViewController? = self
        while viewController != nil {
            
            if let slider = viewController as? SliderMenuViewController {
                return slider
            }
            viewController = viewController?.parent
            
        }
        return nil
    }
    
    public func _toggleSlideMenuLeft() {
        slideMenuController()?.toggleSlideMenuLeft()
    }
    
    public func _toggleSlideMenuRight() {
        slideMenuController()?.toggleSlideMenuRight()
    }
    
    public func _openSlideMenuLeft() {
        slideMenuController()?.openSlideMenuLeft()
    }
    
    public func _openSlideMenuRight() {
        slideMenuController()?.openSlideMenuRight()
    }
    
    public func _closeSlideMenuLeft() {
        slideMenuController()?.closeSlideMenuLeft()
    }
    
    public func _closeSlideMenuRight() {
        slideMenuController()?.closeSlideMenuRight()
    }
    
    public func _isSlideMenuLeftOpen() -> Bool {
        return slideMenuController()?.isSlideMenuLeftOpen() ?? false
    }
    
    public func _isSlideMenuRightOpen() -> Bool {
        return slideMenuController()?.isSlideMenuRightOpen() ?? false
    }
    
    // Please specify if you want menu gesuture give priority to than targetScrollView
    public func addPriorityToMenuGesuture(targetScrollView: UIScrollView) {
        if let slideControlelr = slideMenuController() {
            guard let recognizers =  slideControlelr.view.gestureRecognizers else {
                return
            }
            for recognizer in recognizers where recognizer is UIPanGestureRecognizer {
                targetScrollView.panGestureRecognizer.require(toFail: recognizer)
            }
        }
    }
    
    public func addPriorityToMenuGesuture() {
        if let slideControlelr = slideMenuController() {
            guard let recognizers =  slideControlelr.view.gestureRecognizers else {
                return
            }
            for recognizer in recognizers {
                self.view.addGestureRecognizer(recognizer)
            }
        }
    }
    
    public func addPriorityToMenuGesuturePage(pageController: UIPageViewController) {
        
        if let item = pageController.view.subviews.filter ({ $0 is UIScrollView }).first as? UIScrollView {
            self.addPriorityToMenuGesuture(targetScrollView: item)
        }
    }
}
