//
//  SliderMenuOption.swift
//  carrefour
//
//  Created by Edouard Roussillon on 5/30/16.
//  Copyright © 2016 Concrete Solutions. All rights reserved.
//

import Foundation
import UIKit


public enum SlideAction {
    case Open
    case Close
}

public enum TrackActionNotification: String {
    case MenuLeftWillOpen = "SliderMenuTrackActionNotificationMenuLeftWillOpen"
    case MenuLeftDidOpen = "SliderMenuTrackActionNotificationMenuLeftDidOpen"
    case MenuLeftWillClose = "SliderMenuTrackActionNotificationMeniLeftWillClose"
    case MenuLeftDidClose = "SliderMenuTrackActionNotificationMeniLeftDidClose"
    case MenuRightWillOpen = "SliderMenuTrackActionNotificationMenuMenuRightWillOpen"
    case MenuRightDidOpen = "SliderMenuTrackActionNotificationMenuMenuRightDidOpen"
    case MenuRightWillClose = "SliderMenuTrackActionNotificationMenuMenuRightWillClose"
    case MenuRightDidClose = "SliderMenuTrackActionNotificationMenuMenuRightDidClose"
}

public struct SliderMenuOptions {
    // you will define the left side
    public static var leftViewWidth: CGFloat = 242.0
    public static var leftBezelWidth: CGFloat = 16.0
    public static var leftPanFromBezel: Bool = true

    // you will define the right side
    public static var rightViewWidth: CGFloat = 242.0
    public static var rightBezelWidth: CGFloat = 16.0
    public static var rightPanFromBezel: Bool = true

    // the type of animation
    public static var animationType: SliderMenuAnimation = SliderMenuAnimationDefault()

    // The menu will not open or close under X pixel
    public static var pointOfNoReturnWidth: CGFloat = 44.0

    // opacity between the MainViewController and the Menu (Left or Right)
    public static var contentViewOpacity: CGFloat = 0.0

    // The sliding view will be set with a shadow
    public static var shadowOpacity: CGFloat = 0.0
    public static var shadowRadius: CGFloat = 12
    public static var shadowOffset: CGSize = CGSize(width: 0, height: 0)
    public static var shadowColor: UIColor = UIColor.black

    public static var animationDuration: CGFloat = 0.4
    
    // Alow or not to open menu after more then 1 ViewController into UINavigationController's stack list of VCs
    public static var openMenuOnlyFirstViewController: Bool = true

    // status bar options
    public static var hideStatusBar: Bool = true
    public static var showsStatusBarBackground: Bool = false
    public static var statusBarBackgroundColor: UIColor = UIColor.clear
}
