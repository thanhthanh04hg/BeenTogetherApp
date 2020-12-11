//
//  MenuViews.swift
//  carrefour
//
//  Created by Edouard Roussillon on 5/30/16.
//  Copyright © 2016 Concrete Solutions. All rights reserved.
//

import Foundation
import UIKit

public class MenuViews: GlobalVariables {
    
    var statusBarView = UIView()
    var opacityView = UIView()
    var mainContainerView = UIView()
    var leftContainerView = UIView()
    var rightContainerView =  UIView()
    
    
    public func initMainContainerView(frame: CGRect) {
        self.mainContainerView = UIView(frame: frame)
        self.mainContainerView.backgroundColor = UIColor.clear
        self.mainContainerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    public func initOpacityView(frame: CGRect) {
        var opacityframe: CGRect = frame
        let opacityOffset: CGFloat = 0
        opacityframe.origin.y = opacityframe.origin.y + opacityOffset
        opacityframe.size.height = opacityframe.size.height - opacityOffset
        opacityView = UIView(frame: opacityframe)
        opacityView.backgroundColor = UIColor.black
        opacityView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        opacityView.layer.opacity = 0.0
    }
    
    public func initLeftContainerView(frame: CGRect) {
        var leftFrame: CGRect = frame
        leftFrame.size.width = SliderMenuOptions.leftViewWidth
        leftFrame.origin.x = menuTools.leftMinOrigin()
        let leftOffset: CGFloat = 0
        leftFrame.origin.y = leftFrame.origin.y + leftOffset
        leftFrame.size.height = leftFrame.size.height - leftOffset
        leftContainerView = UIView(frame: leftFrame)
        leftContainerView.backgroundColor = UIColor.clear
        leftContainerView.autoresizingMask = UIView.AutoresizingMask.flexibleHeight
    }
    
    public func initRightContainerView(frame: CGRect) {
        var rightFrame: CGRect = frame
        rightFrame.size.width = SliderMenuOptions.rightViewWidth
        rightFrame.origin.x = menuTools.rightMinOrigin(frame: rightFrame)
        let rightOffset: CGFloat = 0
        rightFrame.origin.y = rightFrame.origin.y + rightOffset
        rightFrame.size.height = rightFrame.size.height - rightOffset
        rightContainerView = UIView(frame: rightFrame)
        rightContainerView.backgroundColor = UIColor.clear
        rightContainerView.autoresizingMask = UIView.AutoresizingMask.flexibleHeight
    }
    
    public func initStatusBarView(frame: CGRect) {
        statusBarView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 20))
        self.statusBarBackground(color: SliderMenuOptions.statusBarBackgroundColor)
    }
    
    public func statusBarBackground(color: UIColor) {
        statusBarView.backgroundColor = color
    }
    
}

