//
//  FirstViewController.swift
//  BeenTogetherAppOffical
//
//  Created by Macbook on 4/24/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let sb=UIStoryboard.init(name: "Main", bundle: nil)
        let nextView=sb.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(nextView, animated: true)
//        self.navigationController?.popViewController(animated: true)
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
