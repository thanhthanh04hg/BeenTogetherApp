//
//  SlideMenuViewController.swift
//  BeenTogetherAppOffical
//
//  Created by Macbook on 5/24/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit
import SlideMenuDovi
class SlideMenuViewController: SliderMenuViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let main = sb.instantiateViewController(withIdentifier: "MainViewController")
        let bt2015 = sb.instantiateViewController(withIdentifier: "BT2015ViewController")
        let left = sb.instantiateViewController(withIdentifier: "LeftMenuViewController")
//        let main = MainViewController()
//        let left = MenuTableViewController()
        //        let right = YourRightViewController()
        if(UserDefaults.standard.integer(forKey: "checkmark") == 0){
            self.initPanel(mainViewController: main, leftMenuViewController: left)
        }
        if UserDefaults.standard.integer(forKey: "checkmark") == 1 {
            self.initPanel(mainViewController: bt2015, leftMenuViewController: left)
        }
        //        self.initPanel(main, leftMenuViewController: left, rightMenuViewController: right)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
