//
//  CDTabBarViewController.swift
//  BeenTogetherAppOffical
//
//  Created by Macbook on 6/7/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit

class CDTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        createNavigaionBar()
    }
    
    func createNavigaionBar(){
        let navBar = UINavigationBar(frame: CGRect(x: 0, y:10, width: view.frame.size.width , height: 40))
        navBar.contentMode = .scaleAspectFit
        view.addSubview(navBar)
        let navItem = UINavigationItem(title: "Caculate Date")
        let menuButton = UIBarButtonItem(image: UIImage(named: "menu"), style: .done, target: nil, action: #selector(menu))
        navItem.leftBarButtonItem = menuButton
        navBar.setItems([navItem], animated: false)

    }
   @objc func menu(){
        slideMenuController()?.openSlideMenuLeft()
    }

}
