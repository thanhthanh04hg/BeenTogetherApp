//
//  GlobalVariable.swift
//  carrefour
//
//  Created by Edouard Roussillon on 5/31/16.
//  Copyright © 2016 Concrete Solutions. All rights reserved.
//

import Foundation
import UIKit

public enum TrackAction {
    case LeftWillOpen
    case LeftWillClose
    case RightWillOpen
    case RightWillClose
    case LeftDidOpen
    case LeftDidClose
    case RightDidOpen
    case RightDidClose
}

/**
 *  Give you access to all you need
 */
public protocol GlobalVariables: class {
    var rootView: UIView { get }
    var menuTools: MenuTools { get }
    var menuViews: MenuViews { get }
    var menuViewControllers: MenuViewControllers { get }
    var animationType: SliderMenuAnimation { get }
    var gesture: SliderMenuGesture { get }
    var leftViewController: UIViewController? { get }
    var rightViewController: UIViewController? { get }
    var mainViewController: UIViewController? { get }
}

extension GlobalVariables {
    public var rootView: UIView {
        get {
            return menuTools.rootView
        }
    }

    public var menuTools: MenuTools {
        get {
            return MenuTools.sharedInstance
        }
    }

    public var menuViews: MenuViews {
        get {
            return menuTools.menuViews
        }
    }

    public var menuViewControllers: MenuViewControllers {
        get {
            return menuTools.menuViewControllers
        }
    }

    public var animationType: SliderMenuAnimation {
        get {
            return SliderMenuOptions.animationType
        }
    }

    public var gesture: SliderMenuGesture {
        get {
            return animationType.silderMenuGesture
        }
    }

    public var leftViewController: UIViewController? {
        get {
            return menuViewControllers.leftViewController
        }
    }

    public var rightViewController: UIViewController? {
        get {
            return menuViewControllers.rightViewController
        }
    }

    public var mainViewController: UIViewController? {
        get {
            return menuViewControllers.mainViewController
        }
    }

    public func sendNotification(trackAction: TrackAction) {
        switch trackAction {
        case .LeftWillOpen:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: TrackActionNotification.MenuLeftWillOpen.rawValue), object: nil)
            break
        case .LeftDidOpen:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: TrackActionNotification.MenuLeftDidOpen.rawValue), object: nil)
            break
        case .LeftWillClose:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: TrackActionNotification.MenuLeftWillClose.rawValue), object: nil)
            break
        case .LeftDidClose:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: TrackActionNotification.MenuLeftDidClose.rawValue), object: nil)
            break
        case .RightWillOpen:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: TrackActionNotification.MenuRightWillOpen.rawValue), object: nil)
            break
        case .RightDidOpen:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: TrackActionNotification.MenuRightDidOpen.rawValue), object: nil)
            break
        case .RightWillClose:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: TrackActionNotification.MenuRightWillClose.rawValue), object: nil)
            break
        case .RightDidClose:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: TrackActionNotification.MenuRightDidClose.rawValue), object: nil)
            break
        }
    }
}
