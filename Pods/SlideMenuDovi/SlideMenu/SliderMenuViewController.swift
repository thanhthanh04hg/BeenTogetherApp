//
//  SliderMenuViewController.swift
//  carrefour
//
//  Created by Edouard Roussillon on 5/30/16.
//  Copyright © 2016 Concrete Solutions. All rights reserved.
//

import Foundation
import UIKit

public protocol SlidingMenuOptionsProtocol : class {
    func setupSlidingMenuOptions()
}

open class SliderMenuViewController: UIViewController, GlobalVariables, SlidingMenuOptionsProtocol {
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    public func initPanel(mainViewController: UIViewController, leftMenuViewController: UIViewController) {
        self.initViewController(mainViewController: mainViewController, leftMenuViewController: leftMenuViewController, rightMenuViewController: nil)
    }
    
    public func initPanel(mainViewController: UIViewController, rightMenuViewController: UIViewController) {
        self.initViewController(mainViewController: mainViewController, leftMenuViewController: nil, rightMenuViewController: rightMenuViewController)
    }
    
    public func initPanel(mainViewController: UIViewController, leftMenuViewController: UIViewController, rightMenuViewController: UIViewController) {
        self.initViewController(mainViewController: mainViewController, leftMenuViewController: leftMenuViewController, rightMenuViewController: rightMenuViewController)
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = UIRectEdge() //changed
        self.initView()
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.gesture.addLeftPanGestures()
        self.gesture.addRightPanGestures()
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.gesture.removeLeftPanGestures()
        self.gesture.removeLeftTapGestures()
        self.gesture.removeRightPanGestures()
        self.gesture.removeRightTapGestures()
    }
   
    public func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        self.animationType.resetAnimationLeftSide()
        self.animationType.resetAnimationRightSide()
        self.animationType.transitionToSize(transitionCoordinator: coordinator)
    }
    
    public func changeMainViewController(mainViewController: UIViewController, close: Bool) {
        self.removeViewController(viewController: self.menuViewControllers.mainViewController)
        self.menuViewControllers.mainViewController = mainViewController
        self.setUpViewController(targetView: self.menuViews.mainContainerView, targetViewController: mainViewController)
        if close {
            self.closeSlideMenuLeft()
            self.closeSlideMenuRight()
        }
    }
    
    public func changeLeftViewController(leftViewController: UIViewController, close: Bool) {
        self.removeViewController(viewController: self.menuViewControllers.leftViewController)
        self.menuViewControllers.leftViewController = leftViewController
        self.setUpViewController(targetView: self.menuViews.leftContainerView, targetViewController: leftViewController)
        if close {
            self.closeSlideMenuLeft()
            self.closeSlideMenuRight()
        }
    }
    
    public func changeRightViewController(rightViewController: UIViewController, close: Bool) {
        self.removeViewController(viewController: self.menuViewControllers.rightViewController)
        self.menuViewControllers.rightViewController = rightViewController
        self.setUpViewController(targetView: self.menuViews.rightContainerView, targetViewController: rightViewController)
        if close {
            self.closeSlideMenuRight()
            self.closeSlideMenuLeft()
        }
    }
    
    //
    // MARK: Toggle Left or Right
    //
    
    public func toggleSlideMenuLeft() {
        if self.animationType.isLeftSideOpen() {
            self.sendNotification(trackAction: TrackAction.LeftWillClose)
        } else {
            self.sendNotification(trackAction: TrackAction.LeftWillOpen)
        }
        self.animationType.toggleLeft()
    }
    
    public func toggleSlideMenuRight() {
        if self.animationType.isRightSideOpen() {
            self.sendNotification(trackAction: TrackAction.RightWillClose)
        } else {
            self.sendNotification(trackAction: TrackAction.RightWillOpen)
        }
        self.animationType.toggleRight()
    }
    
    //
    // MARK: Open Left or Right
    //
    
    public func openSlideMenuLeft() {
        self.sendNotification(trackAction: TrackAction.LeftWillOpen)
        self.animationType.openLeft()
    }
    
    public func openSlideMenuRight() {
        self.sendNotification(trackAction: TrackAction.RightWillOpen)
        self.animationType.openRight()
    }
    
    //
    // MARK: Close Left or Right
    //
    
    public func closeSlideMenuLeft() {
        self.sendNotification(trackAction: TrackAction.LeftWillClose)
        self.animationType.closeLeft()
    }
    
    public func closeSlideMenuRight() {
        self.sendNotification(trackAction: TrackAction.RightWillClose)
        self.animationType.closeRight()
    }
    
    //
    // MARK: Check if menu is open
    //
    
    public func isSlideMenuLeftOpen() -> Bool {
        return self.animationType.isLeftSideOpen()
    }
    
    public func isSlideMenuRightOpen() -> Bool {
        return self.animationType.isRightSideOpen()
    }
    
    //
    // MARK: Private
    //
    
    private func initViewController(mainViewController: UIViewController, leftMenuViewController: UIViewController?, rightMenuViewController: UIViewController?) {
        self.resetView()
        
        self.menuViewControllers.mainViewController = mainViewController
        self.menuViewControllers.leftViewController = leftMenuViewController
        self.menuViewControllers.rightViewController = rightMenuViewController
        
        self.setUpViewController(targetView: self.menuViews.mainContainerView, targetViewController: self.menuViewControllers.mainViewController)
        self.setUpViewController(targetView: self.menuViews.leftContainerView, targetViewController: self.menuViewControllers.leftViewController)
        self.setUpViewController(targetView: self.menuViews.rightContainerView, targetViewController: self.menuViewControllers.rightViewController)
    }
    
    private func initView() {
        self.menuTools.rootView = self.view
        self.setupSlidingMenuOptions()
        
        self.menuViews.initMainContainerView(frame: view.bounds)
        self.menuViews.initOpacityView(frame: view.bounds)
        self.menuViews.initLeftContainerView(frame: view.bounds)
        self.menuViews.initRightContainerView(frame: view.bounds)
        self.menuViews.initStatusBarView(frame: view.bounds)
        
        self.animationType.orderList()

        self.animationType.resetAnimationLeftSide()
        self.animationType.resetAnimationRightSide()
    }
    
    private func resetView() {
        removeViewController(viewController: self.menuViewControllers.mainViewController)
        removeViewController(viewController: self.menuViewControllers.leftViewController)
        removeViewController(viewController: self.menuViewControllers.rightViewController)
    }
    
    open func setupSlidingMenuOptions() {
        //stub, implementation is subclasses
    }
    
    private func removeViewController(viewController: UIViewController?) {
        if let _viewController = viewController {
            _viewController.willMove(toParent: nil)
            _viewController.view.removeFromSuperview()
            _viewController.removeFromParent()
        }
    }
    
    private func setUpViewController(targetView: UIView, targetViewController: UIViewController?) {
        if let viewController = targetViewController {
            viewController.view.frame = targetView.bounds
            targetView.addSubview(viewController.view)
            viewController.willMove(toParent: self)
            self.addChild(viewController)
            viewController.didMove(toParent: self)
        }
    }
}
